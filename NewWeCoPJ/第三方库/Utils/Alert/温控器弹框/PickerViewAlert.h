//
//  PickerViewAlert.h
 
//
//  Created by BQ123 on 2018/7/6.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewAlert : UIView

@property (nonatomic, copy) void (^touchEnterBlock)(NSInteger time);
@property (nonatomic, copy) void (^touchCancelBtn)();

- (instancetype)initWithType:(NSString *)type;

-(void)show;

- (void)remove;

@end
