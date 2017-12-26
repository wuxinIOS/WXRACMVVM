//
//  WXBaseViewController.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXBaseViewControllerProtocol.h"

@interface WXBaseViewController : UIViewController<WXBaseViewModelControllerProtocol>


/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (assign,nonatomic) BOOL isExtendLayout;

/**
 设置状态栏的样式

 @param statusBarStyle 样式
 @param statusBarHidden 是否隐藏状态栏
 @param animated 是否动画的过渡
 */
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated;


/**
 是否隐藏导航栏

 @param hidden bool值
 @param animated 是否有过渡动画
 */
- (void)hiddenNavigationBar:(BOOL)hidden animated:(BOOL)animated;


/**
 隐藏导航栏底部的线
 */
- (void)wx_removeNavigationBarLine;

/**
 布局导航栏界面

 @param backGroundImage 导航栏背景
 @param titleColor 标题颜色
 @param titleFont 标题大小
 @param leftItem 左侧按钮
 @param rightItem 右侧按钮
 */
- (void)layoutNavigationBar:(UIImage *)backGroundImage
                 titleColor:(UIColor *)titleColor
                  titleFont:(UIFont *)titleFont
          leftBarButtonItem:(UIBarButtonItem *)leftItem
         rightBarButtonItem:(UIBarButtonItem *)rightItem;

@end
