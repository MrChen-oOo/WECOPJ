//
//  AddCollectorAlert.h
 
//
//  Created by BQ123 on 2019/2/26.
//  Copyright © 2019 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kDatePicHeight2 350
#define kTopViewHeight 44


@interface AddCollectorAlert : UIView
// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) UIView *alertView;
// 顶部视图
@property (nonatomic, strong) UIView *topView;
// 左边取消按钮
@property (nonatomic, strong) UIButton *leftBtn;
// 右边确定按钮
@property (nonatomic, strong) UIButton *rightBtn;
// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;
// 分割线视图
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UITextField *textSerialNumber;

@property (nonatomic, strong) UITextField *textCheckCode;

@property (nonatomic, copy) void (^returnWithCollector)(NSString *devId, NSString *authCode);

@property (nonatomic, copy) void (^btnScanTouchAction)();//

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation;

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
