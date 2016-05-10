//
//  RRYUserInfoUserCell.m
//  RRYPrint
//
//  Created by j on 16/4/29.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYUserInfoUserCell.h"

@interface RRYUserInfoUserCell ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *userName;

@end

@implementation RRYUserInfoUserCell

- (void)setupSubViews
{
    self.avatar = [[UIImageView alloc] init];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 46/2;
    self.avatar.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.avatar];
    
    self.userName = [[UILabel alloc] init];
    self.userName.text = @"用户名";
    [self.contentView addSubview:self.userName];
    
    
    [self setupSubViewsFrame];
}

- (void)setupSubViewsFrame
{
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(14);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(PADDING_SMALL);
        make.top.equalTo(self.contentView.mas_top).with.offset(PADDING_SMALL);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
