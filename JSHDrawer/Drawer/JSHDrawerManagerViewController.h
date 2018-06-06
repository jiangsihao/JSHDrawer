//
//  JSHDrawerManagerViewController.h
//  JSHDrawer
//
//  Created by 姜斯豪 on 2018/6/5.
//  Copyright © 2018年 姜斯豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSHDrawerManagerViewController : UIViewController
/**
 抽屉控制器初始化

 @param sideViewController 侧边栏
 @param contentViewController 主内容控制器
 @return 抽屉控制器实例
 @param width 侧边栏的宽度
 */
- (instancetype)initWithSideViewController:(UIViewController *)sideViewController andContentViewController:(UIViewController *)contentViewController widthOfSideViewController:(CGFloat)width;

/**
 发送打开抽屉的通知
 */
+ (void)pushOpenDrawerNotification;

@end
