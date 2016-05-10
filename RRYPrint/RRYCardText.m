//
//  RRYCardText.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/14.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCardText.h"
#import "RRYCardTextEditor.h"

@interface RRYCardText () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIMenuController *menuController;
@property (nonatomic, strong) RRYFont *localFont;

@end

@implementation RRYCardText
{
    CGPoint startPoint;
}

#pragma mark - 自定义方法

/**
 *  添加手势
 */
- (void)addGesture
{
    // 拖动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:pan];
}

/**
 *  手势响应方法
 *
 *  @param gesture 拖动手势
 */
- (void)handlePan:(UIPanGestureRecognizer *)gesture
{

    CGPoint newCenter = CGPointMake([gesture translationInView:self.superview].x + self.center.x - self.superview.bounds.size.width / 2,
                                    [gesture translationInView:self.superview].y + self.center.y - self.superview.bounds.size.height / 2);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(newCenter).priorityLow();
        make.left.greaterThanOrEqualTo(self.superview);
        make.top.greaterThanOrEqualTo(self.superview);
        make.bottom.right.lessThanOrEqualTo(self.superview);
    }];
    [gesture setTranslation:CGPointZero inView:self.superview];
}

/**
 *  初始化menucontroller
 */
- (void)showMenuController
{
    self.menuController = [UIMenuController sharedMenuController];
    //    // uimenuitem
    UIMenuItem *edit = [[UIMenuItem alloc] initWithTitle:@"编辑" action:@selector(editText)];
    UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteText)];
    
    [self.menuController setMenuItems:@[edit, delete]];
    
    CGPoint location = self.center;
    CGRect menuLocation = CGRectMake(location.x, location.y, 0, 0);
    [self.menuController setTargetRect:menuLocation inView:self];
    self.menuController.arrowDirection = UIMenuControllerArrowDown;
    //
    [self.menuController setMenuVisible:YES animated:YES];
}

/**
 *  设置字体
 *
 *  @param font 字体
 */
- (void)setLocalFont:(RRYFont *)font
{
    self.font = [UIFont fontWithName:font.name size:font.size];
    self.textColor = font.color;
    [self endEditing:YES];
}

/**
 *  MenuController编辑文本
 */
- (void)editText
{
    // 添加文本编辑视图
    RRYCardTextEditor *textEditor = [RRYCardTextEditor sharedTextEditor];
    [self endEditing:YES];
    textEditor.frame = CGRectMake(0, SCREEN_SIZE.height/2, SCREEN_SIZE.width, SCREEN_SIZE.height/2);
    [textEditor passTextFont:^(RRYFont *font) { // 用block传值
        [self setLocalFont:font];
        [self adjustTextFieldLength];
    }];
    
    textEditor.backgroundColor = [UIColor lightGrayColor];
    textEditor.text = self;
    [[self viewController].view addSubview:textEditor];
}

/**
 *  MenuController删除文本
 */
- (void)deleteText
{
    [self removeFromSuperview];
}

/**
 *  重新校正textfield的rect
 */
- (void)adjustTextFieldLength
{
    CGPoint textOrigin = self.frame.origin;
    CGSize textSize = [self.text zl_stringSizeWithFont:self.font];
    self.frame = CGRectMake(textOrigin.x, textOrigin.y, textSize.width, textSize.height);
    [self setNeedsDisplay];
}

#pragma mark 代理方法
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 * 设置能够显示的方法
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(editText) || action == @selector(deleteText) ||
        action == @selector(copy:) || action == @selector(select:)) {
        return YES;
    }
    return NO;
}

#pragma mark 文本框代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self adjustTextFieldLength];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!textField.text.length) {
        [self removeFromSuperview];
    }
    [self adjustTextFieldLength];
}

#pragma mark - 系统方法
- (instancetype)init
{
    if (self = [super init]) {
        [self addGesture];
        self.delegate = self;
        [self showMenuController];
    }
    return self;
}

@end
