//
//  RRYCardsWaterFallController.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//  名片瀑布流

#import "RRYCardsWaterFallController.h"
#import "RRYCardCell.h"
#import "RRYCardHeaderView.h"
#import "RRYCardFooterView.h"
#import "RRYCardEditorController.h"
#import "RRYCardTemplate.h"
#import "RRYCardModel.h"

#import <MJRefresh/MJRefreshAutoStateFooter.h>

#define CELL_IDENTIFIER @"collction_cell"
#define HEADER_IDENTIFIER @"header"
#define FOOTER_IDENTIFIER @"footer"

@interface RRYCardsWaterFallController () <UICollectionViewDataSource, UICollectionViewDelegate,
                                            CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cardTemplates;


@end

@implementation RRYCardsWaterFallController
{
    BOOL isConnected;
    NSInteger currentPage;
}

#pragma mark - 自定义方法

/**
 *  初始化子控件
 */
- (void)setupSubViews
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 初始化 collectionview
    CGRect collectionFrame = CGRectMake(0, NAVIBAR_HEIGHT, SCREEN_SIZE.width, SCREEN_SIZE.height-NAVIBAR_HEIGHT);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 设置mj刷新
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
    [footer setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"加载完成" forState:MJRefreshStateNoMoreData];
    self.collectionView.mj_footer = footer;
//    self.collectionView.mj_footer.hidden = YES;
    
    // collectionView注册cell
    [self.collectionView registerClass:[RRYCardCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER]; // 注册单元格方法
    [self.collectionView registerClass:[RRYCardHeaderView class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:HEADER_IDENTIFIER];   // 注册头视图方法
    [self.collectionView registerClass:[RRYCardFooterView class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:FOOTER_IDENTIFIER];   // 注册尾视图方法

    // 请求网络数据
    currentPage = 1;
    [self requestCardTemplatesWithPageIndex:currentPage andID:14 andOrderBy:@"Default"];
}

- (void)setupSubViewsFrame
{
    
}

// 初始化数组
- (void)initialArray
{
    self.cardTemplates = [NSMutableArray array];
}

/**
 *  请求模版数据
 */
- (void)requestCardTemplates
{
    [RRYProgressHUD showProgressHUDWithTip:@"正在请求数据！" inView:self.view animated:YES];

    // 请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[NSNumber numberWithInteger:14] forKey:@"tid"];
    [param setValue:[NSNumber numberWithInteger:3] forKey:@"pageIndex"];
    [param setValue:@"Default" forKey:@"orderby"];
    
    // 获取产品模版
    [RRYNetworkTool get:kGetTemplateList andParam:param success:^(NSDictionary *response) {
        NSDictionary *templates = [response objectForKey:@"Templates"];
        for (NSDictionary *dict in templates) {
            RRYCardTemplate *template = [RRYCardTemplate cardTemplateWithDict:dict];
            [self.cardTemplates addObject:template];
        }
        [self.collectionView reloadData];

        [RRYProgressHUD hide];
    } failure:^(NSError *error) {
        [RRYProgressHUD hide];
        [RRYProgressHUD showProgressHUDWithTip:@"网络错误！" inView:self.view animated:YES];
        NSLog(@"request error %@", error);
        [RRYProgressHUD hide];
    }];
}

// 自带参数的请求
- (void)requestCardTemplatesWithPageIndex:(NSInteger)pageIndex andID:(NSInteger)tid andOrderBy:(NSString *)orderBy
{
    [RRYProgressHUD showProgressHUDWithTip:@"正在请求数据！" inView:self.view animated:YES];
    
    // 请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[NSNumber numberWithInteger:tid] forKey:@"tid"];
    [param setValue:[NSNumber numberWithInteger:pageIndex] forKey:@"pageIndex"];
    [param setValue:@"Default" forKey:@"orderby"];
    
    // 获取产品模版
    [RRYNetworkTool get:kGetTemplateList andParam:param success:^(NSDictionary *response) {
        NSDictionary *templates = [response objectForKey:@"Templates"];
        for (NSDictionary *dict in templates) {
            RRYCardTemplate *template = [RRYCardTemplate cardTemplateWithDict:dict];
            [self.cardTemplates addObject:template];
        }
        
        
        [self.collectionView reloadData];
        
        [RRYProgressHUD hide];
    } failure:^(NSError *error) {
        [RRYProgressHUD hide];
        [RRYProgressHUD showProgressHUDWithTip:@"网络错误！" inView:self.view animated:YES];
        NSLog(@"request error %@", error);
        [RRYProgressHUD hide];
    }];
}

// 上拉刷新，加载更多模版
- (void)loadMoreData:(id)sender
{
    [self performSelector:@selector(endRefresh:) withObject:sender afterDelay:2.0f];

    // 请求下一页数据
    ++currentPage;
    NSLog(@"上拉刷新，加载更多数据.page = %ld", currentPage);

    [self requestCardTemplatesWithPageIndex:currentPage andID:14 andOrderBy:@"Default"];
    
}

- (void)endRefresh:(id)sender
{
    MJRefreshFooter *footer = sender;
    [footer endRefreshing];
}

#pragma mark collectionView数据源方法
// 一组单元格的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.cardTemplates.count;
//    return 20;
}

// 多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    RRYCardCell *cell = (RRYCardCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
//    // 设置名片模型数据
    RRYCardTemplate *template = self.cardTemplates[indexPath.row];
    cell.cardTemplate = template;
    // 获取图片
    NSString *imageStr = [NSString stringWithFormat:@"%@/upload/design/tplfiles/Thumbs/%@",kUrlBase, template.TemplateThumb];
    NSURL *imageUrl = [NSURL URLWithString:imageStr];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager diskImageExistsForURL:imageUrl completion:^(BOOL isInCache) {
        [UIView animateWithDuration:0.3f animations:^{
            [self.collectionView.collectionViewLayout invalidateLayout];
        }];
        
        UIImage *imageCache = [[manager imageCache] imageFromDiskCacheForKey:imageStr];
        CGSize tempSize = CGSizeMake(cell.bounds.size.width, (imageCache.size.height/imageCache.size.width)*cell.bounds.size.width);
        cell.cardTemplate.cardSize = tempSize;
        
    }];

    return cell;
}

#pragma mark - collectionview代理方法
/**
 *  点击名片
 *
 *  @param collectionView 瀑布流
 *  @param indexPath      瀑布流index
 */
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RRYCardEditorController *cardEditor = [[RRYCardEditorController alloc] init];
    
    // 点击进入名片编辑器
    RRYCardTemplate *template = self.cardTemplates[indexPath.row];
    cardEditor.cardTemplate = template;

    [self.navigationController pushViewController:cardEditor animated:YES];
}

#pragma mark - CHTCollectionview代理
// 返回单元格大小，因为宽度已经固定了，所以设置的长宽是现在的长宽的比值
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RRYCardTemplate *template = self.cardTemplates[indexPath.row];

    if (!CGSizeEqualToSize(template.cardSize, CGSizeZero)) {
        return template.cardSize;
    }

    return CGSizeMake(150, 150);
}

#pragma mark 系统方法
- (instancetype)init
{
    if (self = [super init]) {
            self.view.backgroundColor = [UIColor whiteColor];
            self.hidesBottomBarWhenPushed = YES;
            self.automaticallyAdjustsScrollViewInsets = NO;
            [self initialArray];
            [self setupSubViews];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)dealloc
{
    NSLog(@"销毁了 ");
}

@end
