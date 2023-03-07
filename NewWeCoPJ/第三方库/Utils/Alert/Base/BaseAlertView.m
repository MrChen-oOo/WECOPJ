//
//  BaseAlertView.m
 
//
//  Created by BQ123 on 2019/4/17.
//  Copyright © 2019 qwl. All rights reserved.
//

#import "BaseAlertView.h"

@implementation BaseAlertView

- (void)initUIWithAlertSize:(CGSize)size {
    self.frame = [UIScreen mainScreen].bounds;
    // 背景遮罩图层
    [self addSubview:self.backgroundView];
    // 弹出视图
    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-size.width)/2, ([UIScreen mainScreen].bounds.size.height-size.height)/2, size.width, size.height)];
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.layer.cornerRadius = 10;
    self.alertView.layer.masksToBounds = YES;
    [self addSubview:self.alertView];
}

#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.20];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

#pragma mark - 点击背景遮罩图层事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {}


@end
