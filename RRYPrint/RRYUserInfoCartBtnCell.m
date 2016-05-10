//
//  RRYUserInfoCartBtnCell.m
//  RRYPrint
//
//  Created by j on 16/4/29.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYUserInfoCartBtnCell.h"
#define BTN_COUNT 3

@interface RRYUserInfoCartBtnCell ()

@property (nonatomic, strong) RRYBaseButton *waitForPaying;
@property (nonatomic, strong) RRYBaseButton *waitForSending;
@property (nonatomic, strong) RRYBaseButton *waitForCommenting;

@end


@implementation RRYUserInfoCartBtnCell


- (void)setupSubViews
{
    CGSize cellSize = self.bounds.size;
    
    
    self.waitForPaying = [[RRYBaseButton alloc] init];
    [self.waitForPaying addTarget:self action:@selector(waitForPayingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitForPaying setTitle:@"等待付款" forState:UIControlStateNormal];
    [self.waitForPaying setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.waitForPaying];
    self.waitForPaying.frame = CGRectMake(0, 0, cellSize.width / BTN_COUNT, cellSize.height);
    
    self.waitForSending = [[RRYBaseButton alloc] init];
    [self.waitForPaying addTarget:self action:@selector(waitForSendingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitForSending setTitle:@"等待送货" forState:UIControlStateNormal];
    [self.waitForSending setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.waitForSending];
    self.waitForSending.frame = CGRectMake(cellSize.width/BTN_COUNT, 0, cellSize.width/BTN_COUNT, cellSize.height);
    
    self.waitForCommenting = [[RRYBaseButton alloc] init];
    [self.waitForCommenting addTarget:self action:@selector(waitForCommentingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitForCommenting setTitle:@"等待评论" forState:UIControlStateNormal];
    [self.waitForCommenting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.waitForCommenting];
    self.waitForCommenting.frame = CGRectMake(2*cellSize.width/BTN_COUNT, 0, cellSize.width/BTN_COUNT, cellSize.height);
    
}

- (void)setupSubViewsFrame
{
    
}

- (void)waitForPayingBtnClicked:(id)sender
{
    
}

- (void)waitForSendingBtnClicked:(id)sender
{
    
}

- (void)waitForCommentingBtnClicked:(id)sender
{
    
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
