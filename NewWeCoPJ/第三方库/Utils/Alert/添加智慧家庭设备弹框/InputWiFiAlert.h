//
//  InputWiFiAlert.h
 
//
//  Created by BQ123 on 2018/6/21.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputWiFiAlert : UIView


@property (nonatomic, strong)NSString *wifiName;

/**
 更换wifi
 */
@property (nonatomic, copy) void (^replaceWiFiBlock)();

/**
 
 */
@property (nonatomic, copy) void (^touchEnterBlock)(NSString *password);

/**
 弹出
 */
- (void)show;

/**
 关闭
 */
- (void)hide;

@end
