//
//  WXProgressHUD.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation WXProgressHUD

+ (void)hiddenProgressWithView:(UIView *)view {
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+ (void)showProgressWithView:(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)showProgressWithView:(UIView *)view time:(NSTimeInterval)time {
    [self showProgressWithView:view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenProgressWithView:view];
    });
}

+ (void)showProgressWithView:(UIView *)view text:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
}

+ (void)showProgressWithView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time {
    [self showProgressWithView:view text:text];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenProgressWithView:view];
    });
}

@end
