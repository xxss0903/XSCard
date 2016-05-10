//
//  RRYCardSingleFace.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/14.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCardSingleFace.h"
#import "RRYCardTextModel.h"

@implementation RRYCardSingleFace

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cardSingleFaceWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"Texts"]) {
        self.TextsArray = [NSMutableArray array];
        for (NSDictionary *dict in value) {
            RRYCardTextModel *text = [RRYCardTextModel cardTextModelWithDict:dict];
            [self.TextsArray addObject:text];
        }
    }
    
    if ([key isEqualToString:@"Images"]) {
        
    }
}


@end
