//
//  RRYFont.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/12.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseModel.h"

@interface RRYFont : RRYBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, strong) UIColor *color;

@end
