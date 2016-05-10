//
//  RRYProductTypeList.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseModel.h"

@interface RRYProductTypeList : RRYBaseModel

@property (nonatomic, copy) NSString *typename;
@property (nonatomic, copy) NSString *typecode;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *desc; // 产品描述

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)productTypeListWithDict:(NSDictionary *)dict;

@end
