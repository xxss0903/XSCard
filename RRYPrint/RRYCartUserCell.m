//
//  RRYCartUserCell.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCartUserCell.h"
#import "RRYCartUserView.h"

@interface RRYCartUserCell ()

@property (nonatomic, strong) RRYCartUserView *cartUserView;
@property (nonatomic, strong) UIView *separatorLine;

@end

@implementation RRYCartUserCell
{
    BOOL isExecution;
}

- (void)setupSubViews
{
    self.cartUserView = [[RRYCartUserView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.cartUserView];
    
    self.separatorLine = [[UIView alloc] init];
    [self.contentView addSubview:self.separatorLine];
    self.separatorLine.backgroundColor = [UIColor lightGrayColor];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.mas_equalTo(self).with.offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

+ (CGFloat)height
{
    return 64;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    if (!isExecution && self.bounds.size.height == [RRYCartUserCell height]) {
        [self setupSubViews];
        isExecution = YES;
    }
}

@end
