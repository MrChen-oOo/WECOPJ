//
//  HSDropDownMenu.h
//  瑞能云
//
//  Created by BQ123 on 2019/1/27.
//  Copyright © 2019 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSDropDownMenu : UIView<UITableViewDelegate>

@property (nonatomic, assign) NSInteger expandHeight;// 展开高度, 默认是展开后6个cell的高度

@property (nonatomic, assign) BOOL isExpanded;// 是否已经展开

@property (nonatomic, assign) NSInteger currentSelect;

@property (nonatomic, copy) void (^returnDropDownSelectNumber)(NSInteger num);

//显示选择菜单
/*
 buttonFrame 选择按钮在self.view的frame
 titleArr 选择菜单的文本数组
 imageArr 选择菜单的图片数组
 */
- (instancetype)initWithFrame:(CGRect)frame arrayOfTitle:(NSArray *)titleArr arrayOfImage:(NSArray *)imageArr;


@end

NS_ASSUME_NONNULL_END
