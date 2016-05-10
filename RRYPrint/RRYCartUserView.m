//
//  RRYCartUserView.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCartUserView.h"

@interface RRYCartUserView ()

@property (nonatomic, strong) UIImageView *avatar;


@end

@implementation RRYCartUserView

- (void)setupSubViews
{
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(24, 8, 48, 48)];
    self.avatar.backgroundColor = [UIColor purpleColor];
    self.avatar.layer.cornerRadius = 24;
    self.avatar.layer.masksToBounds = YES;
    [self addSubview:self.avatar];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self setupSubViews];
    }
    return self;
}

@end
