//
//  RRYCardSingleFace.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/14.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseModel.h"

@class RRYCardTextModel;

@interface RRYCardSingleFace : RRYBaseModel

@property (nonatomic, copy) NSString *Background;
@property (nonatomic, copy) NSString *DocumentNumber;
@property (nonatomic, strong) NSMutableArray *ImagesArray;
@property (nonatomic, assign) NSInteger Number;
@property (nonatomic, copy) NSString *PDF;
@property (nonatomic, strong) NSMutableArray *TextsArray;
@property (nonatomic, copy) NSString *Thumb;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cardSingleFaceWithDict:(NSDictionary *)dict;

@end
