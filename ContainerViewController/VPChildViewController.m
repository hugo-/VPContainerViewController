//
//  VPChildViewController.m
//  ContainerViewController
//
//  Created by shengxi on 14/12/17.
//  Copyright (c) 2014年 shengxi. All rights reserved.
//

#import "VPChildViewController.h"

@interface VPChildViewController ()

@property (nonatomic, strong) UILabel *privateTitleLabel;

@end

@implementation VPChildViewController

- (void)loadView {
    
    self.privateTitleLabel = [[UILabel alloc] init];
    self.privateTitleLabel.backgroundColor = [UIColor clearColor];
    self.privateTitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.privateTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.privateTitleLabel.numberOfLines = 0;
    [self.privateTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.view = [[UIView alloc] init];
    [self.view addSubview:self.privateTitleLabel];
    
    // Center label in view.
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateTitleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.6f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateTitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateTitleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void)viewDidLoad {
    
    self.privateTitleLabel.text = self.title;
    
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];
    
    self.view.backgroundColor = color;
    
    NSLog(@"加载一次？");
}

@end
