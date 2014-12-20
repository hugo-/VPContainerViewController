//
//  VPContainerViewController.m
//  ContainerViewController
//
//  Created by shengxi on 14/12/17.
//  Copyright (c) 2014年 shengxi. All rights reserved.
//

#import "VPContainerViewController.h"
#import "VPTransitionContext.h"

static CGFloat const kButtonSlotHeight = 44;

@interface VPContainerViewController ()
/**
 *  子控制器数组
 */
//@property (nonatomic, copy, readwrite) NSArray *viewControllers;
/**
 *  选择视图
 */
@property (nonatomic, strong) UIScrollView *privateButtonsView;
/**
 *  显示容器
 */
@property (nonatomic, strong) UIView *privateContainerView;

@end

@implementation VPContainerViewController

- (instancetype)initWithViewControllers:(NSArray *)viewControllers {
    //断言viewControllers有元素
    NSParameterAssert ([viewControllers count] > 0);
    if ((self = [super init])) {
        self.viewControllers = [viewControllers copy];
        self.animated = YES;
        self.showButtonsMaxCount = 5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加顶部选择视图
    [self addTopButtonsView];
    //添加容器
    [self addContainerView];
    //顶部选择视图置顶
    [self.view bringSubviewToFront:self.privateButtonsView];
    
    self.selectedViewController = self.viewControllers[0];
}

/**
 *  添加顶部选择视图
 */
- (void)addTopButtonsView
{
    self.privateButtonsView = [[UIScrollView alloc] init];
    self.privateButtonsView.backgroundColor = [UIColor blueColor];
    self.privateButtonsView.bounces = NO;
    self.privateButtonsView.showsHorizontalScrollIndicator = NO;
    
    [self.privateButtonsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.privateButtonsView];
    
    //选择视图自动布局
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.topHeight ? self.topHeight : kButtonSlotHeight]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    //给选择视图添加按钮
    [self addChildViewControllerButtons];
}

/**
 *  添加容器
 */
- (void)addContainerView
{
    self.privateContainerView = [[UIView alloc] init];
    self.privateContainerView.backgroundColor = [UIColor whiteColor];
    self.privateContainerView.opaque = YES;
    
    [self.privateContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.privateContainerView];
    
    //先给容器添加第一个视图，防止使用scrollView的时候因为navigationBar下移64
    UIView *firstView = [[UIView alloc] initWithFrame:self.privateContainerView.bounds];
    [self.privateContainerView addSubview:firstView];
    
    //容器自动布局
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.privateButtonsView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

-(void)setSelectedViewController:(UIViewController *)selectedViewController
{
    //断言选中控制器不为空
    NSParameterAssert (selectedViewController);
    [self transitionToChildViewController:selectedViewController];
    _selectedViewController = selectedViewController;
    [self updateButtonSelection];
}

#pragma mark - 私有方法
/**
 *  给顶部选择视图添加按钮
 */
- (void)addChildViewControllerButtons {
    
    
    NSInteger childVcCount = self.viewControllers.count;
    
    UIView *btnsView = [[UIView alloc] init];
    [btnsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.privateButtonsView addSubview:btnsView];
    btnsView.backgroundColor = [UIColor purpleColor];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btnsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:childVcCount < self.showButtonsMaxCount ? 1 : (childVcCount * 1.0) / self.showButtonsMaxCount constant:0]];
    [btnsView addConstraint:[NSLayoutConstraint constraintWithItem:btnsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.topHeight ? self.topHeight : kButtonSlotHeight]];
    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:btnsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.privateButtonsView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:btnsView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.privateButtonsView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:btnsView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.privateButtonsView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:btnsView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.privateButtonsView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *childViewController, NSUInteger idx, BOOL *stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[self.viewControllers[idx] title] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted = NO;
        
        if (self.topBtnFont) {
            button.titleLabel.font = self.topBtnFont;
        }
        if (self.normalColor) {
            [button setTitleColor:self.normalColor forState:UIControlStateNormal];
        }
        if (self.selectedColor) {
            [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
        }
        if (self.noramlBackgroundImage) {
            [button setBackgroundImage:self.noramlBackgroundImage forState:UIControlStateNormal];
        }
        if (self.selectedBackgroundImage) {
            [button setBackgroundImage:self.selectedBackgroundImage forState:UIControlStateSelected];
        }
        
        button.tag = idx;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnsView addSubview:button];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [btnsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:btnsView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [btnsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:btnsView attribute:NSLayoutAttributeWidth multiplier:1.0 / childVcCount constant:0]];
        [btnsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:btnsView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        if (idx) {
            [btnsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:btnsView.subviews[idx - 1] attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
        } else {
            [btnsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:btnsView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        }
    }];
}

/**
 *  选择视图按钮的点击事件
 *
 *  @param button 被点击的按钮
 */
- (void)buttonClick:(UIButton *)button
{
    self.selectedViewController = self.viewControllers[button.tag];
}

/**
 *  更新被选中的按钮
 */
- (void)updateButtonSelection
{
    [[self.privateButtonsView.subviews[0] subviews] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = (self.viewControllers[idx] == self.selectedViewController);
    }];
}

/**
 *  动画过渡到选择的视图
 *
 *  @param toViewController 要显示的视图的控制器
 */
- (void)transitionToChildViewController:(UIViewController *)toViewController {
    
    //来源控制器
    UIViewController *fromViewController = ([self.childViewControllers count] > 0 ? self.selectedViewController : nil);
    if (toViewController == fromViewController || ![self isViewLoaded]) {
        return;
    }
    
    UIView *toView = toViewController.view;
    [toView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.privateContainerView.bounds;
    
    
    [self addChildViewController:toViewController];
    [fromViewController willMoveToParentViewController:nil];
    
    //当没有来源控制器时直接将视图添加到容器
    if (!fromViewController) {
        [self.privateContainerView addSubview:toView];
        [toViewController didMoveToParentViewController:self];
        return;
    }
    
    if (self.animated) {
        //来源视图索引
        NSInteger fromIndex = [self.viewControllers indexOfObject:fromViewController];
        //去往视图索引
        NSInteger toIndex = [self.viewControllers indexOfObject:toViewController];
        
        //实例化转场上下文
        VPTransitionContext *transitionContext = [[VPTransitionContext alloc] initWithFromViewController:fromViewController toViewController:toViewController goingRight:(toIndex > fromIndex)];
        transitionContext.animated = self.animated;
        transitionContext.interactive = NO;
        self.privateButtonsView.userInteractionEnabled = NO;
        //完成后的回调
        transitionContext.completionBlock = ^(BOOL didComplete) {
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            self.privateButtonsView.userInteractionEnabled = YES;
        };
        
        VPAnimator *animator = [[VPAnimator alloc] init];
        animator.animatorType = self.animatorType;
        [animator animateTransition:transitionContext];
    } else {
        [self.privateContainerView addSubview:toView];
        [fromViewController.view removeFromSuperview];
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    }
    
    
}

@end


