//
//  VPAnimator.m
//  ContainerViewController
//
//  Created by shengxi on 14/12/18.
//  Copyright (c) 2014年 shengxi. All rights reserved.
//

#import "VPAnimator.h"

@implementation VPAnimator

/**
 *  动画时间
 *
 *  @param transitionContext 转场上下文
 *
 *  @return 动画的时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

/**
 *  转场时的动画效果
 *
 *  @param transitionContext 转场上下文
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.animatorType) {
        case VPAnimatorTypeRight:
            [self animatorRightWithTransitionContext:transitionContext];
            break;
        case VPAnimatorTypeLeft:
            [self animatorLeftWithTransitionContext:transitionContext];
            break;
        case VPAnimatorTypeScale:
            [self animatorScaleWithTransitionContext:transitionContext];
            break;
        case VPAnimatorTypeTop:
            [self animatorTopWithTransitionContext:transitionContext];
            break;
        case VPAnimatorTypeBottom:
            [self animatorBottomWithTransitionContext:transitionContext];
            break;
        default:
            break;
    }
}

- (void)animatorRightWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取来源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取去往控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL goingRight = ([transitionContext initialFrameForViewController:toVc].origin.x < [transitionContext finalFrameForViewController:toVc].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.width;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (goingRight ? travelDistance : -travelDistance, 0);
    
    [[transitionContext containerView] addSubview:toVc.view];
    toVc.view.alpha = 0.5;
    toVc.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        fromVc.view.transform = travel;
        fromVc.view.alpha = 0.5;
        toVc.view.transform = CGAffineTransformIdentity;
        toVc.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVc.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animatorLeftWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取来源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取去往控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL goingLeft = ([transitionContext initialFrameForViewController:toVc].origin.x < [transitionContext finalFrameForViewController:toVc].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.width;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (goingLeft ? -travelDistance : travelDistance, 0);
    
    [[transitionContext containerView] addSubview:toVc.view];
    toVc.view.alpha = 0.5;
    toVc.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        fromVc.view.transform = travel;
        fromVc.view.alpha = 0.5;
        toVc.view.transform = CGAffineTransformIdentity;
        toVc.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVc.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animatorScaleWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取来源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取去往控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //添加到容器
    [[transitionContext containerView] addSubview:toVc.view];
    toVc.view.alpha = 0;
    
    //动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVc.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        toVc.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        //还原来源控制器的视图
        fromVc.view.transform = CGAffineTransformIdentity;
        
        //过渡结束声明
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animatorTopWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取来源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取去往控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL goingTop = ([transitionContext initialFrameForViewController:toVc].origin.x < [transitionContext finalFrameForViewController:toVc].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.height;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (0, goingTop ? -travelDistance : travelDistance);
    
    [[transitionContext containerView] addSubview:toVc.view];
    toVc.view.alpha = 0.5;
    toVc.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        fromVc.view.transform = travel;
        fromVc.view.alpha = 0.5;
        toVc.view.transform = CGAffineTransformIdentity;
        toVc.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVc.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animatorBottomWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取来源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取去往控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL goingBottom = ([transitionContext initialFrameForViewController:toVc].origin.x < [transitionContext finalFrameForViewController:toVc].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.height;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (0, goingBottom ? travelDistance : -travelDistance);
    
    [[transitionContext containerView] addSubview:toVc.view];
    toVc.view.alpha = 0.5;
    toVc.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        fromVc.view.transform = travel;
        fromVc.view.alpha = 0.5;
        toVc.view.transform = CGAffineTransformIdentity;
        toVc.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVc.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
