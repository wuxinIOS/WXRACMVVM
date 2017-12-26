//
//  WXListViewController.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXListViewController.h"
#import "WXListView.h"
#import "WXListViewModel.h"

@interface WXListViewController ()


/**
 列表视图，作为控制器的主视图
 */
@property (nonatomic, strong) WXListView *listView;


/**
 视图模型，控制器主视图绑定的视图模型
 */
@property (nonatomic, strong) WXListViewModel *viewModel;

@end

@implementation WXListViewController

#pragma mark -- system method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isExtendLayout = NO;
    [self layoutNavigationBar:[UIImage imageNamed:@"bgimg"] titleColor:[UIColor redColor] titleFont:[UIFont systemFontOfSize:25] leftBarButtonItem:nil rightBarButtonItem:nil];
//    [self wx_removeNavigationBarLine];
//    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
}

/**
 布局
 */
- (void)updateViewConstraints {
    
    WS(weakSelf)
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}



#pragma mark -- WXBaseViewControllerProtocol
- (void)wx_addSubviews {
    [super wx_addSubviews];
    
    [self.view addSubview:self.listView];
    
}


- (void)wx_RACBindViewModel {
    [super wx_RACBindViewModel];
    
//    @weakify(self);
    [self.viewModel.cellDidSelectedSubject subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        if ([x isKindOfClass:[NSIndexPath class]]) {
            
            NSLog(@"%@",x);
            
        }
        
        if ([x isKindOfClass:[NSString class]]) {
            NSLog(@"%@",x);
        }
    }];
}

- (void)wx_layoutNavigation {
    [super wx_layoutNavigation];
    self.title = @"电影列表";
}

- (void)wx_getNewData {
    [super wx_getNewData];
}




#pragma mark -- lazy load

- (WXListView *)listView {
    if (!_listView) {
        _listView = [[WXListView alloc]initWithViewModel:self.viewModel];
    }
    return _listView;
}

- (WXListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WXListViewModel alloc]init];
    }
    return _viewModel;
}





@end
