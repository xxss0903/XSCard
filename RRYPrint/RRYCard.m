//
//  RRYCard.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCard.h"
#import "RRYCardTextField.h"
#import "RRYCardTextEditor.h"
#import "RRYCardText.h"
#import "RRYCardModel.h"
#import "RRYCardSingleFace.h"
#import "RRYCardTextModel.h"

typedef enum {
    actionSheetDelete = 0,
    actionSheetEdit
}actionSheetIndex;

@interface RRYCard () <UITextFieldDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate, UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;

@end

@implementation RRYCard
{
    BOOL isInit;
    CGPoint startPoint;
}


#pragma mark - 自定义方法
- (void)setupSubViews
{
    // 添加背景图片
    self.baseImage = [[UIImageView alloc] init];
    [self addSubview:self.baseImage];
    
    self.layer.cornerRadius = CARD_CORNERRADIUS;
    self.layer.masksToBounds = YES;
}

- (void)setupSubViewsFrame
{
    self.baseImage.frame = self.bounds;
    
}

// 添加子视图
- (void)addText:(NSString *)textStr
{
    RRYCardText *text = [[RRYCardText alloc] init];
    
    [self addSubview:text];
    text.frame = CGRectMake(100, 20, 100, 20);
    text.text = [NSString stringWithFormat:@"%@", textStr];
}

// 根据文本模型添加文本到名片
- (void)addTextWithTextModel:(RRYCardTextModel *)textModel
{
    RRYCardText *text = [RRYCardText new];
    [self addSubview:text];
    
    CGRect textFrame = CGRectMake(textModel.Left, textModel.Top, textModel.Width, textModel.Height);
    text.frame = textFrame;
    if ([textModel.VAlignValue isEqualToString:@"middle"]) {
        text.textAlignment = NSTextAlignmentCenter;
    }
    
    text.text = textModel.Text;
    if ([textModel.FontWeight isEqualToString:@"Normal"]) {
        text.font = [UIFont systemFontOfSize:textModel.FontSize weight:FontWeightNormal];
    } else {
        text.font = [UIFont systemFontOfSize:textModel.FontSize weight:FontWeightBig];
    }
}



// 设置字体
- (void)setFont:(RRYFont *)font
{
    _font = font;
    RRYCardTextField *text = (RRYCardTextField *)self.currentView;
    text.font = [UIFont fontWithName:font.name size:font.size];
    text.textColor = font.color;
    [text setTextColor:font.color];
    
//    [text adjustTextFieldLength];
    self.currentView = text;
}

/**
 *  设置名片模型
 *
 *  @param cardModel 单页名片模型
 */
- (void)setCardModel:(RRYCardSingleFace *)cardModel
{
    _cardModel = cardModel;
    
    for (RRYCardTextModel *textModel in cardModel.TextsArray) {
//        [self addText:textModel.Text];
        [self addTextWithTextModel:textModel];
    }
}


// 手势识别代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark 物体碰撞代理方法
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{

}

#pragma mark - 系统方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (![touch.view isKindOfClass:[UITextField class]]) {
        for (RRYCardTextField *text in self.subviews) {

            [text endEditing:YES];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.bounds.size.height > 0 && !isInit) {
        [self setupSubViewsFrame];
        isInit = YES;
    }
}

- (void)drawRect:(CGRect)rect
{
    
}

@end
