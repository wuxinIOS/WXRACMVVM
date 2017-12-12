//
//  WXBaseTableViewCellProtocol.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXBaseTableViewCellProtocol <NSObject>

@optional
- (void)wx_setupSubviews;
- (void)wx_racBindViewModel;

@end
