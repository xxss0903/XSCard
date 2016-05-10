//
//  RRYCardTextModel.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/14.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseModel.h"

typedef enum {
    FontWeightNormal = 0,
    FontWeightBig = 1
} FontWeight ;


@interface RRYCardTextModel : RRYBaseModel

@property (nonatomic, copy) NSString *CMYKColor;
@property (nonatomic, copy) NSString *FontName;
@property (nonatomic, assign) CGFloat FontSize;
@property (nonatomic, copy) NSString *FontStyle;
@property (nonatomic, copy) NSString *FontWeight;
@property (nonatomic, copy) NSString *HAlignType;
@property (nonatomic, copy) NSString *HAlignValue;
@property (nonatomic, assign) CGFloat Height;
@property (nonatomic, assign) CGFloat Left;
@property (nonatomic, assign) CGFloat MultiLine;
@property (nonatomic, copy) NSString *RGBColor;
@property (nonatomic, copy) NSString *Text;
@property (nonatomic, copy) NSString *TextDirection;
@property (nonatomic, assign) NSInteger TextTag;
@property (nonatomic, assign) CGFloat Top;
@property (nonatomic, copy) NSString *VAlignType;
@property (nonatomic, copy) NSString *VAlignValue;
@property (nonatomic, assign) CGFloat Width;
@property (nonatomic, assign) CGFloat WordSpace;
@property (nonatomic, assign) NSInteger ZIndex;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cardTextModelWithDict:(NSDictionary *)dict;

@end
