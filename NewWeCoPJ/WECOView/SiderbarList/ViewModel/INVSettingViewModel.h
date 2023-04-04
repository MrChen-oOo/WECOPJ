//
//  INVSettingViewModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/15.
//

#import <Foundation/Foundation.h>
#import "SettingModel.h"
#import "SettingOptionModel.h"
#import "BasicTableViewCell.h"
#import "RBaseViewModel.h"

@interface INVSettingViewModel : RBaseViewModel

@property (nonatomic, strong)SettingOptionModel *optionModel;
@property (nonatomic, strong)SettingModel *settingModel;
@property (nonatomic, strong)NSString *deviceSnStr;
@property (nonatomic, assign)BOOL isHaveDevice;                     // 是否绑定逆变器或者HMI设备
@property (nonatomic, assign)NSInteger deviceType;                  // 设备类型 0:HMI 1:MGRN
@property (nonatomic, strong)DeviceModel *deviceModel;

// 逆变器数据获取
-(void)getSettingInverterParamMsgCompleteBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

// 逆变器数据设置
-(void)setUpInverterSingleParam:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

// 逆变器系统时间设置
-(void)setInverterTimeParam:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;


///-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// HMI设备数据获取
- (void)getPcsParamMsgCompleteBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

// HMI设备数据设置
- (void)setHMIParam:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

// HMI系统时间设置
- (void)setPcsSystemTimeParm:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

@end


