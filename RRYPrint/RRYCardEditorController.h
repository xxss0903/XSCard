//
//  RRYCardEditorController.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseViewController.h"

@class RRYCardModel;
@class RRYCardTemplate;

@interface RRYCardEditorController : RRYBaseViewController

@property (nonatomic, strong) RRYCardModel *cardModel;
@property (nonatomic, strong) RRYCardTemplate *cardTemplate;


@end
