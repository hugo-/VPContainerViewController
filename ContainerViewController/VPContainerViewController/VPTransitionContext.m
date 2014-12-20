//
//  VPTransitionContext.m
//  ContainerViewController
//
//  Created by shengxi on 14/12/18.
//  Copyright (c) 2014年 shengxi. All rights reserved.
//


#import "VPTransitionContext.h"

@interface VPTransitionContext ()

/**
 *  容器
 */
@property (nonatomic, weak) UIView *containerView;

/**
 *  动画样式
 */
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
/**
 *  控制器字典
 */
@property (nonatomic, strong) NSDictionary *viewControllersDict;
/**
 *  视图字典
 */
@property (nonatomic, strong) NSDictionary *viewsDict;
/**
 *  要消失视图的初始frame
 */
@property (nonatomic, assign) CGRect disappearingFromRect;
/**
 *  要显示视图的初始frame
 */
@property (nonatomic, assign) CGRect appearingFromRect;
/**
 *  要消失视图的结束frame
 */
@property (nonatomic, assign) CGRect disappearingToRect;
/**
 *  要显示视图的结束位置
 */
@property (nonatomic, assign) CGRect appearingToRect;

@end

@implementation VPTransitionContext

- (instancetype)initWithFromViewController:(UIViewController *)fromVc toViewController:(UIViewController *)toVc goingRight:(BOOL)goingRight
{
    if (self = [super init]) {
        self.containerView = fromVc.view.superview;
        self.presentationStyle = UIModalPresentationCustom;
        self.viewControllersDict = @{UITransitionContextFromViewControllerKey: fromVc,
            UITransitionContextToViewControllerKey: toVc};
        self.viewsDict = @{UITransitionContextFromViewKey: fromVc.view, UITransitionContextToViewKey: toVc.view};
        
        //偏移量
        CGFloat moveX = goingRight ? - self.containerView.bounds.size.width : self.containerView.bounds.size.width;
        self.disappearingFromRect = self.containerView.bounds;
        self.appearingToRect = self.containerView.bounds;
        self.disappearingToRect = CGRectOffset(self.containerView.bounds, moveX, 0);
        self.appearingFromRect = CGRectOffset(self.containerView.bounds, -moveX, 0);
    }
    return self;
}

/**
 *  初始状态视图所在位置
 */
- (CGRect)initialFrameForViewController:(UIViewController *)vc
{
    if (vc == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.disappearingFromRect;
    } else {
        return self.appearingFromRect;
    }
}

/**
 *  结束后视图所在位置
 */
- (CGRect)finalFrameForViewController:(UIViewController *)vc
{
    if (vc == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.disappearingToRect;
    } else {
        return self.appearingToRect;
    }
}

/**
 *  完成转场之后的回调
 */
- (void)completeTransition:(BOOL)didComplete
{
    if (self.completionBlock) {
        self.completionBlock(didComplete);
    }
}

/**
 *  根据key获取视图
 */
- (UIView *)viewForKey:(NSString *)key
{
    return self.viewsDict[key];
}

- (CGAffineTransform)targetTransform
{
    return CGAffineTransformIdentity;
}

/**
 *  根据key获取控制器
 */
- (UIViewController *)viewControllerForKey:(NSString *)key
{
    return self.viewControllersDict[key];
}

#pragma mark - 交互需要实现的方法
- (BOOL)transitionWasCancelled
{
    //非交互式的
    return NO;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    
}
- (void)finishInteractiveTransition
{
    
}
- (void)cancelInteractiveTransition
{
    
}

@end
