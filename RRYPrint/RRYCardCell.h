//
//  RRYCardCell.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseCollectionViewCell.h"
@class RRYCardCell;

typedef void (^passSizeBlock)(CGSize size, RRYCardCell *cell);

@class RRYCardTemplate;
@class RRYCardModel;

@interface RRYCardCell : RRYBaseCollectionViewCell

@property (nonatomic, strong) RRYCardModel *card;
@property (nonatomic, strong) RRYCardTemplate *cardTemplate;

@property (nonatomic, copy) passSizeBlock block;
- (void)passSize:(passSizeBlock)block;

@end
