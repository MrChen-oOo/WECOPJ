//
//  progressAlert.h
 
//
//  Created by BQ123 on 2018/6/22.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface progressAlert : UIView

@property (nonatomic, assign)NSInteger progress;

@property (nonatomic, copy) void (^cancelBlock)();

/**
 弹出
 */
- (void)show;

/**
 关闭
 */
- (void)hide;

@end
