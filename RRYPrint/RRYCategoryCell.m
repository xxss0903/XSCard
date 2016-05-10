//
//  RRYHomeCategoryCell.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//  首页分类单元格

#import "RRYCategoryCell.h"
#import "RRYCategoryView.h"

@interface RRYCategoryCell ()

@property (nonatomic, strong) UIView *separatorLine;

@end

@implementation RRYCategoryCell
{
    CGFloat height;
    BOOL isExecution;
}


// 初始化子控件
- (void)setupSubViews
{
    self.categoryView = [[RRYCategoryView alloc] init];
    [self addSubview:self.categoryView];
    
    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.separatorLine];
}

- (void)setupSubViewsFrame
{
    self.categoryView.frame = self.bounds;
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

// 返回单元格高度
+ (CGFloat)height
{
    return ADSSCROLL_HEIGHT;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
