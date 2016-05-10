//
//  RRYCardModel.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/14.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCardModel.h"
#import "RRYCardSingleFace.h"

@implementation RRYCardModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cardModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"Pages"]) {
        self.PagesArray = [NSMutableArray array];
        for (NSDictionary *dict in value) {
            RRYCardSingleFace *singleFace = [RRYCardSingleFace cardSingleFaceWithDict:dict];
            [self.PagesArray addObject:singleFace];
        }
    }
}

@end
