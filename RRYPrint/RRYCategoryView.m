//
//  RRYCategoryView.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//  首页分类按钮视图

#import "RRYCategoryView.h"


@interface RRYCategoryView ()

@property (nonatomic, strong) RRYBaseButton *cards; // 名片
@property (nonatomic, strong) RRYBaseButton *leafLets;  // 宣传单
@property (nonatomic, strong) RRYBaseButton *abulm; // 画册
@property (nonatomic, strong) RRYBaseButton *handBag;   // 手提袋
@property (nonatomic, strong) RRYBaseButton *discountBtn;

@end

@implementation RRYCategoryView

// 按钮点击
- (void)cardBtnDidClicked
{
    if ([self.delegate respondsToSelector:@selector(categoryView:cardBtnDidClicked:)]) {
        [self.delegate categoryView:self cardBtnDidClicked:self.cards];
    }
}

// 添加分类按钮到视图
- (void)setupSubViews
{
    self.cards = [[RRYBaseButton alloc] init];
    [self.cards setImage:[UIImage imageNamed:@"cardBtn"] forState:UIControlStateNormal];
    [self.cards addTarget:self action:@selector(cardBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cards];
    
    self.leafLets = [[RRYBaseButton alloc] init];
    [self.leafLets setImage:[UIImage imageNamed:@"DMBtn"] forState:UIControlStateNormal];
    [self addSubview:self.leafLets];
    
    self.abulm = [[RRYBaseButton alloc] init];
    [self.abulm setImage:[UIImage imageNamed:@"abulmBtn"] forState:UIControlStateNormal];
    [self addSubview:self.abulm];
    
    self.handBag = [[RRYBaseButton alloc] init];
    [self.handBag setImage:[UIImage imageNamed:@"handBagBtn"] forState:UIControlStateNormal];
    [self addSubview:self.handBag];
    
    self.discountBtn = [[RRYBaseButton alloc] init];
    [self.discountBtn setImage:[UIImage imageNamed:@"handBagBtn"] forState:UIControlStateNormal];
    [self addSubview:self.discountBtn];
}

- (void)setupSubViewsFrame
{
    // 布局
    [self.cards mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(PADDING_SMALL);
        make.top.equalTo(self.mas_top).with.offset(PADDING_SMALL);
        make.bottom.equalTo(self.mas_bottom).with.offset(-PADDING_SMALL);
        make.width.mas_equalTo(91);
    }];
    [self.handBag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cards.mas_right).with.offset(PADDING_SMALL);
        make.top.equalTo(self.mas_top).with.offset(PADDING_SMALL);
        make.size.mas_equalTo(CGSizeMake(50, 64));
    }];
    [self.abulm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cards.mas_right).with.offset(PADDING_SMALL);
        make.top.equalTo(self.handBag.mas_bottom).with.offset(PADDING_SMALL);
        make.size.mas_equalTo(self.handBag);
    }];
    [self.leafLets mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.handBag.mas_right).with.offset(PADDING_SMALL);
        make.top.equalTo(self.mas_top).with.offset(PADDING_SMALL);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    [self.discountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.abulm.mas_right).with.offset(PADDING_SMALL);
        make.top.equalTo(self.leafLets.mas_bottom).with.offset(PADDING_SMALL);
        make.size.mas_equalTo(self.leafLets);
    }];
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
    if (self.bounds.size.height == ADSSCROLL_HEIGHT) {
        [self setupSubViewsFrame];
    }
}

@end
