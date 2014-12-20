//
//  VPAnimator.h
//  ContainerViewController
//
//  Created by shengxi on 14/12/18.
//  Copyright (c) 2014年 shengxi. All rights reserved.
//


/**
 *  遵循UIViewControllerAnimatedTransitioning协议，实现必须实现的两个方法
 *  1）动画时间
 *  2）动画效果
 */
#import <UIKit/UIKit.h>

typedef enum {
    VPAnimatorTypeRight = 0,    //后续视图从右至左转场，默认
    VPAnimatorTypeLeft,         //后续视图从左至右转场
    VPAnimatorTypeScale,        //后续视图缩放转场
    VPAnimatorTypeTop,          //后续视图从上至下转场
    VPAnimatorTypeBottom,       //后续视图从下至上转场
} VPAnimatorType;

@interface VPAnimator : NSObject <UIViewControllerAnimatedTransitioning>
/**
 *  动画的效果
 */
@property (nonatomic, assign) VPAnimatorType animatorType;

@end
