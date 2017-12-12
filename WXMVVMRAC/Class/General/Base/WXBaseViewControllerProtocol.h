//
//  WXBaseViewControllerProtocol.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXBaseViewModelProtocol;

@protocol WXBaseViewModelControllerProtocol <NSObject>

@optional

/**
 初始化控制器

 @param viewModel 控制器对应的viewModel
 @return 控制器
 */
- (instancetype)initWithViewModel:(id<WXBaseViewModelProtocol>)viewModel;

/**
 添加子控件
 */
- (void)wx_addSubviews;

/**
 使用ARC绑定控件与viewModel
 */
- (void)wx_RACBindViewModel;

/**
 设置导航栏
 */
- (void)wx_layoutNavigation;

/**
 获取数据
 */
- (void)wx_getNewData;

/**
 键盘收回
 */
- (void)recoverKeyboard;


@end
