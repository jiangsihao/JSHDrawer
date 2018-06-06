//
//  MainTabbarViewController.m
//  JSHDrawer
//
//  Created by 姜斯豪 on 2018/6/5.
//  Copyright © 2018年 姜斯豪. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "MessageViewController.h"
#import "LinkmanViewController.h"
#import "LifeViewController.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewControllers];
}

- (void)addViewControllers {
    MessageViewController *messageVC = [MessageViewController new];
    LinkmanViewController *linkmanVC = [LinkmanViewController new];
    LifeViewController *lifeVC = [LifeViewController new];
    
    messageVC.tabBarItem.title = @"消息";
    messageVC.tabBarItem.image = [UIImage imageNamed:@"message"];
    messageVC.tabBarItem.selectedImage = [UIImage imageNamed:@"message"];
    
    linkmanVC.tabBarItem.title = @"联系人";
    linkmanVC.tabBarItem.image = [UIImage imageNamed:@"linkman"];
    linkmanVC.tabBarItem.selectedImage = [UIImage imageNamed:@"linkman"];
    
    lifeVC.tabBarItem.title = @"动态";
    lifeVC.tabBarItem.image = [UIImage imageNamed:@"friends"];
    lifeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"friends"];
    
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageVC];
    UINavigationController *linkmanNav = [[UINavigationController alloc] initWithRootViewController:linkmanVC];
    UINavigationController *lifeNav = [[UINavigationController alloc] initWithRootViewController:lifeVC];
    
    self.viewControllers = @[messageNav,linkmanNav,lifeNav];
}
@end
