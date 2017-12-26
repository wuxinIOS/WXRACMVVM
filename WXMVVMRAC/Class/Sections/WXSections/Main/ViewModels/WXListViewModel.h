//
//  WXListViewModel.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXBaseViewModel.h"

@interface WXListViewModel : WXBaseViewModel

/**
 下拉刷新
 */
@property (nonatomic, strong) RACCommand *refreshNewDataCommand;

/**
 上拉加载
 */
@property (nonatomic, strong) RACCommand *refreshMoreDataCommand;

@property (nonatomic, strong) RACSubject *cellDidSelectedSubject;


/**
 刷新UI的信号
 */
@property (nonatomic, strong) RACSubject *refreshUISubject;

/**
 结束刷新的信号
 */
@property (nonatomic, strong) RACSubject *endRefreshSubject;

/**
 数据数组
 */
@property (nonatomic, strong) NSMutableArray *dataArray;


@end
