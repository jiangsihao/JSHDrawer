# JSHDrawer
JSHDrawer uses the ContentViewController to create a drawer effect,But the downside is that SideViewController will always be there, even if you can't see it.

![Demo](https://github.com/jiangsihao/JSHDrawer/blob/master/JSHDrawer.gif)

# Adding JSHDrawer to your project
Download Zip ,then drag and drop JSHDrawerManagerViewController.h and JSHDrawerManagerViewController.m onto your project. Include JSHDrawer wherever you need it with #import "JSHDrawerManagerViewController.h".

# Usage
**Initialize a JSHDrawerManagerViewController**

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
**Open Drawer**

1.First 
```
#import "JSHDrawerManagerViewController.h"
``` 
2.Then invoke
```
[JSHDrawerManagerViewController pushOpenDrawerNotification]; 
```
