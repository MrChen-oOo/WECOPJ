//
//  PlantSettingViewController.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlantSettingViewController : RedxRootNewViewController

@property (nonatomic, strong)NSString *deviceSnStr;
@property (nonatomic, assign)BOOL isTimePlan;      // YES：时间计划设置 NO：电价设置
@property (nonatomic, assign)NSInteger deviceType; // 1:逆变器 0:HMI

@end

NS_ASSUME_NONNULL_END
