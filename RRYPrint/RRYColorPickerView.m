//
//  RRYColorPickerView.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/13.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYColorPickerView.h"

@interface RRYColorPickerView ()

@property (nonatomic, strong) HRColorPickerView *colorPicker;
@property (nonatomic, strong) UIButton *doneBtn;

@end


@implementation RRYColorPickerView

- (void)setupSubViews
{
    self.colorPicker = [[HRColorPickerView alloc] init];
    [self addSubview:self.colorPicker];
    [self.colorPicker.brightnessSlider setBrightnessLowerLimit:[NSNumber numberWithFloat:0.0f]];
    [self addSubview:self.colorPicker];
    
    self.doneBtn = [[UIButton alloc] init];
    [self.doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.doneBtn setBackgroundColor:self.color];
    [self.doneBtn addTarget:self action:@selector(doneBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.doneBtn];
}

- (void)setupSubViewsFrame
{
    [self.colorPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top).with.offset(NAVIBAR_HEIGHT*2);
    }];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.colorPicker.mas_top);
        make.top.equalTo(self.mas_top).with.offset(NAVIBAR_HEIGHT);
    }];
}

- (void)passColor:(colorBlock)color
{
    _block = color;
}

/**
 *  设置颜色
 */
- (void)doneBtnDidClicked
{
    self.color = self.colorPicker.color;
    if (_block) {
        _block(self.color);
    }
    
    [self removeFromSuperview];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    
    if ([self.color isEqual:[UIColor blackColor]]) {
        self.colorPicker.color = [UIColor whiteColor];
    } else {
        self.colorPicker.color = self.color;
    }
}

- (void)layoutSubviews
{
    if (self.bounds.size.height) {
        [self setupSubViewsFrame];
    }
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self setupSubViews];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
