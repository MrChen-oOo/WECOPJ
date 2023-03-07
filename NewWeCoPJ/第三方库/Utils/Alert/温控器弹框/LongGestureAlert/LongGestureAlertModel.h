//
//  LongGestureAlertModel.h
//  HyacinthBean
//
//  Created by liu on 2017/7/20.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LongGestureAlertModel : NSObject

//定义一个菜单的block
typedef void(^LongGestureAlertBlock)();


@property (nonatomic, copy) LongGestureAlertBlock longGestureAlertBlock;

@property (nonatomic,copy)NSString *title;

+ (instancetype)LongGestureAlertModelWithMenuItemTitle:(NSString *)menuItemTitle  menuBlock:(LongGestureAlertBlock)longGestureAlertBlock;

@end
