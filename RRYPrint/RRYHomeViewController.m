//
//  RRYHomeViewController.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//  主页

#import "RRYHomeViewController.h"
#import "RRYCategoryView.h"
#import "RRYAdsScrollCell.h"
#import "RRYProductTypeList.h"

typedef enum {
    cellTypeADsScroll = 0,
    cellTypeCategory
}cellType;

@interface RRYHomeViewController () <UITableViewDataSource, UITableViewDelegate, RRYCategoryViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;   // 主页面的tableview
@property (nonatomic, strong) SDCycleScrollView *adsScrollView; // 广告轮播器
@property (nonatomic, strong) RRYCategoryView *categoryView; // 子分类按钮的视图
@property (nonatomic, strong) __block NSMutableArray *productList;

@end

@implementation RRYHomeViewController

#pragma mark - 设置子控件
// 初始化子控件
- (void)setupSubViews
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self.view addSubview:self.mainTableView];
}

- (void)layoutSubViews
{
    
}

#pragma mark - tableview数据源/代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case cellTypeADsScroll:
            return [RRYAdsScrollCell height];
            break;
        case cellTypeCategory:
            return [RRYCategoryCell height];
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    switch (indexPath.row) {
        case cellTypeADsScroll: // 广告轮播器
        {
             RRYAdsScrollCell *cell = [[RRYAdsScrollCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:nil];
            return cell;
        }
            break;
        case cellTypeCategory: // 子分类按钮
        {
            RRYCategoryCell *cell = [[RRYCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:nil];
            cell.categoryView.delegate = self;
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

#pragma mark categoryView代理方法
// 进入名片瀑布流
- (void)categoryView:(RRYCategoryView *)categoryView cardBtnDidClicked:(id)sender
{
    RRYCardsWaterFallController *cardsWaterFall = [[RRYCardsWaterFallController alloc] init];
    [self.navigationController pushViewController:cardsWaterFall animated:YES];
}

#pragma -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    
}

@end
