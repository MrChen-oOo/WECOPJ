//
//  InputSettingAlert.h
//  charge
//
//  Created by BQ123 on 2018/10/22.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputSettingDelegate <NSObject>

- (void)InputSettingWithPrams:(NSDictionary *)prams;

@end

NS_ASSUME_NONNULL_BEGIN

@interface InputSettingAlert : UIView

@property (nonatomic, copy) NSString *titleText;// 标题

@property (nonatomic, copy) NSString *currentText;// 当前值

@property (nonatomic, copy) NSString *itemText;// 设置项

@property (nonatomic, copy) NSString *PlaceholderText;// 输入提醒

@property (nonatomic, weak) id<InputSettingDelegate> delegate;

@property (nonatomic, copy) void (^touchAlertEnter)(NSString *text);

@property (nonatomic, copy) void (^touchAlertCancel)();
@property (nonatomic, strong)UITextField *inputField;


/**
 弹出
 */
- (void)show;

/**
 关闭
 */
- (void)hide;

@end

NS_ASSUME_NONNULL_END
