//
//  RRYCardUtilitiesView.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseView.h"
@class RRYCardUtilitiesView;

@protocol RRYCardUtilitiesViewDelegate <NSObject>

- (void)cardUtilitiesViewDidClickedUploadDemo:(RRYCardUtilitiesView *)cardUtilities;
- (void)cardUtilitiesViewDidClickedPrintNow:(RRYCardUtilitiesView *)cardUtilities;
- (void)cardUtilitiesViewDidClickedAddViews:(RRYCardUtilitiesView *)cardUtilities;
- (void)cardUtilitiesViewDidClickedChangeCardFace:(RRYCardUtilitiesView *)cardUtilities;

@end

@interface RRYCardUtilitiesView : RRYBaseView

@property (nonatomic, assign) BOOL isShowing;

@property (nonatomic, strong) RRYBaseButton *uploadDemo;
@property (nonatomic, strong) RRYBaseButton *printNow;
@property (nonatomic, strong) RRYBaseButton *addView;
@property (nonatomic, strong) RRYBaseButton *changeCardFace;   //

@property (nonatomic, strong) id<RRYCardUtilitiesViewDelegate> delegate;


@end
