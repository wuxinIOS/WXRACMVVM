//
//  WXBaseView.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXBaseView.h"

@implementation WXBaseView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self wx_setupviews];
        [self wx_racBindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<WXBaseViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        [self wx_setupviews];
        [self wx_racBindViewModel];
    }
    return self;
}

- (void)wx_setupviews {}

- (void)wx_racBindViewModel {}

- (void)wx_addReturnKeyBoard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}

@end
