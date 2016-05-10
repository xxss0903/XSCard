//
//  RRYUserInfoViewController.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYUserInfoViewController.h"
#import "RRYMineTable.h"
#import "RRYUserInfoUserCell.h"
#import "RRYUserInfoCartBtnCell.h"
#import "RRYLoginController.h"

@interface RRYUserInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) RRYMineTable *mineTable;

@end

@implementation RRYUserInfoViewController

#pragma mark - 自定义方法
/**
 *  初始化子控件
 */
- (void)setupSubViews
{
    // table
    self.mineTable = [[RRYMineTable alloc] init];
    self.mineTable.dataSource = self;
    self.mineTable.delegate = self;
    [self.view addSubview:self.mineTable];
    
    // 头像用户信息栏
    
    
    
    [self setupSubViewsFrame];
}

- (void)setupSubViewsFrame
{
    self.mineTable.frame = self.view.bounds;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    switch (indexPath.section) {
        case 0:
        {
            RRYUserInfoUserCell *cell = [[RRYUserInfoUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

            return cell;
        }
            break;
        case 1:
        {
            RRYUserInfoCartBtnCell *cell = [[RRYUserInfoCartBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            return cell;
        }
            break;
            
        default:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            return cell;
        }
            break;
    }
    
    
    

}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            // 选中用户信息那栏，如果没有登陆则进入登录控制器
            RRYLoginController *loginVC = [[RRYLoginController alloc] init];
            [self presentViewController:loginVC animated:YES completion:^{
                
            }];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setupSubViews];
}

@end
