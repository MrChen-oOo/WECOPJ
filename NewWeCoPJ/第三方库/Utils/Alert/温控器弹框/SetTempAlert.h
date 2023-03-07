//
//  SetTempAlert.h
 
//
//  Created by BQ123 on 2018/7/6.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTempAlert : UIView

@property (nonatomic, copy) void (^touchEnterBlock)(CGFloat temp);


- (instancetype)initWithCurrentTemp:(CGFloat)starTemp endTemp:(CGFloat)endtemp;

- (void)tempNowValueSet:(CGFloat)tempValue;
/**
 弹出
 */
- (void)show;

/**
 关闭
 */
- (void)hide;

@end
