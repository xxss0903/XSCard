//
//  RRYCardTextEditor.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/9.
//  Copyright © 2016年 rry. All rights reserved.
//  文本的编辑器，单例

#import "RRYCardTextEditor.h"
#import "RRYCardEditorController.h"
#import "RRYCard.h"
#import "RRYCardTextField.h"
#import "RRYColorPickerView.h"
#import "RRYCardText.h"

@interface RRYCardTextEditor () <UITextFieldDelegate >

@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UITextField *sizeText;

@property (nonatomic, strong) UILabel *fontLabel;
@property (nonatomic, strong) UIButton *colorBtn;
@property (nonatomic, strong) __block UIButton *fontBtn;

@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (strong, nonatomic) NSString *errorMessage;
@property (nonatomic, strong) NSMutableArray *fonts;

@property (nonatomic, strong) NSArray *familys; // 系统字体库

@property (nonatomic, strong) RRYColorPickerView *colorPicker;

@property (nonatomic, strong) RRYFont *originFont;  // 保存原始font

@end

static RRYCardTextEditor *_instance;

@implementation RRYCardTextEditor


#pragma mark 数组兰加载
- (void)setupArray
{
    _familys = [[NSArray alloc] init];
    _familys = [UIFont familyNames];
    
    _fonts = [NSMutableArray array];
    // 获取fonts.plist中的字体
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Fonts" ofType:@"plist"];
    NSArray *selfFonts = [NSArray arrayWithContentsOfFile:path];
    
    [_fonts addObjectsFromArray:self.familys];
    [_fonts addObjectsFromArray:selfFonts];
}

#pragma mark 按钮点击事件
// 确认文本编辑，传递字体
- (void)okBtnDidClicked
{
    [self removeFromSuperview];
}

/**
 *  取消文本编辑，恢复字体
 */
- (void)cancelBtnDidClicked
{
    // 恢复字体
    [self copyFont:self.originFont toFont:self.font];
    [self setTextFont];
    [self removeFromSuperview];
}

/**
 *  拷贝两个font
 *
 *  @param font   拷贝的字体
 *  @param toFont 拷贝到字体
 */
- (void)copyFont:(RRYFont *)font toFont:(RRYFont *)toFont
{
    toFont.size = font.size;
    toFont.color = font.color;
    toFont.name = font.name;
}

/**
 *  颜色选择器弹出
 */
- (void)colorBtnDidClicked
{
    self.colorPicker = [[RRYColorPickerView alloc] init];
    self.colorPicker.color = self.font.color;
    [self.colorPicker passColor:^(UIColor *color) {
        NSLog(@"block pass color ");
        [self.colorBtn setBackgroundColor:color];   //
        self.font.color = color;
        [self setTextFont];
    }];
    
    self.colorPicker.frame = self.superview.bounds;
    [self.superview addSubview:self.colorPicker];

}

/**
 *  设置字体颜色
 */
- (void)colorPickerDidAction:(HRColorPickerView *)colorPicker
{
    self.font.color = colorPicker.color;
    [self setTextFont];
}

/**
 *  点击字体设置actionsheet
 */
- (void)fontBtnDidClicked
{
    __block NSInteger fontIndex = 0;
    NSLog(@"font btn clicked ...");
    
    [self.fonts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.font.name isEqualToString:obj]) {
            fontIndex = idx;
            *stop = YES;
        }
    }];

    ActionSheetStringPicker *fontPicker = [[ActionSheetStringPicker alloc] initWithTitle:@"字体"
                                                                                    rows:self.fonts
                                                                        initialSelection:fontIndex
                                                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                   dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                                                       // 处理耗时操作的代码块...
                                                                                       NSLog(@"开始下载文字 ");
                                                                                       if (![self isFontDownloaded:selectedValue]) {
                                                                                           [self downloadFontWithFontName:selectedValue];
                                                                                       }
                                                                                       //通知主线程刷新
                                                                                       dispatch_async(dispatch_get_main_queue(), ^{  
                                                                                           //回调或者说是通知主线程刷新，
                                                                                           NSLog(@"设置字体 ");
                                                                                           self.font.name = selectedValue;
                                                                                           [self.fontBtn setTitle:selectedValue forState:UIControlStateNormal];
                                                                                           [self setTextFont];
                                                                                       });
                                                                                       
                                                                                   });
                                                                                   
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self];
    
    [fontPicker showActionSheetPicker];
}

/**
 *  确认设定字体 Font
 */
- (void)setTextFont
{
    if (_fontBlock) {
        _fontBlock(self.font);
    }
}

#pragma mark 字体测试
// 判断字体是否已经下载
- (BOOL)isFontDownloaded:(NSString *)fontName {
    UIFont* aFont = [UIFont fontWithName:fontName size:12.0];
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame
                  || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    } else {
        return NO;
    }
}

// 下载字体
- (void)downloadFontWithFontName:(NSString *)fontName
{
    // 已经下载则返回
    if ([self isFontDownloaded:fontName]) {
        return;
    }
    // 设置参数
        // Create a dictionary with the font's PostScript name.
        NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
        
        // Create a new font descriptor reference from the attributes dictionary.
        CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
        
        NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
        [descs addObject:(__bridge id)desc];
        CFRelease(desc);
        
    __block BOOL errorDuringDownload = NO;
    // 开始下载
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
        NSLog(@"downloading font %@", [NSThread currentThread]);
        
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            NSLog(@" 字体已经匹配 ");
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            if (!errorDuringDownload) {
                NSLog(@" 字体 %@ 下载完成 ", fontName);

                
            }
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            NSLog(@" 字体开始下载 ");
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            NSLog(@" 字体下载完成 ");
            
            dispatch_async( dispatch_get_main_queue(), ^ {
                // 可以在这里修改 UI 控件的字体
                
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            NSLog(@" 下载进度 %.0f%% ", progressValue);
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                _errorMessage = [error description];
            } else {
                _errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // 设置标志
            errorDuringDownload = YES;
            NSLog(@" 下载错误: %@", _errorMessage);
        }
        
        return (BOOL)YES;
    });
}

// 用block传递字体
- (void)passTextFont:(FontBlock)block
{
    _fontBlock = block;
}

#pragma mark 代理方法
/**
 *  字体大小文本框结束输入则改变字体大小
 *
 *  @param textField 字号文本框
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.sizeText) {
        self.font.size = [textField.text floatValue];
        [self setTextFont];
    }
}

#pragma mark 初始化
- (void)setupSubViews
{
    NSLog(@"setupSubViews ");
    // 初始化字体
    self.font = [[RRYFont alloc] init];
    self.originFont = [[RRYFont alloc] init];
    // 取消按钮
    self.cancelBtn = [[UIButton alloc] init];
    self.cancelBtn.backgroundColor = [UIColor orangeColor];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnDidClicked)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    // 确认按钮
    self.okBtn = [[UIButton alloc] init];
    self.okBtn.backgroundColor = [UIColor orangeColor];
    [self.okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.okBtn addTarget:self action:@selector(okBtnDidClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.okBtn];
    
    // 其他
    // 颜色标签
    self.colorLabel = [[UILabel alloc] init];
    [self addSubview:self.colorLabel];
    self.colorLabel.font = DEFAULT_FONT;
    self.colorLabel.text = @"颜色:";
    
    // 字号标签
    self.sizeLabel = [[UILabel alloc] init];
    self.sizeLabel.text = @"字号:";
    [self addSubview:self.sizeLabel];
    self.sizeLabel.font = DEFAULT_FONT;
    
    // 字号文本框
    self.sizeText = [[UITextField alloc] init];
    [self addSubview:self.sizeText];
    self.sizeText.delegate = self;
    self.sizeText.font = DEFAULT_FONT;
//    self.sizeText.text = @"14";

    
    // 字体标签
    self.fontLabel = [[UILabel alloc] init];
    self.fontLabel.text = @"字体:";
    [self addSubview:self.fontLabel];
    self.fontLabel.font = DEFAULT_FONT;
    
    // 颜色按钮
    self.colorBtn = [[UIButton alloc] init];
    [self.colorBtn addTarget:self action:@selector(colorBtnDidClicked)
            forControlEvents:UIControlEventTouchUpInside];
    self.colorBtn.backgroundColor = [UIColor redColor];
    [self addSubview:self.colorBtn];
    
    // 字体按钮
    self.fontBtn = [[UIButton alloc] init];

    [self.fontBtn addTarget:self action:@selector(fontBtnDidClicked)
           forControlEvents:UIControlEventTouchUpInside];
    self.fontBtn.backgroundColor = [UIColor redColor];
    [self addSubview:self.fontBtn];
    
    [self setupSubViewsFrame];
    
    // 初始化数组
    [self setupArray];
}

- (void)setupSubViewsFrame
{
    // 确认按钮
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width/2, 48));
    }];
    // 取消按钮
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.okBtn.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self);
        make.height.mas_equalTo(48);
    }];
    // 颜色标签
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(PADDING_LARGE);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(self.okBtn.mas_bottom).with.offset(PADDING_LARGE);
    }];
    // 字号标签
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(PADDING_LARGE);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(self.colorLabel.mas_bottom).with.offset(PADDING_LARGE);
    }];
    // 字体标签
    [self.fontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(PADDING_LARGE);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(self.sizeLabel.mas_bottom).with.offset(PADDING_LARGE);
    }];
    // 颜色按钮
    [self.colorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.colorLabel.mas_right).with.offset(PADDING_LARGE);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(self.okBtn.mas_bottom).with.offset(PADDING_LARGE);
    }];
    // 字号按钮
    [self.sizeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sizeLabel.mas_right).with.offset(PADDING_LARGE);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(self.colorBtn.mas_bottom).with.offset(PADDING_LARGE);
    }];
    // 字体按钮
    [self.fontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fontLabel.mas_right).with.offset(PADDING_LARGE);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(self.sizeText.mas_bottom).with.offset(PADDING_LARGE);
    }];
}

/**
 *  设置字体font
 */
- (void)setText:(RRYCardText *)text
{
    _text = text;
    self.font.size = text.font.pointSize;
    self.font.color = text.textColor;
    self.font.name = text.font.fontName;
    
    self.originFont.size = self.font.size;
    self.originFont.color = self.font.color;
    self.originFont.name = self.font.name;
    
    self.sizeText.text = [NSString stringWithFormat:@"%.1f", text.font.pointSize];
    [self.colorBtn setBackgroundColor:text.textColor];
    [self.fontBtn setTitle:text.font.fontName forState:UIControlStateNormal];
}

/**
 *  获取单例
 *
 *  @return 返回单例
 */
+ (instancetype)sharedTextEditor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [_instance setupSubViews];
    });
    return _instance;
}

#pragma mark - 系统方法

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.colorPicker removeFromSuperview];
    [self endEditing:YES];
}

@end
