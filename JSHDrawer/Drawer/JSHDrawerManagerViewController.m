//
//  JSHDrawerManagerViewController.m
//  JSHDrawer
//
//  Created by 姜斯豪 on 2018/6/5.
//  Copyright © 2018年 姜斯豪. All rights reserved.
//

#import "JSHDrawerManagerViewController.h"
///遮罩层最大alpha值
#define MAXALPHA 0.4f
///遮罩层最小alpha值
#define MINIMUMALPHA 0.0f
///Pan手势最大velocity
#define MAXVELOCITY 1000.0f
///Pan手势最小velocity
#define MINIMUMVELOCITY (-1000.0f)
///打开抽屉的通知名
#define OPENDRAWERNOTIFICATION @"OPENDRAWERNOTIFICATION"

@interface JSHDrawerManagerViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIViewController *sideViewController;
@property (nonatomic,strong) UIViewController *contentViewController;
@property (nonatomic,assign) CGFloat widthOfSideViewController;

@property (nonatomic,strong) UIView *maskViewOfContentViewController;
@property (nonatomic,strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation JSHDrawerManagerViewController

- (instancetype)initWithSideViewController:(UIViewController *)sideViewController andContentViewController:(UIViewController *)contentViewController widthOfSideViewController:(CGFloat)width {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        //添加contaienr
        self.sideViewController = sideViewController;
        [self addChildViewController:self.sideViewController];
        self.widthOfSideViewController = width;
        self.sideViewController.view.frame = CGRectMake(-self.widthOfSideViewController, 0, self.widthOfSideViewController, self.view.bounds.size.height);
        [self.view addSubview:self.sideViewController.view];
        self.contentViewController = contentViewController;
        [self addChildViewController:self.contentViewController];
        self.contentViewController.view.frame = self.view.bounds;
        [self.view addSubview:self.contentViewController.view];
        
        //为ContentViewController添加遮罩层
        self.maskViewOfContentViewController = [[UIView alloc] initWithFrame:self.view.bounds];
        self.maskViewOfContentViewController.backgroundColor = [UIColor blackColor];
        self.maskViewOfContentViewController.alpha = MINIMUMALPHA;
        [self.contentViewController.view addSubview:self.maskViewOfContentViewController];
        
        //为ContentViewController添加Tap手势
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideViewControllerByTap)];
        self.tapGestureRecognizer.enabled = NO;
        [self.contentViewController.view addGestureRecognizer:self.tapGestureRecognizer];
        
        //为ContentViewController添加Pan手势
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        self.panGestureRecognizer.delegate = self;
        [self.contentViewController.view addGestureRecognizer:self.panGestureRecognizer];
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openDrawerByNotification) name:OPENDRAWERNOTIFICATION object:nil];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"init method invoke exception" reason:@"please use:initWithSideViewController:andContentViewController:" userInfo:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:OPENDRAWERNOTIFICATION object:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


+ (void)pushOpenDrawerNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPENDRAWERNOTIFICATION object:nil userInfo:nil];
}


- (void)openDrawerByNotification {
    [self openSideViewController:0.25f];
}

//打开抽屉
- (void)openSideViewController:(NSTimeInterval)duration {
    __block CGRect frameOfSideViewController = self.sideViewController.view.frame;
    __block CGRect frameOfContentViewController = self.contentViewController.view.frame;
    [UIView animateWithDuration:duration animations:^{
        frameOfSideViewController.origin.x = 0.0f;
        frameOfContentViewController.origin.x = self.widthOfSideViewController;
        self.maskViewOfContentViewController.alpha = MAXALPHA;
        self.sideViewController.view.frame = frameOfSideViewController;
        self.contentViewController.view.frame = frameOfContentViewController;
        //激活Tap手势
        self.tapGestureRecognizer.enabled = YES;
    }];
}

//关闭抽屉
- (void)closeSideViewController:(NSTimeInterval)duration {
    __block CGRect frameOfSideViewController = self.sideViewController.view.frame;
    __block CGRect frameOfContentViewController = self.contentViewController.view.frame;
    [UIView animateWithDuration:duration animations:^{
        frameOfSideViewController.origin.x = -self.widthOfSideViewController;
        frameOfContentViewController.origin.x = 0.0f;
        self.maskViewOfContentViewController.alpha = MINIMUMALPHA;
        self.sideViewController.view.frame = frameOfSideViewController;
        self.contentViewController.view.frame = frameOfContentViewController;
        //关闭Tap手势
        self.tapGestureRecognizer.enabled = NO;
    }];
}

//通过Tap手势关闭抽屉
- (void)closeSideViewControllerByTap {
    [self closeSideViewController:0.25f];
}

//对Pan手势的处理
- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    //获取移动速度
    CGPoint velocity = [panGesture velocityInView:panGesture.view];
    if (velocity.x > 1000.0f && panGesture.state == UIGestureRecognizerStateEnded) {
        //打开
        [self openSideViewController:0.15f];
        return;
    }
    
    if (velocity.x < -1000.0f && panGesture.state == UIGestureRecognizerStateEnded) {
        //关闭
        [self closeSideViewController:0.15f];
        return;
    }
    
    //根据手势的位移距离改变Frame
    CGPoint translation = [panGesture translationInView:panGesture.view];
    [self changeFrameByTranslation:translation.x];
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    
    //手势状态的特殊处理
    if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateFailed) {
        CGRect frameOfSideViewController = self.sideViewController.view.frame;
        if (fabs(frameOfSideViewController.origin.x) <= (self.widthOfSideViewController*0.7)) {
            [self openSideViewController:.2f];
        }
        if (fabs(frameOfSideViewController.origin.x) > (self.widthOfSideViewController*0.7)) {
            [self closeSideViewController:.2f];
        }
    }
}

//根据Pan手势的位移距离改变视图的Frame
- (void)changeFrameByTranslation:(CGFloat)x {
    CGRect frameOfSideViewController = self.sideViewController.view.frame;
    CGRect frameOfContentViewController = self.contentViewController.view.frame;
    
    frameOfSideViewController.origin.x = frameOfSideViewController.origin.x + x;
    frameOfContentViewController.origin.x = frameOfContentViewController.origin.x + x;
    
    if (frameOfSideViewController.origin.x > 0 || frameOfSideViewController.origin.x < - self.widthOfSideViewController) {
        //打开抽屉的时候激活手势
        if (frameOfSideViewController.origin.x > 0) {
            self.tapGestureRecognizer.enabled = YES;
        }
        return;
    }
    
    self.sideViewController.view.frame = frameOfSideViewController;
    self.contentViewController.view.frame = frameOfContentViewController;
    
    //计算遮罩层的透明度
    CGFloat widthOfScreen = [UIScreen mainScreen].bounds.size.width;
    CGFloat value = (x / widthOfScreen)*(1/(self.widthOfSideViewController/widthOfScreen))*MAXALPHA;
    self.maskViewOfContentViewController.alpha = self.maskViewOfContentViewController.alpha + value;
}

#pragma makr - UIGestureRecognizerDelegate
//限定手势的作用范围
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
        if (point.x >= (gestureRecognizer.view.bounds.size.width*0.3)) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

@end
