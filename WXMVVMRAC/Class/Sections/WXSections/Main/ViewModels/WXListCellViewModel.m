//
//  WXListCellViewModel.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXListCellViewModel.h"

@implementation WXListCellViewModel


- (RACSubject *)buttonDidClickSubject {
    if (!_buttonDidClickSubject) {
        _buttonDidClickSubject = [RACSubject subject];
    }
    return _buttonDidClickSubject;
}



+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"fimlID":@"id"};
}


@end
