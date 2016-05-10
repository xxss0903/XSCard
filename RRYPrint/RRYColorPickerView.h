//
//  RRYColorPickerView.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/13.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseView.h"
@class RRYCardTextEditor;

typedef void(^colorBlock)(UIColor *color);

@interface RRYColorPickerView : RRYBaseView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) RRYCardTextEditor *textEditor;
@property (nonatomic, copy) colorBlock block;

- (void)passColor:(colorBlock)color;

@end
