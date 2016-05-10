//
//  RRYCartViewController.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCartViewController.h"
#import "RRYCartCell.h"
#import "RRYCartUserCell.h"

@interface RRYCartViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *cartTableView;
@property (nonatomic, strong) UILabel *orderCount;
@property (nonatomic, strong) UILabel *orderPrice;
@property (nonatomic, strong) UIView *cartDealView;

@end

@implementation RRYCartViewController

#pragma mark - 自定义方法
- (void)setupSubViews
{
    // 购物车table
    self.cartTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.cartTableView.dataSource = self;
    self.cartTableView.delegate = self;
    [self.view addSubview:self.cartTableView];
    
    // 购物车物品统计，价格和数量
    self.cartDealView = [[UILabel alloc] init];
    self.cartDealView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.cartDealView];
    [self.view bringSubviewToFront:self.cartDealView];
    [self.cartDealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-BOTTOMTAB_HEIGHT);
        make.height.mas_equalTo(BOTTOMTAB_HEIGHT);
    }];
}

#pragma mark - 数据源/代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    return cell;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        RRYCartUserCell *cell = [[RRYCartUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        return cell;
    } else {
        RRYCartCell *cell = [[RRYCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       return [RRYCartUserCell height];
    } else {
       return [RRYCartCell height];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//    }
}

#pragma mark - 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setupSubViews];
}

@end
