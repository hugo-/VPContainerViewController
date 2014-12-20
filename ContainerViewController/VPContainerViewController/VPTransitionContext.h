//
//  VPTransitionContext.h
//  ContainerViewController
//
//  Created by shengxi on 14/12/18.
//  Copyright (c) 2014年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPTransitionContext : NSObject <UIViewControllerContextTransitioning>
/**
 *  完成之后的回调
 */
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete);
/**
 *  是否动画
 */
@property (nonatomic, assign, getter=isAnimated) BOOL animated;
/**
 *  是否交互式
 */
@property (nonatomic, assign, getter=isInteractive) BOOL interactive;

/**
 *  快速初始化转场上下文
 *
 *  @param formVc     来源控制器
 *  @param toVc       去往控制器
 *  @param gonigRight 是否去右方的控制器
 *
 *  @return 转场上下文
 */
- (instancetype)initWithFromViewController:(UIViewController *)fromVc toViewController:(UIViewController *)toVc goingRight:(BOOL)goingRight;

@end
