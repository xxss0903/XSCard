//
//  UIView+GetController.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/12.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "UIView+GetController.h"

@implementation UIView (GetController)

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (RRYBaseViewController *)nextResponder;
        }
    }
    return nil;
}

@end
