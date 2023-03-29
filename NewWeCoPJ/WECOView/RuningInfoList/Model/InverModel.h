//
//  InverModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <Foundation/Foundation.h>

@interface InverModel : NSObject
@property (nonatomic, strong) NSString * invACurrent;
@property (nonatomic, strong) NSString * invAFreq;
@property (nonatomic, strong) NSString * invAPower;
@property (nonatomic, strong) NSString * invAVoltage;
@property (nonatomic, strong) NSString * invBCurrent;
@property (nonatomic, strong) NSString * invBFreq;
@property (nonatomic, strong) NSString * invBPower;
@property (nonatomic, strong) NSString * invBVoltage;
@property (nonatomic, strong) NSString * invCCurrent;
@property (nonatomic, strong) NSString * invCFreq;
@property (nonatomic, strong) NSString * invCPower;
@property (nonatomic, strong) NSString * invCVoltage;


@end

@interface InverBatteryInfoModel : NSObject
@property (nonatomic, strong) NSString * batChargeCurrentLimite;
@property (nonatomic, strong) NSString * batCurrent;
@property (nonatomic, strong) NSString * batDisChargeCurrentLimite;
@property (nonatomic, strong) NSString * batSoc;
@property (nonatomic, strong) NSString * batVoltage;
@property (nonatomic, strong) NSString * bmsBatCellMaxTemperature;
@property (nonatomic, strong) NSString * bmsBatCellMaxVoltage;
@property (nonatomic, strong) NSString * bmsBatCellMinTemperature;
@property (nonatomic, strong) NSString * bmsBatCellMinVoltage;

@end


@interface InverGridInfoModel : NSObject

@property (nonatomic, strong) NSString * gridACurrent;
@property (nonatomic, strong) NSString * gridAPower;
@property (nonatomic, strong) NSString * gridAVoltage;
@property (nonatomic, strong) NSString * gridBCurrent;
@property (nonatomic, strong) NSString * gridBPower;
@property (nonatomic, strong) NSString * gridBVoltage;
@property (nonatomic, strong) NSString * gridCCurrent;
@property (nonatomic, strong) NSString * gridCPower;
@property (nonatomic, strong) NSString * gridCVoltage;
@property (nonatomic, strong) NSString * gridFreq;

@end

@interface InverBasicInfoModel : NSObject
@property (nonatomic, strong) NSString * armInnerVer;
@property (nonatomic, strong) NSString * deviceSn;
@property (nonatomic, strong) NSString * dspInnerVer;
@property (nonatomic, strong) NSString * lastUpdateTime;
@property (nonatomic, strong) NSString * workMode;

@end


@interface InverLoadInfoModel : NSObject
@property (nonatomic, strong) NSString * loadACurrent;
@property (nonatomic, strong) NSString * loadAPower;
@property (nonatomic, strong) NSString * loadARate;
@property (nonatomic, strong) NSString * loadAVoltage;
@property (nonatomic, strong) NSString * loadBCurrent;
@property (nonatomic, strong) NSString * loadBPower;
@property (nonatomic, strong) NSString * loadBRate;
@property (nonatomic, strong) NSString * loadBVoltage;
@property (nonatomic, strong) NSString * loadCCurrent;
@property (nonatomic, strong) NSString * loadCPower;
@property (nonatomic, strong) NSString * loadCRate;
@property (nonatomic, strong) NSString * loadCVoltage;

@end

@interface InverPvInfoModel : NSObject

@property (nonatomic, strong) NSString * pv1Current;
@property (nonatomic, strong) NSString * pv1Power;
@property (nonatomic, strong) NSString * pv1Voltage;
@property (nonatomic, strong) NSString * pv2Current;
@property (nonatomic, strong) NSString * pv2Power;
@property (nonatomic, strong) NSString * pv2Voltage;
@property (nonatomic, strong) NSString * pv3Current;
@property (nonatomic, strong) NSString * pv3Power;
@property (nonatomic, strong) NSString * pv3Voltage;
@property (nonatomic, strong) NSString * pv4Current;
@property (nonatomic, strong) NSString * pv4Power;
@property (nonatomic, strong) NSString * pv4Voltage;

@end


@interface InveterMsgInfoModel : NSObject

@property (nonatomic , strong) InverBasicInfoModel *basicInfo;
@property (nonatomic , strong) InverBatteryInfoModel *batteryInfo;
@property (nonatomic , strong) InverGridInfoModel *gridInfo;
@property (nonatomic , strong) InverModel *inverterInfo;
@property (nonatomic , strong) InverLoadInfoModel *loadInfo;
@property (nonatomic , strong) InverPvInfoModel *pvInfo;

@end

