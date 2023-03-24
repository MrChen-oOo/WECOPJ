//
//  SettingModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingModel : NSObject

/**
 * 1. Load Prioritized（负载优先）
 * 2. Plan Mode（计划模式）
 * 3. Bat Prioritized（电池优先）
 */
@property (nonatomic, strong) NSString * workMode;
@property (nonatomic, strong) NSString * date;                 //日期; 20200808 二零二零年八月八号
@property (nonatomic, strong) NSString * time;                  //时间
@property (nonatomic, strong) NSString * epsBackupEnable;       //EPS/Backup Enable 后备使能
@property (nonatomic, strong) NSString * pvInputType;           //PV输入类型 独立：0， 并联：1，恒压：2
@property (nonatomic, strong) NSString * arcEnable;             //ARC Enable（拉弧检测）禁止：0， 允许：1
@property (nonatomic, strong) NSString * antiReflux;            //0x340D-防逆流
@property (nonatomic, strong) NSString * ctRatio;               //0x3430-CT变化【10030000】
@property (nonatomic, strong) NSString * batGridDod;            //电池放电深度[10%, 90%]
@property (nonatomic, strong) NSString * offGridDod;            //离网DOD    [190]
@property (nonatomic, strong) NSString * batEodHyst;            //电池回差    Bat EodHyst    [5,90]
@property (nonatomic, strong) NSString * gridStandard;          //国家电网标准    [9]
@property (nonatomic, strong) NSString * gridSet;               // 电网设置 0：220V单相  1：120V/240V 2;：120V/208V 3;120V单相
@property (nonatomic, strong) NSString * invParallelNum;        //并机台数 0x343D
@property (nonatomic, strong) NSString * invParallelIdentity;
@property (nonatomic, assign) NSInteger  InvParallelAddr;       //并机地址 0x343E
@property (nonatomic, strong) NSString * commonBatteryEnable;   //x共用电池）0x343C（里的bit2）
/**
 * x（共用CT使能）
 * 0x343C（里的bit3）
 */
@property (nonatomic, strong) NSString * commonGridctEnable;
@property (nonatomic, strong) NSString * pHaseEnable;            //（组三相使能）0x343C（里的bit4）
@property (nonatomic, strong) NSString * parallelChargeCurrent;  //（并机充电电流）0x343A     0-1000    0-1000
@property (nonatomic, strong) NSString * parallelDischargeCurrent;  //并机放电电流 0x343B
@property (nonatomic, strong) NSString * invParallelEnable;      //并机使能 0x343C（里的bit0）


/**
 * 发电机启动SOC
 * 0x3431
 */
@property (nonatomic, strong) NSString * generatorStartSoc;
@property (nonatomic, strong) NSString * generatorStopSoc;       //(发电机停止SOC）    0x3432 0-100    0.9
@property (nonatomic, strong) NSString * generatorChargesCurrent; //发电机充电电流0x3433 0-200    30A
@property (nonatomic, strong) NSString * genEnable;
@property (nonatomic, strong) NSString * genManualCmd;
@property (nonatomic, strong) NSString * genManualOn;
@property (nonatomic, strong) NSString * genAutoStart;
@property (nonatomic, strong) NSString * genConnectToGridInput;
@property (nonatomic, strong) NSString * genChargeEnable;
/**
 * （发电机最大运行时间）0x3434
 * //0-240    120表示12小时
 * //120 is 12 hours
 */
@property (nonatomic, strong) NSString * maximumOperatingTim;
@property (nonatomic, strong) NSString * maximumLoadPower;
@property (nonatomic, strong) NSString * generatorCoolingTime;   //发电机冷却时间）    0x3435     0-240    120表示12小时
@property (nonatomic, strong) NSString * generatorPower;         //发电机功率）0x3441 [0-30000]    8000
@property (nonatomic, strong) NSString * gridPower;              //0x3403-并网功率调度
@property (nonatomic, strong) NSString * batDischargePower;      //0x3404-电池放电功率调度
@property (nonatomic, strong) NSString * batChargeCurrent;       //0x3402-电池充电电流
@property (nonatomic, strong) NSString * pvPower;                //0x3411-PV功率
@property (nonatomic, strong) NSString * modbusID;               //modbus本机地址 0x3439
@property (nonatomic, strong) NSString * modbusBaud;            //modbus波特率 0x3468
@property (nonatomic, strong) NSString * restoreFactorySetting;  //恢复出厂设置    1：OK    0x3416
@property (nonatomic, strong) NSString *  usaStandardClass;       //美标分类 【0-5】
@property (nonatomic, strong) NSString *  switchMachine;          //开关机





///-------------------------------------------------------------------------PCS Model-------------------------------------------------------------------------


//@property (nonatomic, strong) NSString * workMode;
//@property (nonatomic, strong) NSString * date;
//@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * oilEngineRatedCapacity;
//@property (nonatomic, strong) NSString * maximumLoadPower;
@property (nonatomic, strong) NSString * batterySocUpLimit;
@property (nonatomic, strong) NSString * socReturnDifference;
@property (nonatomic, strong) NSString * gridSocLowerLimit;
@property (nonatomic, strong) NSString * offGridSocLowerLimit;
@property (nonatomic, strong) NSString * shutdownSocLimit;
@property (nonatomic, strong) NSString * gridPowerUpLimit;
@property (nonatomic, strong) NSString * transformerCapacity;
@property (nonatomic, strong) NSString * tipWhenElec;
@property (nonatomic, strong) NSString * tipWhenElecStart;
@property (nonatomic, strong) NSString * tipWhenElecEnd;
@property (nonatomic, strong) NSString * peakElec;
@property (nonatomic, strong) NSString * peakElecStart;
@property (nonatomic, strong) NSString * peakEleccEnd;
@property (nonatomic, strong) NSString * ordinaryTimeElec;
@property (nonatomic, strong) NSString * ordinaryTimeElecStart;
@property (nonatomic, strong) NSString * ordinaryTimeElecEnd;
@property (nonatomic, strong) NSString * valleyOfElec;
@property (nonatomic, strong) NSString * valleyOfElecStart;
@property (nonatomic, strong) NSString * valleyOfElecEnd;
@property (nonatomic, strong) NSString * systemUpOff;











@end

@interface DeviceModel : NSObject
@property (nonatomic, strong) NSString * ID;                // 电站id
@property (nonatomic, strong) NSMutableArray * mgrnList;    // MGRN设备列表
@property (nonatomic, strong) NSMutableArray * pcsList;     // HMI设备列表
@property (nonatomic, strong) NSString * plantName;         // 电站名称
@property (nonatomic, strong) NSString * plantStatus;       // 0:离线 1:在线 2:告警
@property (nonatomic, assign) NSInteger  plantType;         // 0:HMI 1:MGRN

@end


NS_ASSUME_NONNULL_END
