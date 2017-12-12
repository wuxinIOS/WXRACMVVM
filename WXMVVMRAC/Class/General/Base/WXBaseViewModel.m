//
//  WXBaseViewModel.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXBaseViewModel.h"

@implementation WXBaseViewModel

@synthesize networkRequest = _networkRequest;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    WXBaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel wx_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (WXNetworkRequest *)request {
    if (!_networkRequest) {
        _networkRequest = [WXNetworkRequest wx_networkRequst];
    }
    return _networkRequest;
}

- (void)wx_initialize {}


@end
