//
//  RRYCardDisplayView.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//  名片展示view

#import "RRYCardDisplayView.h"
#import "RRYCard.h"
#import "RRYCardModel.h"

@interface RRYCardDisplayView  ()

@property (nonatomic, strong) UISwipeGestureRecognizer *swipe;  // 滑动手势
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation RRYCardDisplayView
{
    CGFloat initialPoint;
}

- (void)setupSubViews
{
    // 默认正面显示，背面隐藏
    self.isFront = YES;
    self.currentFace = [[RRYCard alloc] init];
    
    self.cardFront = [[RRYCard alloc] init];
    [self addSubview:self.cardFront];
    self.cardFront.baseImage.image = [UIImage imageNamed:@"frontBaseImage"];
    self.cardBack = [[RRYCard alloc] init];
    [self addSubview:self.cardBack];
    self.cardBack.hidden = YES;
    self.cardBack.baseImage.image = [UIImage imageNamed:@"backBaseImage"];
    
//    self.swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeTo:)];
//    self.swipe.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
//    [self addGestureRecognizer:self.swipe];
    
    self.currentFace = self.cardFront;  // 当前默认页面为正面
}

- (void)setupSubViewsFrame
{
    [self.cardFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(self.bounds.size.width);
        make.height.mas_equalTo(self.bounds.size.height/2);
    }];
    [self.cardBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(self.bounds.size.width);
        make.height.mas_equalTo(self.bounds.size.height/2);
    }];
}

// 滑动跳转正反面
- (void)swipeTo:(UISwipeGestureRecognizer *)swipeGesture
{
    
    
    [self exchangeCardPage];
    
}

// 改变名片正反页面
- (void)exchangeCardPage
{
    self.cardFront.hidden = !self.cardFront.hidden;
    self.cardBack.hidden = !self.cardBack.hidden;
    self.isFront = !self.isFront;
    
    if (self.isFront) {
        self.currentFace = self.cardFront;
    } else {
        self.currentFace = self.cardBack;
    }
    
    // 执行滑动代理
    if ([self.delegate respondsToSelector:@selector(cardDisplayExchangeCard:)]) {
        [self.delegate cardDisplayExchangeCard:self];
    }
}

// 设置名片模型
- (void)setCardModel:(RRYCardModel *)cardModel
{
    _cardModel = cardModel;
    self.cardFront.cardModel = cardModel.PagesArray[0];
    self.cardBack.cardModel = cardModel.PagesArray[1];
}

#pragma mark 动画
- (void)testAnimation
{
    //
    CGFloat angle;  // 旋转的角度
    angle = 10;
    CATransform3D transform = CATransform3DIdentity;    // 标准仿射变换矩阵
    transform.m34 = 4.5/-2000;  // 3d运动时的透视效果
    
    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    
    CGPoint location = [self.pan locationInView:self]; // 获取pan手势的坐标

    if (self.pan.state == UIGestureRecognizerStateBegan) {
        // 刚开始拖动
        initialPoint = location.x;
    }
    
    if ([[self.cardFront.layer valueForKeyPath:@"transform.rotation.y"] floatValue] > -M_PI_2 && [[self.cardFront.layer valueForKeyPath:@"transform.rotation.x"] floatValue] != 0) {
        self.cardFront.alpha = 1.0f;
        
        CGFloat opacity = (location.x - initialPoint) / (CGRectGetWidth(self.bounds) - initialPoint);
        self.cardBack.layer.opacity = fabs(opacity)*0.5f;
    } else if ([[self.cardFront.layer valueForKeyPath:@"transform.rotation.y"] floatValue] > M_PI_2 && ([[self.cardFront.layer valueForKeyPath:@"transform.rotation.y"] floatValue] < 0 && [[self.cardFront.layer valueForKeyPath:@"transform.rotation.x"] floatValue] == 0)) {
        CGFloat opacity = (location.x - initialPoint) / (CGRectGetWidth(self.bounds) - initialPoint);
        
        self.cardFront.layer.opacity = fabs(opacity) * 0.5f;
        self.cardBack.layer.opacity = fabs(opacity) * 0.5f;
    }
    

}

#pragma mark - 系统方法
#pragma mark 拖动子控件

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.bounds.size.height > 0) {
        [self setupSubViewsFrame];
    }
}

@end
