//
//  RRYTemplateList.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYTemplateList.h"

@implementation RRYTemplateList

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)templateListWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) { // description重名，用这个方法避免
        _desc = value;
    }
}

@end
