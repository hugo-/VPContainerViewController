VPContainerViewController
=========================
VPContainerViewController manages a stack of view controllers and a topView
![](https://github.com/NaiveVDisk/VPContainerViewController/blob/master/Screenshots/show.gif)

use
-------------------------
 *  显示的自控制器数组<br>
```objective-c
  @property (nonatomic, copy) NSArray *viewControllers;
```
 *  选中的子控制器<br>
```objective-c
  @property (nonatomic, assign) UIViewController *selectedViewController;
```
 *  顶部选择视图的高度<br>
```objective-c
  @property (nonatomic, assign) CGFloat topHeight;
```
 *  按钮默认文字颜色<br>
```objective-c
    @property (nonatomic, strong) UIColor *normalColor;
```
 *  按钮选中文字颜色<br>
```objective-c
    @property (nonatomic, strong) UIColor *selectedColor;
```
 *  按钮字体<br>
```objective-c
    @property (nonatomic, strong) UIFont *topBtnFont;
```
 *  按钮默认背景图<br>
```objective-c
    @property (nonatomic, strong) UIImage *noramlBackgroundImage;
```
 *  按钮选中状态的背景图<br>
```objective-c
    @property (nonatomic, strong) UIImage *selectedBackgroundImage;
```
 *  是否动画<br>
```objective-c
    @property (nonatomic, assign, getter=isAnimated) BOOL animated;
```
 *  动画的效果<br>
```objective-c
    @property (nonatomic, assign) VPAnimatorType animatorType;
```
 *  动画时间<br>
```objective-c
    @property (nonatomic, assign) CGFloat animatorTime;
```
 *  显示的最大按钮数(多余的滑动显示)<br>
```objective-c
    @property (nonatomic, assign) NSInteger showButtonsMaxCount;
```
 *  初始化
```objective-c
    - (instancetype)initWithViewControllers:(NSArray *)viewControllers;
```
