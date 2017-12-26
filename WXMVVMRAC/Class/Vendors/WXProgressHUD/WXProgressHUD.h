//
//  WXProgressHUD.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXProgressHUD : UIView


/**
 显示无文字菊花圈,不自动消失

 @param view 视图
 */
+ (void)showProgressWithView:(UIView *)view;


/**
 无文字菊花圈，自动消失

 @param view 视图
 @param time 时间
 */
+ (void)showProgressWithView:(UIView *)view time:(NSTimeInterval)time;

/**
 文字菊花圈，不自动消失

 @param view 视图
 @param text 文字
 */
+ (void)showProgressWithView:(UIView *)view text:(NSString *)text;

/**
 文字菊花圈，自动消失

 @param view 视图
 @param text 文字
 @param time 时间
 */
+ (void)showProgressWithView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time;


/**
 隐藏菊花圈
 */
+ (void)hiddenProgressWithView:(UIView *)view;
@end


















