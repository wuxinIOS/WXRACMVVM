//
//  WXBaseViewProtocol.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXBaseViewModelProtocol;

@protocol WXBaseViewProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id<WXBaseViewModelProtocol>)viewModel;

- (void)wx_setupviews;

- (void)wx_racBindViewModel;

- (void)wx_addReturnKeyBoard;

@end
