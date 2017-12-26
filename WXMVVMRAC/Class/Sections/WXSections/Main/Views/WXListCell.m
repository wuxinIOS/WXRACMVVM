//
//  WXListCell.m
//  WXMVVMRAC
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 zhongYing_wx. All rights reserved.
//

#import "WXListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WXListCell ()

@property (nonatomic, strong) UIImageView *filmImageView;

/** 影名 */
@property (nonatomic, strong) UILabel *filmNameLabel;
/** 评分 */
@property (nonatomic, strong) UIView *startView;
/** 2D OR 3D */
@property (nonatomic, strong) UILabel *film3D_2DLabel;
/** 简述 */
@property (nonatomic, strong) UILabel *desLabel;

/** 购买按钮 */
@property (nonatomic, strong) UIButton *buyButton;

@end


@implementation WXListCell





- (void)wx_setupSubviews {
    [super wx_setupSubviews];
    
    NSLog(@"-----");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.filmImageView];
    [self addSubview:self.filmNameLabel];
    [self addSubview:self.film3D_2DLabel];
    [self addSubview:self.desLabel];
    [self addSubview:self.buyButton];
    [self addSubview:self.startView];
    
    
    //更新约束
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


- (void)updateConstraints {
 
    CGFloat marge = 10;
    WS(weakSelf);
    [self.filmImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).mas_equalTo(marge);
        make.left.mas_equalTo(weakSelf.mas_left).mas_equalTo(marge);

        make.bottom.mas_equalTo(weakSelf.mas_bottom).mas_equalTo(-marge);

        make.width.mas_equalTo(weakSelf.filmImageView.mas_height).multipliedBy(0.8);//宽等于高的0.7倍
    }];
    
    [self.film3D_2DLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.top.mas_equalTo(20);
        make.right.greaterThanOrEqualTo(@(-15)).priority(200);
    }];
    
    CGFloat maxW = self.frame.size.width - CGRectGetMaxX(self.filmImageView.frame) - marge - 10 - 30 - 30;
    [self.filmNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.filmImageView.mas_right).mas_equalTo(marge);
        make.top.mas_equalTo(weakSelf.filmImageView.mas_top).mas_equalTo(5);
        make.height.mas_equalTo(30);
        make.width.lessThanOrEqualTo(@(maxW));
        make.right.equalTo(weakSelf.film3D_2DLabel.mas_left).equalTo(@(-10));
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        
    }];
    
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.filmNameLabel.mas_left);
        make.top.equalTo(weakSelf.filmNameLabel.mas_bottom).mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.filmNameLabel.mas_left);
        make.right.equalTo(weakSelf.buyButton.mas_left).offset(-10);
        make.top.equalTo(weakSelf.startView.mas_bottom).mas_equalTo(5);

    }];
    //可以多行显示,不能确定label的高度，masonry会自动计算
    [self.desLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

    


    
    
    [super updateConstraints];
}




- (void)wx_racBindViewModel {
    
}

#pragma mark -- lazy load

- (UIImageView *)filmImageView {
    if (!_filmImageView) {
        _filmImageView = [[UIImageView alloc]init];
        _filmImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _filmImageView;
}

- (UILabel *)filmNameLabel {
    if (!_filmNameLabel) {
        _filmNameLabel = [[UILabel alloc]init];
        _filmNameLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        _filmNameLabel.font = SYSTEMFONT(14);
        _filmNameLabel.backgroundColor = [UIColor lightGrayColor];
        _filmNameLabel.textColor = [UIColor blackColor];
    }
    return _filmNameLabel;
}

//- (UIView *)startView {
//    
//}

- (UILabel *)film3D_2DLabel {
    if (!_film3D_2DLabel) {
        _film3D_2DLabel = [[UILabel alloc]init];
        _film3D_2DLabel.backgroundColor = [UIColor grayColor];
        _film3D_2DLabel.text = @"3D";
        _film3D_2DLabel.font = SYSTEMFONT(12);
        _film3D_2DLabel.textAlignment = NSTextAlignmentCenter;
        _film3D_2DLabel.textColor = [UIColor whiteColor];
        _film3D_2DLabel.backgroundColor = [UIColor orangeColor];
    }
    return _film3D_2DLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.backgroundColor = [UIColor grayColor];
        _desLabel.text = @"小男孩米格尔不小心进入了死亡之地小男孩米格尔不小心进入了死亡之地小男孩米格尔不小心进入了死亡之地小男孩米格尔不小心进入了死亡之地";
        _desLabel.font = SYSTEMFONT(12);
        _desLabel.numberOfLines = 2;
        _desLabel.textColor = [UIColor whiteColor];
    }
    return _desLabel;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.backgroundColor = [UIColor redColor];
        [_buyButton setTitle:@"购买" forState:UIControlStateNormal];
        @weakify(self);
        [[_buyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.cellViewModel.buttonDidClickSubject sendNext:self];
        }];
        
    }
    return _buyButton;
}

- (UIView *)startView {
    if (!_startView) {
        _startView = [[UIView alloc]init];
        _startView.backgroundColor = [UIColor purpleColor];
    }
    return _startView;
}

- (void)setCellViewModel:(WXListCellViewModel *)cellViewModel {
    _cellViewModel = cellViewModel;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,cellViewModel.cover]];
    
    [self.filmImageView sd_setImageWithURL:url];
    
    self.filmNameLabel.text = cellViewModel.name;
    
    self.desLabel.text = cellViewModel.sketch;
    
    if (cellViewModel.tags.count != 0) {
        
        self.film3D_2DLabel.text = cellViewModel.tags[0];
    }
    
    
    
}

@end
