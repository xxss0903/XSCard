//
//  RRYCardEditorController.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//  名片编辑器

#import "RRYCardEditorController.h"
#import "RRYCardDisplayView.h"
#import "RRYCardEditorView.h"
#import "RRYCardUtilitiesView.h"
#import "RRYCard.h"
#import "RRYCardModel.h"
#import "RRYCardTemplate.h"

@interface RRYCardEditorController () <RRYCardDisplayDelegate, RRYCardUtilitiesViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) RRYCardDisplayView *cardDisplay;
@property (nonatomic, strong) RRYCardEditorView *cardEditor;
@property (nonatomic, strong) RRYCardUtilitiesView *utilities;

@end

@implementation RRYCardEditorController

#pragma mark - 初始化
/**
 *  子控件
 */
- (void)setupSubViews
{
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
    //
    self.cardDisplay = [[RRYCardDisplayView alloc] init];
    [self.view addSubview:self.cardDisplay];
    self.cardDisplay.delegate = self;
    
    self.utilities = [[RRYCardUtilitiesView alloc] init];
    [self.view addSubview:self.utilities];
    self.utilities.delegate = self;
    self.utilities.hidden = YES;
    
    [self setupSubViewsFrame];
}

- (void)setupSubViewsFrame
{
    [self.utilities mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(49);
    }];
    [self.cardDisplay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(NAVIBAR_HEIGHT);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark 设置模型数据
- (void)setCardTemplate:(RRYCardTemplate *)cardTemplate
{
    _cardTemplate = cardTemplate;
    self.title = cardTemplate.TemplateName;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:cardTemplate.TemplateNumber forKey:@"id"];  // 请求参数
    [RRYNetworkTool get:kGetTemplate andParam:param success:^(NSDictionary *response) {
        
        // 名片模版字典转模型
        RRYCardModel *cardModel = [RRYCardModel cardModelWithDict:response];
        self.cardDisplay.cardModel = cardModel;
        
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}


#pragma mark 处理点击手势
- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    self.utilities.hidden = !self.utilities.hidden;
}

#pragma mark - 代理方法
// 名片正反面改变
- (void)cardDisplayExchangeCard:(RRYCardDisplayView *)cardDisplay
{
    if (self.cardDisplay.isFront) {
        [self.utilities.changeCardFace setTitle:@"反面" forState:UIControlStateNormal];
    } else {
        [self.utilities.changeCardFace setTitle:@"正面" forState:UIControlStateNormal];
    }
}
// 增加文字／logo子视图
- (void)cardUtilitiesViewDidClickedAddViews:(RRYCardUtilitiesView *)cardUtilities
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"插入子视图"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"logo", @"文本", @"切换背景",nil];
    [actionSheet showInView:self.view];
}
// 改变名片正反面
- (void)cardUtilitiesViewDidClickedChangeCardFace:(RRYCardUtilitiesView *)cardUtilities
{
    [self.cardDisplay exchangeCardPage];
    

}
// 立即印刷
- (void)cardUtilitiesViewDidClickedPrintNow:(RRYCardUtilitiesView *)cardUtilities
{
    // 测试保存名片
    [self saveCard];
}

/**
 *  保存名片到图片
 */
- (void)saveCard
{
    // 提示
    LBProgressHUD *hud = [LBProgressHUD showHUDto:self.view animated:YES];
    [hud setTipText:@"正在保存"];
    //  将view上的子view加进来
    CGSize imageSize = self.cardDisplay.cardFront.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale); // 防止保存的图片失真
    
    [self.cardDisplay.cardFront.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);

    [hud hide:YES];
}

// 上传模版
- (void)cardUtilitiesViewDidClickedUploadDemo:(RRYCardUtilitiesView *)cardUtilities
{

}

#pragma mark actionsheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"添加一个logo");
            }
                break;
                
            case 1:
            {
                NSLog(@"添加文本");
                [self.cardDisplay.currentFace addText:@"测试"];
            }
                break;
                
            case 2:
            {
                NSLog(@"切换背景");
                NSLog(@"%@", self.cardDisplay.currentFace.baseImage);
            }
                break;
                
            default:
                break;
        }
    }

}

#pragma mark - 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"正面";
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupSubViews];
    }
    return self;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    self.utilities.hidden = !self.utilities.hidden;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
