//
//  RRYTemplateList.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseModel.h"

@interface RRYTemplateList : RRYBaseModel

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *orderby;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)templateListWithDict:(NSDictionary *)dict;

@end
