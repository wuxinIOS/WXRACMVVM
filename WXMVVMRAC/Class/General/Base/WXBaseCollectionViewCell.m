//
//  WXBaseCollectionViewCell.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXBaseCollectionViewCell.h"

@implementation WXBaseCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self yd_setupViews];
    }
    return self;
}

- (void)yd_setupViews {}

@end
