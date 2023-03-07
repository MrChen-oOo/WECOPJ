//
//  ProgressLineView.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/28.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressLineView : UIView
//你还可以根据自己的需要创建其他的属性
@property (strong,nonatomic) UIColor *progressBackGroundColor;       //背景色
@property (strong,nonatomic) UIColor *progressTintColor;             //进度条颜色
@property (assign,nonatomic) CGFloat progressValue;                  //进度条进度的值
@property (assign,nonatomic) NSInteger progressCornerRadius;         //进度条圆角
@property (assign,nonatomic) NSInteger progressBorderWidth;          //进度条边宽度
@property (assign,nonatomic) BOOL isBeing;                           //是否显示百分比

@end
