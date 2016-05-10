//
//  AppDelegate.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/5.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark 初始化控制器

- (void)initWithControllers
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 加入roottabbarcontroller
    RRYRootTabBarController *rootTabBarVC = [[RRYRootTabBarController alloc] init];
    self.window.rootViewController = rootTabBarVC;
    
    // rootTabbarVC添加控制器
    // 主页控制器
    RRYHomeViewController *homeVC = [[RRYHomeViewController alloc] init];
    homeVC.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    homeVC.title = @"主页";
    UIImage *homeIcon = [UIImage imageNamed:@"home"];
    homeVC.tabBarItem.image = homeIcon;
    RRYBaseNavigationController *homeNavigationVC = [[RRYBaseNavigationController alloc]
                                                     initWithRootViewController:homeVC];
    
    // 购物车
    RRYCartViewController *cartVC = [[RRYCartViewController alloc] init];
    cartVC.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    cartVC.title = @"购物车";
    UIImage *cartIcon = [UIImage imageNamed:@"shopping_cart"];
    cartVC.tabBarItem.image = cartIcon;
    RRYBaseNavigationController *cartNavigationVC = [[RRYBaseNavigationController alloc]
                                                     initWithRootViewController:cartVC];
    
    // 用户信息
    RRYUserInfoViewController *userInfoVC = [[RRYUserInfoViewController alloc] init];
        userInfoVC.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    userInfoVC.title = @"我";
    UIImage *userIcon = [UIImage imageNamed:@"user"];
    userInfoVC.tabBarItem.image = userIcon;
    RRYBaseNavigationController *userInfoNavigationVC = [[RRYBaseNavigationController alloc]
                                                         initWithRootViewController:userInfoVC];
    
    [rootTabBarVC setViewControllers:@[homeNavigationVC, cartNavigationVC, userInfoNavigationVC]];
    
    [self.window makeKeyAndVisible];
}


#pragma mark - 生命周期
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initWithControllers];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
