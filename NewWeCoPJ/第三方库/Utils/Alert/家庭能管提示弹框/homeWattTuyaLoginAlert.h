//
//  homeWattTuyaLoginAlert.h
 
//
//  Created by BQ123 on 2019/10/8.
//  Copyright © 2019 qwl. All rights reserved.
//

#import "BaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface homeWattTuyaLoginAlert : BaseAlertView

- (instancetype)initWithFrame:(CGRect)frame isTabbar:(BOOL)isTabbar;

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation;

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation;

@property (nonatomic, copy) void (^touchAlertReconnection)(); // 点击重新登录涂鸦账号


@end

NS_ASSUME_NONNULL_END
