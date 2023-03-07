//
//  BluetoolsManageVC.h
//  ShinePhone
//
//  Created by CBQ on 2022/4/12.
//  Copyright © 2022 qwl. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol BluetoolsManageVCDelegate <NSObject>

@optional

- (void)SocketConnectIsSucces:(BOOL)isSucces;

- (void)TCPSocketReadData:(NSDictionary *)dataDic;// 获取设置

- (void)TCPSocketActionSuccess:(BOOL)isSuccess CMD:(int)cmd devtype:(NSString *)devtype;// 是否设置成功

- (void)BTManageState:(CBManagerState)State; //错误提示

- (void)TCPSocketUpDataReadDataStatus:(int)status AllNumb:(int)AllDataNumb nowData:(int)nowDataNumb;//升级回调

- (void)ConnectBluetoolsLost;//升级回调
//- (void)isBackValue:(BOOL)isBack;//连接上蓝牙会发一个订阅值，等这个值返回后才可以发数据，不然会粘包导致错误
- (void)BTgetDataTimeOut; //错误提示


@end
@interface BluetoolsManageVC : NSObject
+ (BluetoolsManageVC *)instance;
@property (nonatomic, weak) id <BluetoolsManageVCDelegate> delegate;

@property (nonatomic, strong) NSMutableDictionary *ChargDictionary;

@property (nonatomic, copy) void (^GetBluePeripheralBlock)(id obj,NSDictionary *BlueDic);  // 搜索蓝牙结果

@property (nonatomic, copy) void (^ConnectBluePeripheralBlock)(id obj);  // 连接结果

@property (nonatomic, strong) NSMutableArray *peripheralArray;// 存储的设备

@property (nonatomic, strong) CBPeripheral *cbperipheral;// 扫描到的设备

@property (nonatomic, assign) BOOL isConnectSuccess;
@property (nonatomic, strong) NSString *ScanSn;

// 扫描设备
- (void)scanForPeripherals;
//停止扫描
- (void)StopScanForPeripherals;

// 连接设备
- (void)connectToPeripheral:(CBPeripheral *)device;

// 断开连接
- (void)disconnectToPeripheral;

//心跳这里连接成功后开启心跳机制，3秒钟发一个心跳包
//- (void)startHeartBeat;
//- (BOOL)isHeartTimerValid;
//- (void)stopHeartBeat;



#pragma mark -- 连接指令 1
- (void)connectToDev:(NSArray *)OrderArr devType:(NSString *)devType;

#pragma mark -- 设置命令 2
- (void)dataSetWithDataDic:(NSDictionary *)dataDic devType:(NSString *)devType;

#pragma mark -- 升级命令 3
- (void)updataCollectorVersion:(NSData *)upData upNumb:(int)dataAllNum dataNum:(int)dataNum;




@end

NS_ASSUME_NONNULL_END
