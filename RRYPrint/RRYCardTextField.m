//
//  RRYCardTextField.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/9.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCardTextField.h"
#import "RRYCardTextEditor.h"
#import "RRYCard.h"

@interface RRYCardTextField ()

//@property (nonatomic, strong) RRYCardTextEditor *textEditor;


@end

@implementation RRYCardTextField
#pragma mark 系统方法
//- (void)setLocalFont:(RRYFont *)localFont
//{
//    _localFont = localFont;
//    self.font = [UIFont fontWithName:localFont.name size:localFont.size];
//    self.textColor = localFont.color;
//    [self adjustTextFieldLength];
//    [self setNeedsDisplay];
//}
//
//- (instancetype)init
//{
//    if (self = [super init]) {
//        self.font = DEFAULT_FONT;
//    }
//    return self;
//}
//
//- (void)showMenuController
//{
////    UIMenuItem *showEditor = [[UIMenuItem alloc] initWithTitle:@"编辑" action:@selector(showTextEditorView)];
//    UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteCurrentView)];
//    
//    UIMenuController *menuController = [UIMenuController sharedMenuController];
//    [menuController setMenuItems:@[showEditor, delete]];
//    
//    CGPoint location = self.center;
//    CGRect menuLocation = CGRectMake(location.x, location.y, 0, 0);
//    [menuController setTargetRect:menuLocation inView:self];
//    menuController.arrowDirection = UIMenuControllerArrowDown;
//    
//    [menuController setMenuVisible:YES animated:YES];
//}

#pragma mark 代理方法


#pragma mark menuitem自定义

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(showTextEditorView) || action == @selector(deleteCurrentView)) {
//        return YES;
//    }
//    return NO;
//}
//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

/**
 *  删除当前视图
 */
//- (void)deleteCurrentView
//{
//    [self removeFromSuperview];
//}
//
///**
// *  重新校正textfield的rect
// */
//- (void)adjustTextFieldLength
//{
//    CGPoint textOrigin = self.frame.origin;
//    CGSize textSize = [self.text zl_stringSizeWithFont:self.font];
//    self.frame = CGRectMake(textOrigin.x, textOrigin.y, textSize.width, textSize.height);
//}


//// 添加文本编辑视图
//- (void)showTextEditorView
//{
//    [self endEditing:YES];
//    // 改文本之后移除之前的文本编辑器
//    [self.card.textEditor removeFromSuperview];
//        // 在控制器中调出文本编辑器
//    RRYBaseViewController *controller = (RRYBaseViewController *)[self viewController];
//    self.textEditor = [[RRYCardTextEditor alloc] init];
//    self.textEditor.currentText = self;
//    
//    self.textEditor.frame = CGRectMake(0, SCREEN_SIZE.height/2, SCREEN_SIZE.width, SCREEN_SIZE.height/2);
//    self.textEditor.backgroundColor = [UIColor lightGrayColor];
//    [controller.view addSubview:self.textEditor];
//    [controller.view bringSubviewToFront:self.textEditor];
//}

@end
