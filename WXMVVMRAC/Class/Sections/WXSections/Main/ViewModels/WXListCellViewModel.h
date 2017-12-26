//
//  WXListCellViewModel.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXBaseViewModel.h"

@interface WXListCellViewModel : WXBaseViewModel

@property (nonatomic, strong) RACSubject *buttonDidClickSubject;

/** 电影图片 */
@property (nonatomic, strong) NSString *cover;

@property (nonatomic, copy) NSString *name;

/** 简述 */
@property (nonatomic, strong) NSString *sketch;

/** 播放类型(3D or 2D ) */
@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSString *fimlID;


@end
