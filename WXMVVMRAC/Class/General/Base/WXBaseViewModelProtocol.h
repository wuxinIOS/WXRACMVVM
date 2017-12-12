//
//  WXBaseViewModelProtocol.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

// viewModel用来发送网络请求 处理数据结构及相关业务逻辑,定义此协议，只要遵守此协议的viewModel均可以进行网络请求

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WXHeaderRefresh_HasMoreData = 1,//头部加载
    WXHeaderRefresh_NoMoreData,//
    WXFooterRefresh_HasMoreData,//有更多数据
    WXFooterRefresh_NoMoreData,//没有更多数据
    WXRefreshError,//请求错误
    WXRefreshUI,//刷新UI
    
} WXRefreshDataStatus;

@protocol WXBaseViewModelProtocol <NSObject>

@optional

@property (strong, nonatomic)WXNetworkRequest *networkRequest;


- (instancetype)initWithModel:(id)model;


- (void)wx_initialize;

@end
