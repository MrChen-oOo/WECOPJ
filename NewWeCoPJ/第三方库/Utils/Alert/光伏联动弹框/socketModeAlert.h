//
//  socketModeAlert.h
 
//
//  Created by BQ123 on 2019/3/13.
//  Copyright © 2019 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kDatePicHeight2 240
#define kTopViewHeight 44

@interface socketModeAlert : UIView

// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) UIView *alertView;
// 右边确定按钮
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) void (^touchSettingButton)();


#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
