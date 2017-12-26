//
//  WXListView.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXListView.h"
#import "WXListViewModel.h"
#import "WXListCell.h"


@interface WXListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WXListViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;
@end


@implementation WXListView

- (instancetype)initWithViewModel:(id<WXBaseViewModelProtocol>)viewModel {
    self.viewModel = (WXListViewModel *)viewModel;
    return  [super initWithViewModel:viewModel];
;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    WS(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.edges.equalTo(weakSelf);
        
    }];
    
}

- (void)wx_setupviews {
    self.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.tableView];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)wx_racBindViewModel {
    
    [self.viewModel.refreshNewDataCommand execute:nil];
    
    @weakify(self);
    [self.viewModel.endRefreshSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        self.tableView.mj_footer.hidden = NO;
        
        NSInteger status = [x integerValue];
        
        [self endRefreshWithStatus:status];
        
        [self.tableView reloadData];
        
    }];
    
}

- (void)endRefreshWithStatus:(WXRefreshDataStatus)status {
    
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
        
        
        if (status == WXFooterRefresh_NoMoreData) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else if (status == WXFooterRefresh_HasMoreData) {
            [self.tableView.mj_footer resetNoMoreData];
        } else if (status == WXRefreshError) {
            [self.tableView.mj_footer setHidden:YES];
        }
    }
    
    if ([self.tableView.mj_footer isRefreshing]) {
        if (status == WXFooterRefresh_NoMoreData) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else if (status == WXFooterRefresh_HasMoreData) {
            [self.tableView.mj_footer endRefreshing];
        } else if (status == WXRefreshError) {
            [self.tableView.mj_footer endRefreshing];
        }
    }
    
}


#pragma mark -- lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[WXListCell class] forCellReuseIdentifier:NSStringFromClass([WXListCell class])];
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.viewModel.refreshNewDataCommand execute:nil];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.viewModel.refreshMoreDataCommand execute:nil];
        }];
        _tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}


#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WXListCell class]) forIndexPath:indexPath];
    
    WXListCellViewModel *cellViewModel = (WXListCellViewModel *)self.viewModel.dataArray[indexPath.row];
    
    cell.cellViewModel = cellViewModel;
    @weakify(self);
    [[cell.cellViewModel.buttonDidClickSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(UITableViewCell *x) {
        @strongify(self);
        NSIndexPath *indexPath = [tableView indexPathForCell:x];
        WXListCellViewModel *model = self.viewModel.dataArray[indexPath.row];
        [self.viewModel.cellDidSelectedSubject sendNext:model.fimlID];
        
    }];
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel.cellDidSelectedSubject sendNext:indexPath];
    
    
}







@end
