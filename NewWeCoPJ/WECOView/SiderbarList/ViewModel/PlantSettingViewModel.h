//
//  PlantSettingViewModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import <Foundation/Foundation.h>
#import "TimeModel.h"
#import "RBaseViewModel.h"


@interface PlantSettingViewModel : RBaseViewModel

@property (nonatomic, strong) NSMutableArray<TimeModel *> * batteryChargArray;
@property (nonatomic, strong) NSMutableArray<TimeModel *> * batteryDisChargArray;
@property (nonatomic, strong) NSMutableArray * timeChargArray;
@property (nonatomic, strong) NSMutableArray * timeValueArray;

@property (nonatomic, strong) NSMutableArray<NSMutableArray *> * electricityPriceArray;
@property (nonatomic, strong) NSMutableArray * electricityTitleArray;
@property (nonatomic, strong) NSMutableArray * priceArray;
@property (nonatomic, strong) SetElectricityPriceModel *priceParamModel;

@property (nonatomic, strong) PlanArrayModel * planModel;
@property (nonatomic, strong) ElectricityPriceModel * priceModel;
@property (nonatomic, strong) NSString *deviceStr;
@property (nonatomic, assign) NSInteger deviceType; // 1:逆变器 0:HMI
@property (nonatomic, assign) BOOL isTimeSet;

// 逆变器充放电计划时间获取
-(void)getInverterTimeSoltMsgWithCompleteBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

// 逆变器/HMI充放电计划时间设置
-(void)setUpPlantModelParamCompleteBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;


// HMI充放电计划时间获取
- (void)getHmiTimeSoltMsgWithCompleteBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

// HMI电价与时间段获取
- (void)getHmiElectricityPriceCompleteBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

// HMI电价与时间段设置
- (void)setHmiElectricityPriceCompleteBlock:(void(^)(NSString *resultStr, NSString *codeStr))completeBlock;

@end


