//
//  RRYCategoryView.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseView.h"
@class RRYCategoryView;

@protocol RRYCategoryViewDelegate <NSObject>

- (void)categoryView:(RRYCategoryView *)categoryView cardBtnDidClicked:(id)sender;

@end

@interface RRYCategoryView : RRYBaseView

@property (nonatomic, strong) id<RRYCategoryViewDelegate> delegate;


@end
