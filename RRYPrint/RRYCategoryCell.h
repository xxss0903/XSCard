//
//  RRYHomeCategoryCell.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseTableViewCell.h"
@class RRYCategoryView;

@interface RRYCategoryCell : RRYBaseTableViewCell

@property (nonatomic, strong) RRYCategoryView *categoryView;


+ (CGFloat)height;

@end
