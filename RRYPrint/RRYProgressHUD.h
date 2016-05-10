//
//  RRYProgressHUD.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "LBProgressHUD.h"

@interface RRYProgressHUD : LBProgressHUD

+ (void)showProgressHUDWithTip:(NSString *)tip inView:(UIView *)view afterDelay:(NSTimeInterval)delay;
+ (void)showProgressHUDWithTip:(NSString *)tip inView:(UIView *)view animated:(BOOL)animated;
+ (void)hide;

@end
