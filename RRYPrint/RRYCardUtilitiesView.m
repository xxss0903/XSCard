//
//  RRYCardUtilitiesView.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCardUtilitiesView.h"

@interface RRYCardUtilitiesView ()



@end

@implementation RRYCardUtilitiesView
- (void)setupSubViews
{
    self.uploadDemo = [[RRYBaseButton alloc] init];
    [self.uploadDemo setTitle:@"上传模版" forState:UIControlStateNormal];
    [self addSubview:self.uploadDemo];
    [self.uploadDemo addTarget:self action:@selector(uploadDidClicked)
              forControlEvents:UIControlEventTouchUpInside];
    
    self.printNow = [[RRYBaseButton alloc] init];
    [self.printNow setTitle:@"立即印刷" forState:UIControlStateNormal];
    [self addSubview:self.printNow];
    [self.printNow addTarget:self action:@selector(printNowDidClicked)
              forControlEvents:UIControlEventTouchUpInside];
    
    self.addView = [[RRYBaseButton alloc] init];
    [self.addView setTitle:@"添加控件" forState:UIControlStateNormal];
    [self addSubview:self.addView];
    [self.addView addTarget:self action:@selector(addViewsDidClicked)
              forControlEvents:UIControlEventTouchUpInside];
    
    // 改变名片正反
    self.changeCardFace = [[RRYBaseButton alloc] init];
    [self.changeCardFace setTitle:@"反面" forState:UIControlStateNormal];
    [self addSubview:self.changeCardFace];
    [self.changeCardFace addTarget:self action:@selector(changeCardFaceDidClicked)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)uploadDidClicked
{
    if ([self.delegate respondsToSelector:@selector(cardUtilitiesViewDidClickedUploadDemo:)]) {
        [self.delegate cardUtilitiesViewDidClickedUploadDemo:self];
    }
}

- (void)printNowDidClicked
{
    if ([self.delegate respondsToSelector:@selector(cardUtilitiesViewDidClickedPrintNow:)]) {
        [self.delegate cardUtilitiesViewDidClickedPrintNow:self];
    }
}

- (void)addViewsDidClicked
{
    if ([self.delegate respondsToSelector:@selector(cardUtilitiesViewDidClickedAddViews:)]) {
        [self.delegate cardUtilitiesViewDidClickedAddViews:self];
    }
}

- (void)changeCardFaceDidClicked
{
        NSLog(@"changeCardFaceDidClicked ...");
    if ([self.delegate respondsToSelector:@selector(cardUtilitiesViewDidClickedChangeCardFace:)]) {
        [self.delegate cardUtilitiesViewDidClickedChangeCardFace:self];
    }
}

- (void)setupSubViewsFrame
{
    [self.uploadDemo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(PADDING_SMALL);
        make.size.mas_equalTo(CGSizeMake(64, self.bounds.size.height));
    }];
    [self.printNow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.equalTo(self.uploadDemo);
        make.left.equalTo(self.uploadDemo.mas_right).with.offset(14);
    }];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.equalTo(self.uploadDemo);
        make.left.equalTo(self.printNow.mas_right).with.offset(14);
    }];
    [self.changeCardFace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.equalTo(self.uploadDemo);
        make.left.equalTo(self.addView.mas_right).with.offset(14);
    }];

}

#pragma mark - 系统方法
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor blueColor];
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
