# JSHDrawer
JSHDrawer 使用ContentViewController创建了一个抽屉侧滑效果，集成方便，轻量级。

![Demo](https://github.com/jiangsihao/JSHDrawer/blob/master/JSHDrawer.gif)

# 添加JSHDrawer到工程
下载Zip，将JSHDrawerManagerViewController.h和JSHDrawerManagerViewController.m文件拖拽进项目，使用时导入头文件即可。

# 用法
**初始化JSHDrawerManagerViewController**

```
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
```
**打开抽屉**

1.第一步导入头文件
```
#import "JSHDrawerManagerViewController.h"
``` 
2.第二步调用
```
[JSHDrawerManagerViewController pushOpenDrawerNotification]; 
```
# [我的简书](https://www.jianshu.com/u/5fd033346950)
