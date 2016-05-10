//
//  RRYFont.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/12.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYFont.h"

@implementation RRYFont

- (instancetype)init
{
    if (self = [super init]) {
        self.name = @"Heiti SC";
        self.size = 14;
        self.color = [UIColor blackColor];
    }
    return self;
}

@end
