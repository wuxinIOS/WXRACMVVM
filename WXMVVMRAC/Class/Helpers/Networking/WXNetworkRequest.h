//
//  WXNetworkRequest.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
// 负责 实施 具体请求 的 类

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class WXNetworkRequest;

//网络请求协议
@protocol WXNetworkRequesDelegate <NSObject>

/**
 请求完成

 @param request 发起请求的对象
 @param obj 返回的对象
 */
- (void)wx_newtorkRequest:(WXNetworkRequest *)request complention:(id)obj;

/**
 请求错误

 @param request 发起请求的对象
 @param error 错误信息
 */
- (void)wx_newtorkRequest:(WXNetworkRequest *)request error:(NSError *)error;

@end

@interface WXNetworkRequest : NSObject


/**
 AFN的请求管理单例
 */
@property (nonatomic, strong) AFHTTPSessionManager *requestManager;


/**
 请求队列
 */
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, weak) id <WXNetworkRequesDelegate> requestDelegate;

/**
 创建网络请求对象

 @return 返回的对象
 */
+ (instancetype)wx_networkRequst;

/**
 GET请求

 @param URLStr 请求的URL
 @param parameters 请求的参数
 @param success 请求成功回调block
 @param failure 请求失败回调block
 */
- (void)wx_GETRequestURLStr:(NSString *)URLStr
                 parameters:(NSDictionary *)parameters
                    success:(void (^)(WXNetworkRequest *request,id obj))success
                    failure:(void (^)(WXNetworkRequest *request,NSError *error))failure;

/**
 POST请求

 @param URLStr 请求的URL
 @param parameters 请求的参数
 @param success 请求成功回调block
 @param failure 请求失败回调的block
 */
- (void)wx_POSTRequestURLStr:(NSString *)URLStr
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(WXNetworkRequest *request,id obj))success
                     failure:(void (^)(WXNetworkRequest *request,NSError *error))failure;

/**
 post请求

 @param URLStr 请求的URL
 @param parameters 请求的参数
 */
- (void)wx_postWithURL:(NSString *)URLStr parameters:(NSDictionary *)parameters;

/**
 get请求

 @param URLStr 请求的URL
 @param parameters 请求的参数
 */
- (void)wx_getWithURL:(NSString *)URLStr parameters:(NSDictionary *)parameters;

/**
 取消当前请求队列的所有请求
 */
- (void)cancelAllOpetations;


@end
