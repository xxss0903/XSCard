//
//  RRYProgressHUD.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYProgressHUD.h"

@interface RRYProgressHUD ()

@property (nonatomic, strong) LBProgressHUD *hud;

@end

@implementation RRYProgressHUD

+ (void)showProgressHUDWithTip:(NSString *)tip inView:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    
}

- (void)showProgressHUDWithTip:(NSString *)tip inView:(UIView *)view animated:(BOOL)animated
{
    self.hud = [LBProgressHUD showHUDto:view animated:animated];
    self.hud.tipText = tip;
    [self.hud show:YES];
}

+ (void)showProgressHUDWithTip:(NSString *)tip inView:(UIView *)view animated:(BOOL)animated
{
    [[self sharedHUD] showProgressHUDWithTip:tip inView:view animated:animated];
}

- (void)hide
{
    [self.hud hide:YES];
}

+(void)hide
{
    [[self sharedHUD] hide];
}

+ (instancetype)sharedHUD
{
    static RRYProgressHUD *hud;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        hud = [[RRYProgressHUD alloc] init];
    });
    return hud;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.hud = [[LBProgressHUD alloc] init];
    }
    return self;
}

@end
