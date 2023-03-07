//
//  CollectorRenewalFeeAlert.h
 
//
//  Created by BQ123 on 2019/4/17.
//  Copyright © 2019 qwl. All rights reserved.
//

#import "BaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectorRenewalFeeAlert : BaseAlertView

@property (nonatomic, strong) NSString *languageType;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *btnTitle;

@property (nonatomic, copy) void (^touchRenewalFeeAction)();// 点击立即续费

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation;

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
