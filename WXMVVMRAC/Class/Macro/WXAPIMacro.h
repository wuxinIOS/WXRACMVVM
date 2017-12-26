//
//  WXAPIMacro.h
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#define BASE_URL @"https://www.jkmovies.jukest.cn/"
#define Image_URL @"https://www.jkmovies.jukest.cn"
#define ImageDetail_URL @"https://www.jkmovies.jukest.cn/"

// 影院主页
#define ApiCommonCinemaURL @"Api/Common/cinema"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]
