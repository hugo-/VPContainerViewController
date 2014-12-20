//
//  AppDelegate.m
//  ContainerViewController
//
//  Created by shengxi on 14/12/17.
//  Copyright (c) 2014年 shengxi. All rights reserved.
//

#import "AppDelegate.h"
#import "VPContainerViewController.h"
#import "VPChildViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[self rootViewController]];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (UIViewController *)rootViewController {
    
    NSArray *childViewControllers = [self childViewControllers];
    VPContainerViewController *rootViewController = [[VPContainerViewController alloc] initWithViewControllers:childViewControllers];
  
    rootViewController.noramlBackgroundImage = [UIImage imageNamed:@"recommend_btn_normal"];
    rootViewController.selectedBackgroundImage = [UIImage imageNamed:@"recommend_btn_high"];
    rootViewController.topHeight = 40.0;
    rootViewController.selectedColor = [UIColor redColor];
    rootViewController.animated = YES;
    rootViewController.animatorType = VPAnimatorTypeTop;
    rootViewController.title = @"转场动画";
    
    return rootViewController;
}

- (NSArray *)childViewControllers {
    
    NSMutableArray *childViewControllers = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (int i = 0; i < 10; i++) {
        VPChildViewController *childViewController = [[VPChildViewController alloc] init];
        
        childViewController.title = [NSString stringWithFormat:@"视图%d", i + 1];
        [childViewControllers addObject:childViewController];
    }
    
    return childViewControllers;
}

@end
