//
//  RRYAdsScrollCell.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//  首页广告轮播单元格

#import "RRYAdsScrollCell.h"
#import "SDCycleScrollView/SDCycleScrollView.h"

@interface RRYAdsScrollCell ()

@property (nonatomic, strong) SDCycleScrollView *adsScroll;
@property (nonatomic, strong) UIView *separatorLine;

@end

@implementation RRYAdsScrollCell
{
    BOOL isExecution;
}

- (void)setupSubViews
{
    self.adsScroll = [[SDCycleScrollView alloc] initWithFrame:self.bounds];
    self.adsScroll.imageURLStringsGroup = @[@"https://onevcat.com/assets/images/2015/multitasking-1.jpg", @"https://onevcat.com/assets/images/2015/multitasking-2.jpg"];
    [self addSubview:self.adsScroll];
    
    self.separatorLine = [[UIView alloc] init];
    [self addSubview:self.separatorLine];
    self.separatorLine.backgroundColor = [UIColor lightGrayColor];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

+ (CGFloat)height
{
    return CATEGORYCELL_HEIGHT;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    if (!isExecution && self.bounds.size.height == CATEGORYCELL_HEIGHT) {
        [self setupSubViews];
        isExecution = YES;
    }
}

@end
