//
//  AppDelegate.m
//  JSHDrawer
//
//  Created by 姜斯豪 on 2018/6/5.
//  Copyright © 2018年 姜斯豪. All rights reserved.
//

#import "AppDelegate.h"
#import "JSHDrawerManagerViewController.h"
#import "SideViewController.h"
#import "MainTabbarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SideViewController *sideViewController = [[SideViewController alloc] initWithNibName:NSStringFromClass([SideViewController class]) bundle:nil];
    MainTabbarViewController *mainTabbarViewController = [[MainTabbarViewController alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width*0.8;
    JSHDrawerManagerViewController *drawerManagerViewController = [[JSHDrawerManagerViewController alloc] initWithSideViewController:sideViewController andContentViewController:mainTabbarViewController widthOfSideViewController:width];
    self.window.rootViewController = drawerManagerViewController;
    [self.window makeKeyAndVisible];
    return YES;
}





@end
