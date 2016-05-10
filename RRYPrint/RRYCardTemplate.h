//
//  RRYCardTemplate.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//  名片瀑布流模版数据模型

#import "RRYBaseModel.h"

@interface RRYCardTemplate : RRYBaseModel

@property (nonatomic, copy) NSString *TemplateName;
@property (nonatomic, copy) NSString *TemplateNumber;
@property (nonatomic, copy) NSString *TemplateThumb;
@property (nonatomic, assign) __block CGSize cardSize;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cardTemplateWithDict:(NSDictionary *)dict;

@end
