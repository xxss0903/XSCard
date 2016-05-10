//
//  RRYCardDisplayView.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseView.h"
@class RRYCard;
@class RRYCardDisplayView;
@class RRYCardModel;

@protocol RRYCardDisplayDelegate <NSObject>

- (void)cardDisplayExchangeCard:(RRYCardDisplayView *)cardDisplay;

@end

@interface RRYCardDisplayView : RRYBaseView

@property (nonatomic, strong) RRYCardModel *cardModel;  // 名片模型
@property (nonatomic, strong) RRYCard *cardFront;    // 名片正面
@property (nonatomic, strong) RRYCard *cardBack;    // 名片背面
@property (nonatomic, strong) RRYCard *currentFace; // 当前在名片正面／背面

@property (nonatomic, assign) BOOL isFront;

@property (nonatomic, strong) id<RRYCardDisplayDelegate> delegate;
// 改变名片正反页面
- (void)exchangeCardPage;

@end
