//
//  RRYBaseView.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/7.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseView.h"

@implementation RRYBaseView

- (RRYBaseViewController *)viewController
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
