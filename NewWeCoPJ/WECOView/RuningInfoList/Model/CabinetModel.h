//
//  CabinetModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <Foundation/Foundation.h>



@interface CabinetModel : NSObject

@property (nonatomic, strong) NSString * acACAA;
@property (nonatomic, strong) NSString * acACActivePower;
@property (nonatomic, strong) NSString * acACAV;
@property (nonatomic, strong) NSString * acACBA;
@property (nonatomic, strong) NSString * acACBV;
@property (nonatomic, strong) NSString * acACCA;
@property (nonatomic, strong) NSString * acACCV;
@property (nonatomic, strong) NSString * acACFrequency;
@property (nonatomic, strong) NSString * acACReactivePower;
@property (nonatomic, strong) NSString * acDCPortA;
@property (nonatomic, strong) NSString * acDCPortPower;
@property (nonatomic, strong) NSString * acDCPortV;
@property (nonatomic, strong) NSString * runtimeStatus;
@property (nonatomic, strong) NSString * workingMode;

@end


@interface CabinetBasicInfoModel : NSObject

@property (nonatomic, strong) NSString *deviceSn;
@property (nonatomic, strong) NSString *hardWareVer;
@property (nonatomic, strong) NSString *lastUpdateTime;
@property (nonatomic, strong) NSString *softWareVer;
@property (nonatomic, strong) NSString * sysOperaPolicyMode;

@end


@interface CabinetBatteryInfoModel : NSObject
@property (nonatomic, strong) NSString * batteryAHighV;
@property (nonatomic, strong) NSString * batteryALowV;
@property (nonatomic, strong) NSString * batteryCurrent;
@property (nonatomic, strong) NSString * batteryMaxDischargeCurrent;
@property (nonatomic, strong) NSString * batteryMaxRechargeCurrent;
@property (nonatomic, strong) NSString * batteryMaxTemperature;
@property (nonatomic, strong) NSString * batteryMinTemperature;
@property (nonatomic, strong) NSString * batteryRunStatus;
@property (nonatomic, strong) NSString * batterySOC;
@property (nonatomic, strong) NSString * batterySOH;
@property (nonatomic, strong) NSString * batteryV;

@end

@interface CabinetGridInfoModel : NSObject

@property (nonatomic, strong) NSString * gridSideMeterACurrent;
@property (nonatomic, strong) NSString * gridSideMeterBCurrent;
@property (nonatomic, strong) NSString * gridSideMeterCCurrent;
@property (nonatomic, strong) NSString * gridSideMeterFrequencyF;
@property (nonatomic, strong) NSString * gridSideMeterThreeActivePower;
@property (nonatomic, strong) NSString * gridSideMeterThreeReactivePower;
@property (nonatomic, strong) NSString * gridSideMeteVoltageUA;
@property (nonatomic, strong) NSString * gridSideMeteVoltageUB;
@property (nonatomic, strong) NSString * gridSideMeteVoltageUC;

@end

@interface CabinetMpptModel : NSObject
@property (nonatomic, strong) NSString * mpptHighSideA;
@property (nonatomic, strong) NSString * mpptHighSideP;
@property (nonatomic, strong) NSString * mpptHighSideV;
@property (nonatomic, strong) NSString * mpptLowSideA;
@property (nonatomic, strong) NSString * mpptLowSideP;
@property (nonatomic, strong) NSString * mpptLowSideV;
@property (nonatomic, strong) NSString * mpptRuntimeStatus;
@end


@interface CabinetMsgInfoModel : NSObject

@property (nonatomic, strong) NSMutableArray <CabinetModel *>* acModelList;
@property (nonatomic, strong) CabinetBasicInfoModel *basicInfo;
@property (nonatomic, strong) CabinetBatteryInfoModel *batteryInfo;
@property (nonatomic, strong) CabinetGridInfoModel * gridInfo;
@property (nonatomic, strong) NSMutableArray <CabinetMpptModel *>* mpptList;

@end
