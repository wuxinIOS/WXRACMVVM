//
//  WXBaseViewController.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXBaseViewController.h"

@interface WXBaseViewController ()

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;

@end

@implementation WXBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    WXBaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        [viewController wx_addSubviews];
        [viewController wx_RACBindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        [viewController wx_layoutNavigation];
        [viewController wx_getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<WXBaseViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
//    [self setIsExtendLayout:NO];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    // Do any additional setup after loading the view.
}


- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}




- (void)wx_removeNavigationBarLine {
    
    NSArray *subviews = self.navigationController.navigationBar.subviews;;
    
    for (id obj in subviews) {
        
        if ([obj isKindOfClass:[UIImageView class]]) {
            
            UIImageView *imageView = (UIImageView *)obj;
            
            NSArray *subviews2 = imageView.subviews;
            
            for (id obj2 in subviews2) {
                
                if ([obj2 isKindOfClass:[UIImageView class]]) {
                    
                    UIImageView *imageView2 = (UIImageView *)obj2;
                    
                    imageView2.hidden = YES;
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusBarHidden:(BOOL)statusBarHidden changeStatusBarAnimated:(BOOL)animated {
    self.statusBarStyle = statusBarStyle;
    self.statusBarHidden = statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hiddenNavigationBar:(BOOL)hidden animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden = hidden;
        }];
    } else {
        self.navigationController.navigationBarHidden = hidden;
    }
}

- (void)layoutNavigationBar:(UIImage *)backGroundImage
                 titleColor:(UIColor *)titleColor
                  titleFont:(UIFont *)titleFont
          leftBarButtonItem:(UIBarButtonItem *)leftItem
         rightBarButtonItem:(UIBarButtonItem *)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

- (void)wx_addSubviews {}

- (void)wx_RACBindViewModel {}

- (void)wx_layoutNavigation {}

- (void)wx_getNewData {}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
