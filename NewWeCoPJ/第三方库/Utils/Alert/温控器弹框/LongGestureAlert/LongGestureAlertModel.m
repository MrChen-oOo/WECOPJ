//
//  LongGestureAlertModel.m
//  HyacinthBean
//
//  Created by liu on 2017/7/20.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "LongGestureAlertModel.h"

@implementation LongGestureAlertModel

+ (instancetype)LongGestureAlertModelWithMenuItemTitle:(NSString *)menuItemTitle  menuBlock:(LongGestureAlertBlock)longGestureAlertBlock{
    
    LongGestureAlertModel *model = [LongGestureAlertModel new];
    model.title = menuItemTitle;
    model.longGestureAlertBlock = longGestureAlertBlock;
    
    
    return model;
}


@end
