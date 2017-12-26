//
//  WXListViewModel.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXListViewModel.h"
#import "WXListCellViewModel.h"

@interface WXListViewModel ()

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger size;

@end


@implementation WXListViewModel


- (void)wx_initialize {
    self.size = 7;
    @weakify(self);
    //监听刷新数据的信号
    [self.refreshNewDataCommand.executionSignals.switchToLatest subscribeNext:^(id obj) {
        @strongify(self);
        
        NSDictionary *restultDic = (NSDictionary *)obj;
        
        NSDictionary *content = restultDic[@"content"];
        
        NSInteger code = [restultDic[@"code"] integerValue];
        
        if (code == 0) {//获取数据成功
            NSArray *dicArray = content[@"hot_films"];
            [self.dataArray removeAllObjects];
            self.dataArray = [WXListCellViewModel mj_objectArrayWithKeyValuesArray:dicArray];
            [self sendSignalWithDataCount:self.dataArray.count];
            
        } else {//没有数据 但是网络请求是成功的
            
            [WXProgressHUD showProgressWithView:[UIApplication sharedApplication].keyWindow text:restultDic[@"message"] time:1];
            [self.endRefreshSubject sendNext:@(WXRefreshError)];
        }
        
    }];
    
    //网络请求失败的信号
    [self.refreshNewDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        
        [self.endRefreshSubject sendNext:@(WXRefreshError)];

    }];
    
    //网络请求成功的信号
    [self.refreshMoreDataCommand.executionSignals.switchToLatest subscribeNext:^(id obj) {
        @strongify(self);
        
        NSDictionary *restultDic = (NSDictionary *)obj;
        
        NSDictionary *content = restultDic[@"content"];
        
        NSInteger code = [restultDic[@"code"] integerValue];
        
        NSMutableArray *modelArray = [[NSMutableArray alloc]init];
        
        if (code == 0) {
            
            NSArray *dicArray = content[@"hot_films"];
            modelArray = [WXListCellViewModel mj_objectArrayWithKeyValuesArray:dicArray];
            [self.dataArray addObjectsFromArray:modelArray];
            
            [self sendSignalWithDataCount:modelArray.count];
            
        } else {
            
            [WXProgressHUD showProgressWithView:[UIApplication sharedApplication].keyWindow text:restultDic[@"message"] time:1];
            [self.endRefreshSubject sendNext:@(WXRefreshError)];
            
            self.currentPage--;
        }
        
        
    }];
    
    //网络请求失败的信号
    [self.refreshMoreDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        [self.endRefreshSubject sendNext:@(WXRefreshError)];

    }];
    
}

- (void)sendSignalWithDataCount:(NSInteger)count {
    if (count < self.size) {//没更多数据了
        [self.endRefreshSubject sendNext:@(WXFooterRefresh_NoMoreData)];
    } else {
        [self.endRefreshSubject sendNext:@(WXFooterRefresh_HasMoreData)];
        
    }
}

#pragma mark -- lazy load

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (RACSubject *)cellDidSelectedSubject {
    if (!_cellDidSelectedSubject) {
        _cellDidSelectedSubject = [RACSubject subject];
    }
    return _cellDidSelectedSubject;
}

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)endRefreshSubject {
    if (!_endRefreshSubject) {
        _endRefreshSubject = [RACSubject subject];
    }
    return _endRefreshSubject;
}

- (RACCommand *)refreshNewDataCommand {
    if (!_refreshNewDataCommand) {
        @weakify(self);

        
        _refreshNewDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [WXProgressHUD showProgressWithView:[UIApplication sharedApplication].keyWindow];

                
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,ApiCommonCinemaURL];

                self.currentPage = 0;

                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
           
                parameters[@"token"] = @"eyJpZCI6IjQ2OTgiLCJub25jZSI6IkNKd0lOU29VIiwiZ3JvdXBfaWQiOiIxIn0=";
                parameters[@"cinema_id"] = @6;
                parameters[@"page"] = @(self.currentPage);
                parameters[@"size"] = @(self.size);
                
                [self.networkRequest wx_POSTRequestURLStr:urlStr parameters:parameters success:^(WXNetworkRequest *request, id obj) {
                    
                    [WXProgressHUD hiddenProgressWithView:[UIApplication sharedApplication].keyWindow];
                    
                    NSLog(@"URL:%@-------\n%@",urlStr,obj);
                    [subscriber sendNext:obj];
                    [subscriber sendCompleted];
                    
                } failure:^(WXNetworkRequest *request, NSError *error) {
                    [WXProgressHUD hiddenProgressWithView:[UIApplication sharedApplication].keyWindow];
                    [WXProgressHUD showProgressWithView:[UIApplication sharedApplication].keyWindow text:@"请求失败" time:2];
                    NSLog(@"网络请求失败");
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                
                return nil;
                
            }];
            
        }];
    }
    return _refreshNewDataCommand;
}

- (RACCommand *)refreshMoreDataCommand {
    if (!_refreshMoreDataCommand) {
        @weakify(self);
        
        
        _refreshMoreDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            [WXProgressHUD showProgressWithView:[UIApplication sharedApplication].keyWindow];
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);

                self.currentPage++;
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,ApiCommonCinemaURL];

                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                
                parameters[@"token"] = @"eyJpZCI6IjQ2OTgiLCJub25jZSI6IkNKd0lOU29VIiwiZ3JvdXBfaWQiOiIxIn0=";
                parameters[@"cinema_id"] = @6;
                parameters[@"page"] = @(self.currentPage);
                parameters[@"size"] = @(self.size);
                [self.networkRequest wx_POSTRequestURLStr:urlStr parameters:parameters success:^(WXNetworkRequest *request, id obj) {
                    [WXProgressHUD hiddenProgressWithView:[UIApplication sharedApplication].keyWindow];

                    NSLog(@"URL:%@-------\n%@",urlStr,obj);
                    [subscriber sendNext:obj];
                    [subscriber sendCompleted];
                    
                } failure:^(WXNetworkRequest *request, NSError *error) {
                    self.currentPage--;
                    NSLog(@"网络请求失败");
                    [WXProgressHUD hiddenProgressWithView:[UIApplication sharedApplication].keyWindow];
                    [WXProgressHUD showProgressWithView:[UIApplication sharedApplication].keyWindow text:@"请求失败" time:2];
                    
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                
                return nil;
                
            }];
        }];
    }
    
    return _refreshMoreDataCommand;
}

@end
