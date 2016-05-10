//
//  RRYCartCell.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCartCell.h"

@interface RRYCartCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *orderCount;
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UIView *separatorLine;
@property (nonatomic, strong) UIButton *check;

@end

@implementation RRYCartCell
{
    BOOL isExecution;
    NSInteger ordered;
}

#pragma mark - 自定义方法
/**
 *  返回单元格高度
 *
 *  @return 单元格高度
 */
+ (CGFloat)height
{
    return 100;
}

/**
 *  初始化子控件
 */
- (void)setupSubViews
{
    // 图片
    self.image = [[UIImageView alloc] init];
    self.image.image = [UIImage imageNamed:@"goodsImage"];
    [self.contentView addSubview:self.image];
    
    // 名称
    self.name = [[UILabel alloc] init];
    self.name.backgroundColor = [UIColor blueColor];
    self.name.text = @"购物车货品名称";
    self.name.font = [UIFont systemFontOfSize:NORMALFONT_SIZE];
    [self.contentView addSubview:self.name];
    
    // 售价
    self.price = [[UILabel alloc] init];
    self.price.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.price];
    
    // 订单数量
    self.orderCount = [[UILabel alloc] init];
    self.orderCount.textAlignment = NSTextAlignmentCenter;
    self.orderCount.text = [NSString stringWithFormat:@"%ld", ordered];
    self.orderCount.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.orderCount];
    
    // 加
    self.plusBtn = [[UIButton alloc] init];
    [self.plusBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [self.plusBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.plusBtn];
    
    // 减
    self.minusBtn = [[UIButton alloc] init];
    [self.minusBtn setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [self.minusBtn addTarget:self action:@selector(minusBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.minusBtn];
    
    // 选中
    self.check = [[UIButton alloc] init];
    [self.check addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.check setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    [self.check setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.check];
    
    // 选中
    
    // 分割线
    self.separatorLine = [[UIView alloc] init];
    [self.contentView addSubview:self.separatorLine];
    self.separatorLine.backgroundColor = [UIColor lightGrayColor];

}

/**
 *  子控件frame
 */
- (void)setupSubViewsFrame
{
    // 自动布局
    // 图片
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(PADDING_LARGE);
        make.top.equalTo(self.mas_top).with.offset(PADDING_LARGE);
        make.size.mas_equalTo(CGSizeMake(110, 60));
    }];
    // 名称
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).with.offset(PADDING_SMALL);
        make.top.equalTo(self.image.mas_top);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    // 减号
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).with.offset(PADDING_SMALL);
        make.bottom.equalTo(self.mas_bottom).with.offset(-3*PADDING_SMALL);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    // 订单数量
    [self.orderCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.minusBtn.mas_right).with.offset(PADDING_SMALL/2);
        make.centerY.equalTo(self.minusBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(29, 18));
    }];
    // 减号
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderCount.mas_right).with.offset(PADDING_SMALL/2);
        make.centerY.equalTo(self.minusBtn.mas_centerY);
        make.size.equalTo(self.minusBtn);
    }];
    // 售价
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-6*PADDING_SMALL);
        make.bottom.equalTo(self.minusBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(32, 20));
    }];
    [self.check mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-PADDING_SMALL);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.mas_equalTo(self).with.offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)addBtnClicked:(id)sender
{
    ++ordered;
    self.orderCount.text = [NSString stringWithFormat:@"%ld", ordered];
    if ([self.orderCount.text integerValue] > 0) {
        [self.minusBtn setEnabled:YES];
    }
}

- (void)minusBtnClicked:(id)sender
{
    --ordered;
    self.orderCount.text = [NSString stringWithFormat:@"%ld", ordered];
    if ([self.orderCount.text integerValue] == 0) {
        [self.minusBtn setEnabled:NO];
    }
}

- (void)checkBtnClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

#pragma mark - 系统方法
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
    self.bounds = CGRectMake(0, 0, SCREEN_SIZE.width, 100);
    if (!isExecution && self.bounds.size.height == [RRYCartCell height]) {
        [self setupSubViewsFrame];
        isExecution = YES;
    }
}

@end
