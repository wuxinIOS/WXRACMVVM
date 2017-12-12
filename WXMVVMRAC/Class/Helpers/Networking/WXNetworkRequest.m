//
//  WXNetworkRequest.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXNetworkRequest.h"

@implementation WXNetworkRequest

+ (instancetype)wx_networkRequst {
    return [[self alloc]init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestManager = [AFHTTPSessionManager manager];
    }
    return self;
}


- (void)wx_GETRequestURLStr:(NSString *)URLStr
                 parameters:(NSDictionary *)parameters
                    success:(void (^)(WXNetworkRequest *, id))success
                    failure:(void (^)(WXNetworkRequest *, NSError *))failure {
    
    
    self.operationQueue = self.requestManager.operationQueue;//获取当前请求的队列
    self.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.requestManager GET:URLStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(self,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(self,error);
    }];
    
}

- (void)wx_POSTRequestURLStr:(NSString *)URLStr parameters:(NSDictionary *)parameters success:(void (^)(WXNetworkRequest *, id))success failure:(void (^)(WXNetworkRequest *, NSError *))failure {
    self.operationQueue = self.requestManager.operationQueue;
    self.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.requestManager POST:URLStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(self,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(self,error);
    }];
}


- (void)wx_getWithURL:(NSString *)URLStr parameters:(NSDictionary *)parameters {
    [self wx_GETRequestURLStr:URLStr
                   parameters:parameters
                      success:^(WXNetworkRequest *request, id obj) {
        
                          if (self.requestDelegate) {
                              if ([self.requestDelegate respondsToSelector:@selector(wx_newtorkRequest:complention:)]) {
                                  [self.requestDelegate wx_newtorkRequest:request complention:obj];
                              }
                          }
                          
                    }
                     failure:^(WXNetworkRequest *request, NSError *error) {
        
                          if (self.requestDelegate) {
                              if ([self.requestDelegate respondsToSelector:@selector(wx_newtorkRequest:error:)]) {
                                  [self.requestDelegate wx_newtorkRequest:request error:error];
                              }
                          }
    }];
}

- (void)wx_postWithURL:(NSString *)URLStr parameters:(NSDictionary *)parameters {
    
    [self wx_POSTRequestURLStr:URLStr
                    parameters:parameters
                       success:^(WXNetworkRequest *request, id obj) {
                           if (self.requestDelegate) {
                               if ([self.requestDelegate respondsToSelector:@selector(wx_newtorkRequest:complention:)]) {
                                   [self.requestDelegate wx_newtorkRequest:request complention:obj];
                               }
                           }
                           
    }
                       failure:^(WXNetworkRequest *request, NSError *error) {
        
                           if (self.requestDelegate) {
                               if ([self.requestDelegate respondsToSelector:@selector(wx_newtorkRequest:error:)]) {
                                   [self.requestDelegate wx_newtorkRequest:request error:error];
                               }
                           }
    }];
    
}

- (void)cancelAllOpetations {
    [self.operationQueue cancelAllOperations];
}

@end
