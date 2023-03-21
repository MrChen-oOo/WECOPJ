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
@property (nonatomic, assign)BOOL isMgrnDevice;
@property (nonatomic, strong)DeviceModel *deviceModel;

-(void)getSettingInverterParamMsgWithParam:(NSString *)param completeBlock:(void(^)(NSString *resultStr))completeBlock;

-(void)setUpInverterSingleParam:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr))completeBlock;

-(void)setInverterTimeParam:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr))completeBlock;

-(void)getPowerStationMessageWith:(NSString *)idStr completeBlock:(void(^)(NSString *resultStr))completeBlock;
@end


