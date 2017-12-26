//
//  WXListCell.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXBaseTableViewCell.h"
#import "WXListCellViewModel.h"

@interface WXListCell : WXBaseTableViewCell


@property (nonatomic, strong) WXListCellViewModel *cellViewModel;

@end
