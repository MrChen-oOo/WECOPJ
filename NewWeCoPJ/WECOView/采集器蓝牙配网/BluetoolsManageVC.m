//
//  HSBluetoochManager.m
//  ShinePhone
//
//  Created by growatt007 on 2018/7/17.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import "BluetoolsManageVC.h"
//#import "BluetoolsHelp.h"
#import "BluetoolsHelp.h"
#define timeOut 5
@interface BluetoolsManageVC ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;

@property (nonatomic, assign) CBManagerState peripheralState;// 外设状态

@property (nonatomic, strong) CBCharacteristic *writeChatacteristic; // 写特征

@property (nonatomic, strong) CBCharacteristic *readCharacteristic; // 读特征

@property (nonatomic, strong) NSMutableData *NotificationData;
@property (nonatomic, strong) NSString *devType;
@property (nonatomic, strong) NSMutableDictionary *MassageDic;
@property (nonatomic, assign) BOOL isFirstConnectBack;
@property(nonatomic, strong) NSTimer *heartTimer;
@property(nonatomic, strong) NSTimer *getDataTimer;
@property(nonatomic, assign) int timerInt;
@property(nonatomic, strong) NSData *CmdData;
@property(nonatomic, assign) CBCharacteristicWriteType responType;
@property(nonatomic, assign) int connectNumb;
@property(nonatomic, strong) NSTimer *reSendTimer;
@property (nonatomic, assign) BOOL isConnectIng;
@property(nonatomic, assign) int resendNumb;
@property(nonatomic, strong) NSMutableData *AllGetData;
@property(nonatomic, strong) NSData *SendData1;

@end

// 蓝牙4.0设备名 5314EEEC-427F-4BB8-9842-46A6977B608E
static NSString * const kBlePeripheralName = @"Growatt_0002";
// 通知服务
static NSString * const kNotifyServerUUID = @"00FF";
// 写服务
static NSString * const kWriteServerUUID = @"00FF";
// 通知特征值
static NSString * const kNotifyCharacteristicUUID = @"FF01";
//写特征值
static NSString * const kReadCharacteristicUUID =  @"FF02";
// 写特征值
static NSString * const kWriteCharacteristicUUID =  @"FF03";

Byte loginMask[4] = {0x5a, 0xa5, 0x5a, 0xa5}; // 登录掩码

Byte randomMask[4] = {}; // 随机掩码

@implementation BluetoolsManageVC


+ (BluetoolsManageVC *)instance {
    static dispatch_once_t onceToken;
    static BluetoolsManageVC *bluetoothManager;
    dispatch_once(&onceToken, ^{
        bluetoothManager = [[BluetoolsManageVC alloc]init];
    });
    return bluetoothManager;
}

- (instancetype)init{
    if (self = [super init]) {
        
        
        
        self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey:@NO}];
        randomMask[0] = strtoul([[BluetoolsHelp ToHex:arc4random() % 256] UTF8String], 0, 16);
        randomMask[1] = strtoul([[BluetoolsHelp ToHex:arc4random() % 256] UTF8String], 0, 16);
        randomMask[2] = strtoul([[BluetoolsHelp ToHex:arc4random() % 256] UTF8String], 0, 16);
        randomMask[3] = strtoul([[BluetoolsHelp ToHex:arc4random() % 256] UTF8String], 0, 16);
    }
    return self;
}

- (NSMutableArray *)peripheralArray{
    if (!_peripheralArray) {
        _peripheralArray = [NSMutableArray array];
    }
    return _peripheralArray;
}

- (NSMutableData *)NotificationData{
    if (!_NotificationData) {
        _NotificationData = [[NSMutableData alloc]init];
    }
    return _NotificationData;
}

- (NSMutableDictionary *)ChargDictionary{
    if (!_ChargDictionary) {
        _ChargDictionary = [[NSMutableDictionary alloc]init];
    }
    return _ChargDictionary;
}

// 扫描设备
- (void)scanForPeripherals{
    [self.centralManager stopScan];
    NSLog(@"扫描设备");
    if (self.peripheralState == CBManagerStatePoweredOn){
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    }else{
        
        if ([self.delegate respondsToSelector:@selector(BTManageState:)]) {
            
            [self.delegate BTManageState:self.peripheralState];
        }
        
    }
}
- (void)StopScanForPeripherals{
    [_getDataTimer invalidate];
    _getDataTimer = nil;
    [self.centralManager stopScan];
}

// 连接设备
- (void)connectToPeripheral:(CBPeripheral *)device {
    
    self.cbperipheral = device;//self.peripheralArray[index];
    if (self.cbperipheral != nil) {
        NSLog(@"连接设备");
//        [self disconnectToPeripheral]; // 断开
        self.isFirstConnectBack = YES;
        self.isConnectIng = YES;
        [self.centralManager connectPeripheral:self.cbperipheral options:nil];// 连接
    }else{
        NSLog(@"无设备可连接");
    }
}

// 断开连接
- (void)disconnectToPeripheral{
    if (self.cbperipheral != nil) {
        NSLog(@"断开连接");
        self.isConnectIng = NO;
        [self.centralManager cancelPeripheralConnection:self.cbperipheral];
    }
}

// 手机蓝牙状态更新时调用
- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    
    if ([self.delegate respondsToSelector:@selector(BTManageState:)]) {
        
        [self.delegate BTManageState:central.state];
    }
    switch (central.state) {
        case CBManagerStateUnknown:{
            NSLog(@"系统蓝牙当前状态不明确");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateResetting:
        {
            NSLog(@"重置状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateUnsupported:
        {
            NSLog(@"系统蓝牙设备不支持");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateUnauthorized:
        {
            NSLog(@"系统蓝未被授权");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStatePoweredOff:
        {
            NSLog(@"系统蓝牙关闭了，请先打开蓝牙");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStatePoweredOn:
        {
            NSLog(@"开启状态－可用状态");
            self.peripheralState = central.state;
            
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        }
            break;
        default:
            break;
    }
    
    
}


/**
 扫描到设备
 
 @param central 中心管理者
 @param peripheral 扫描到的设备
 @param advertisementData 广告信息
 @param RSSI 信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    NSData *getdata = advertisementData[@"kCBAdvDataManufacturerData"];
    if (getdata) {
        NSData *subdata = [self safe_subData:getdata withRange:NSMakeRange(0, 2)];
        NSString *gTag = @"";
        if (subdata) {
            gTag = [[NSString alloc]initWithData:subdata encoding:NSUTF8StringEncoding];
//            gTag = [gTag lowercaseString];


        }
        
        if ([gTag isEqualToString:@"g:"] || [gTag isEqualToString:@"G:"]) {//小g为未授权，大G为已授权，需要授权密钥
            NSLog(@"搜索到的设备: %@",peripheral);
            NSLog(@"信息: %@",advertisementData);
//            NSData *subdata2 = [self safe_subData:getdata withRange:NSMakeRange(2, 2)];
//            if (subdata2) {
//                NSString *gType = [[NSString alloc]initWithData:subdata2 encoding:NSUTF8StringEncoding];//WIFI_BT = 34
//                if ([gType isEqualToString:@"34"]) {
                    NSString *blueName = advertisementData[@"kCBAdvDataLocalName"];
                    if (kStringIsEmpty(blueName)) {
                        blueName = peripheral.name;
                    }
                    
                    if (!kStringIsEmpty(_ScanSn)) {
                        if ([blueName isEqualToString:_ScanSn]) {
                            if (![self.peripheralArray containsObject:peripheral]){
                                [self.peripheralArray addObject:peripheral];
                               

                            }
                            if(self.GetBluePeripheralBlock){
                                
                             self.GetBluePeripheralBlock(peripheral,@{@"name":blueName,@"Auth":gTag});
                            }
                        }
                    }else{
                        if (![self.peripheralArray containsObject:peripheral]){
                            [self.peripheralArray addObject:peripheral];
                           

                        }
                        if(self.GetBluePeripheralBlock){
                            
                            self.GetBluePeripheralBlock(peripheral,@{@"name":blueName,@"Auth":gTag});
                        }
                    }
                    
//                }
//
//            }
            
//            if (!kStringIsEmpty(peripheral.name)) {
               
//            }
            
        }
    }
    
    
    
}


/**
 连接失败
 
 @param central 中心管理者
 @param peripheral 连接失败的设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
//    if ([peripheral.name isEqualToString:kBlePeripheralName])
//    {
//        [self.centralManager connectPeripheral:peripheral options:nil];
//    }
    
    if ([peripheral isEqual:self.cbperipheral]) {
        [self.centralManager connectPeripheral:peripheral options:nil]; // 重连
    }
    self.isConnectSuccess = NO; // 连接失败
    if(self.ConnectBluePeripheralBlock){
        self.ConnectBluePeripheralBlock(@"NO");
    }
    if ([self.delegate respondsToSelector:@selector(SocketConnectIsSucces:)]) {
        [self.delegate SocketConnectIsSucces:NO];
    }
}

/**
 连接成功
 
 @param central 中心管理者
 @param peripheral 连接成功的设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //停止中心管理设备的扫描动作，要不然在你和已经连接好的外设进行数据沟通时，如果又有一个外设进行广播且符合你的连接条件，那么你的iOS设备也会去连接这个设备（因为iOS BLE4.0是支持一对多连接的），导致数据的混乱。
    [self.centralManager stopScan];

    NSLog(@"连接设备:%@成功",peripheral.name);
    self.cbperipheral = peripheral;
    // 设置设备的代理
    peripheral.delegate = self;
    // services:传入nil代表扫描所有服务
    [peripheral discoverServices:nil];
    self.connectNumb = 0;
    self.isConnectIng = YES;
    self.isConnectSuccess = YES; // 连接成功
    if(self.ConnectBluePeripheralBlock){
        self.ConnectBluePeripheralBlock(@"YES");
    }
    if ([self.delegate respondsToSelector:@selector(SocketConnectIsSucces:)]) {
        [self.delegate SocketConnectIsSucces:YES];
    }
}

// 设备掉线
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"掉线");
    if ([self.delegate respondsToSelector:@selector(ConnectBluetoolsLost)]) {
        [self.delegate ConnectBluetoolsLost];
        
    }
    self.isConnectSuccess = NO; // 连接失败
    if(self.ConnectBluePeripheralBlock){
        self.ConnectBluePeripheralBlock(@"NO");
    }
   
    if (_isConnectIng) {//异常掉线重连
        _connectNumb ++;
        if (_connectNumb < 4) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([peripheral isEqual:self.cbperipheral]) {
                    [self connectToPeripheral:self.cbperipheral]; // 重连
                }

            });
        }
//        if ([self.delegate respondsToSelector:@selector(ConnectBluetoolsLost)]) {
//            [self.delegate ConnectBluetoolsLost];
//
//        }

        
        
    }
}

/**
 扫描到服务
 
 @param peripheral 服务对应的设备
 @param error 扫描错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 遍历所有的服务
    for (CBService *service in peripheral.services)
    {
        NSLog(@"服务:%@",service.UUID.UUIDString);
        
        // 获取对应的服务
        if ([service.UUID.UUIDString isEqualToString:kWriteServerUUID] || [service.UUID.UUIDString isEqualToString:kNotifyServerUUID])
        {
            // 根据服务去扫描特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}


/**
 扫描到对应的特征
 
 @param peripheral 设备
 @param service 特征对应的服务
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // 遍历所有的特征
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"特征值:%@",characteristic.UUID.UUIDString);
        if ([characteristic.UUID.UUIDString isEqualToString:kWriteCharacteristicUUID])
        {
            self.writeChatacteristic = characteristic;
        }
        if ([characteristic.UUID.UUIDString isEqualToString:kNotifyCharacteristicUUID])
        {
            self.readCharacteristic = characteristic;
            // 订阅特征
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}

//向peripheral中写入数据后的回调函数
- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
//    _timerInt = 0;
//    if (!_getDataTimer) {
//        _getDataTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//
//            self.timerInt ++;
//            if (self.timerInt > timeOut) {//
//                [timer invalidate];
//                if ([self.delegate respondsToSelector:@selector(BTgetDataTimeOut)]) {
//                    [self.delegate BTgetDataTimeOut];
//                }
//            }
//
//        }];
//    }else{
//        [_getDataTimer fire];
//    }
    NSLog(@"write value success(写入成功)");
    self.AllGetData = [[NSMutableData alloc]init];

    [peripheral readValueForCharacteristic:characteristic];
}

/**
 根据特征读到数据
 
 @param peripheral 读取到数据对应的设备
 @param characteristic 特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
//    [_getDataTimer invalidate];
    
    if ([characteristic.UUID.UUIDString isEqualToString:kNotifyCharacteristicUUID])
    {
        NSData *data = characteristic.value;
        NSLog(@"订阅特征读到的数据: %@",data);
        if (!data) return;
        if([data isEqualToData:_SendData1]){
            return;
        }
        if (self.isFirstConnectBack) {
            self.isFirstConnectBack = NO;
            [self BlueConnectToDevSendAuthKey];
//            if ([self.delegate respondsToSelector:@selector(isBackValue:)]) {
//                [self.delegate isBackValue:YES];
//            }
            return;
        }
        if ([_devType isEqualToString:@"keySet"]) {//密钥验证成功
            [[NSNotificationCenter defaultCenter]postNotificationName:@"BLUERECONNECTNOTIF" object:nil];
        }
        [self analysis:data];

    }
}

//发送密钥
- (void)BlueConnectToDevSendAuthKey{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSString *authkkey = @"shuoxd_aiot_local_wireless_key01";
//        NSString *authStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"AUTHKEYSTR"];
//        NSString *isbagG = [[NSUserDefaults standardUserDefaults]objectForKey:@"ISBAGGSET"];
//
//        if ([isbagG isEqualToString:@"G:"]) {
//            if (!kStringIsEmpty(authStr)) {
//                authkkey = authStr;
//            }
//        }
        NSDictionary *datadic = @{@"54":authkkey};

        [self dataSetWithDataDic:datadic devType:@"keySet"];//发送密钥
    });
}


#pragma mark -- 读取指令 1
- (void)connectToDev:(NSArray *)OrderArr devType:(NSString *)devType{//0x19读取数据,orderarr存要查询的参数编号
    NSLog(@"连接指令 1");

    self.devType = devType;

    NSData *bytesDa11 = [BluetoolsHelp dataWithString:@"0000000000" length:10];
    Byte *TimeByte = (Byte *)[bytesDa11 bytes];
    NSMutableData *bytesData = [[NSMutableData alloc]initWithBytes:TimeByte length:10];//10
    Byte *lenthDabyte= [BluetoolsHelp toByteIntNumb:(int)OrderArr.count];
    NSData *lenthDa11 = [[NSData alloc]initWithBytes:lenthDabyte length:2];
    [bytesData appendData:lenthDa11];// 个数 2

    int length = 10+2;
    for (int i = 0; i < OrderArr.count; i ++) {
        Byte *numDabyte= [BluetoolsHelp toByteIntNumb:[OrderArr[i] intValue]];
        NSData *numDa11 = [[NSData alloc]initWithBytes:numDabyte length:2];
        [bytesData appendData:numDa11];// 编号 2
        length += 2;
    }
   
    Byte *sendDataByte = (Byte *)[bytesData bytes];


    NSData *sendData = [BluetoolsHelp wifiSendDataProtocol:self.devType Cmd:@"0x19" DataLenght:length Payload:sendDataByte Mask:nil Useless:nil];
    if (sendData && self.readCharacteristic) {
        
        self.AllGetData = [[NSMutableData alloc]init];
        self.SendData1 = sendData;
        [self.cbperipheral writeValue:sendData forCharacteristic:self.readCharacteristic type:CBCharacteristicWriteWithResponse];

    }

}
#pragma mark -- 设置指令
- (void)dataSetWithDataDic:(NSDictionary *)dataDic devType:(NSString *)devType{


    self.devType = devType;
    NSData *bytesDa11 = [BluetoolsHelp dataWithString:@"0000000000" length:10];
    Byte *TimeByte = (Byte *)[bytesDa11 bytes];
    NSMutableData *bytesData = [[NSMutableData alloc]initWithBytes:TimeByte length:10];//10
    NSArray *keyArr = dataDic.allKeys;
    Byte *lenthDabyte= [BluetoolsHelp toByteIntNumb:(int)keyArr.count];
    NSData *lenthDa11 = [[NSData alloc]initWithBytes:lenthDabyte length:2];
    [bytesData appendData:lenthDa11];// 个数 2
    //数据长度
//    int datalength = 0;
//    for (int i = 0; i < keyArr.count; i ++) {
//        NSString *value = [NSString stringWithFormat:@"%@",dataDic[keyArr[i]]];
//        datalength += (int)(value.length+4);
//
//    }

    int appendLeng = 0;
    NSMutableData *dataappend = [[NSMutableData alloc]init];
    for (int i = 0; i < keyArr.count; i ++) {
        Byte *numDabyte= [BluetoolsHelp toByteIntNumb:[keyArr[i] intValue]];
        NSData *numDa11 = [[NSData alloc]initWithBytes:numDabyte length:2];
        [dataappend appendData:numDa11];// 编号 2
        appendLeng += 2;
        NSString *value22 = [NSString stringWithFormat:@"%@",dataDic[keyArr[i]]];

        NSData *appdata = [value22 dataUsingEncoding:NSUTF8StringEncoding];

        Byte *datalenthDabyte= [BluetoolsHelp toByteIntNumb:(int)appdata.length];
        NSData *datalenthDa11 = [[NSData alloc]initWithBytes:datalenthDabyte length:2];
        [dataappend appendData:datalenthDa11];// 数据长度 2
        appendLeng += 2;
        [dataappend appendData:appdata];// appdata.length
        appendLeng += appdata.length;

    }

    Byte *datalenthDabyte= [BluetoolsHelp toByteIntNumb:appendLeng];
    NSData *datalenthDa11 = [[NSData alloc]initWithBytes:datalenthDabyte length:2];
    [bytesData appendData:datalenthDa11];// 数据长度 2
    int length = 14;

    [bytesData appendData:dataappend];//

    length += appendLeng;
    
   
    Byte *sendDataByte = (Byte *)[bytesData bytes];
    

    NSData *sendData = [BluetoolsHelp wifiSendDataProtocol:self.devType Cmd:@"0x18" DataLenght:length Payload:sendDataByte Mask:nil
                                                        Useless:nil];

    NSLog(@"发送的:%@",sendData);
    if (sendData && self.writeChatacteristic) {
        self.AllGetData = [[NSMutableData alloc]init];
        self.SendData1 = sendData;

        [self.cbperipheral writeValue:sendData forCharacteristic:self.writeChatacteristic type:CBCharacteristicWriteWithResponse];

    }

    
}




- (void)updataCollectorVersion:(NSData *)upData upNumb:(int)dataAllNum dataNum:(int)dataNum{
    
    int allLength = 0;
    NSData *bytesDa11 = [BluetoolsHelp dataWithString:@"0000000000" length:10];
    Byte *TimeByte = (Byte *)[bytesDa11 bytes];
    NSMutableData *bytesData = [[NSMutableData alloc]initWithBytes:TimeByte length:10];//10
    allLength += 10;
    //数据长度
    int datalength = 4+(int)upData.length;
    
    Byte *datalenthDabyte= [BluetoolsHelp toByteIntNumb:datalength];
    NSData *datalenthDa11 = [[NSData alloc]initWithBytes:datalenthDabyte length:2];
    [bytesData appendData:datalenthDa11];// 数据长度 2
    allLength += 2;
    
    Byte *AllDataLengthbyte= [BluetoolsHelp toByteIntNumb:dataAllNum];
    NSData *AllDataLengthDa11 = [[NSData alloc]initWithBytes:AllDataLengthbyte length:2];
    [bytesData appendData:AllDataLengthDa11];// 分包的个数数据长度 2
    allLength += 2;

    
    Byte *dataNumbbyte= [BluetoolsHelp toByteIntNumb:dataNum];
    NSData *dataNumbDa11 = [[NSData alloc]initWithBytes:dataNumbbyte length:2];
    [bytesData appendData:dataNumbDa11];// 当前传输的包编号 2
    allLength += 2;
    
    
    [bytesData appendData:upData];// 当前传输的包数据
    allLength += upData.length;
    
    
    Byte *sendDataByte = (Byte *)[bytesData bytes];
    NSData *sendData = [BluetoolsHelp wifiSendDataProtocol:self.devType Cmd:@"0x26" DataLenght:allLength Payload:sendDataByte Mask:nil Useless:nil];
    if (sendData && self.writeChatacteristic) {
        self.AllGetData = [[NSMutableData alloc]init];
        self.SendData1 = sendData;

        [self.cbperipheral writeValue:sendData forCharacteristic:self.writeChatacteristic type:CBCharacteristicWriteWithoutResponse];//CBCharacteristicWriteWithResponse

    }
    
}

- (void)sendDataSet:(NSData *)sendData response:(CBCharacteristicWriteType)Response{
    
    _CmdData = sendData;
    _responType = Response;
//    if (!_isConnectSuccess) {
//
//        if (_reSendTimer) {
//            [_reSendTimer invalidate];
//            _reSendTimer = nil;
//        }
////        [self connectToPeripheral:self.cbperipheral];
//        _resendNumb = 0;
//
//        _reSendTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(resendDataSet) userInfo:nil repeats:YES];
//
//    }else{
//        _resendNumb = 0;

        [self.cbperipheral writeValue:sendData forCharacteristic:self.writeChatacteristic type:Response];
        
//    }
}
- (void)resendDataSet{
    
    _resendNumb++;
    if (_resendNumb > 4) {
        [_reSendTimer invalidate];
        _reSendTimer = nil;
    }else{
        if (_isConnectSuccess) {
            [_reSendTimer invalidate];
            _reSendTimer = nil;
            _resendNumb = 0;
            [self.cbperipheral writeValue:_CmdData forCharacteristic:self.writeChatacteristic type:_responType];

        }
        
    }
    
}
#pragma mark -- 收到的socket数据进行解析
- (void)analysis:(NSData *)NotifiData{
    
    if (!NotifiData || NotifiData == nil || NotifiData == NULL) return;

    [self.AllGetData appendData:NotifiData];
    
    NSData *headData = [self safe_subData:self.AllGetData withRange:NSMakeRange(0, 2)];// 判断指令头
    if (headData == nil) return;
    NSString *Alllengthstr = [BluetoolsHelp convertDataToHexStr:headData];
    NSNumber *ALlLengthNumb = [BluetoolsHelp numberHexString:Alllengthstr];
    int AllDataLen = [ALlLengthNumb intValue];//总数据长度，可能会分包，需要重新组合
    if (AllDataLen != self.AllGetData.length-2) {//总长度不包括指令头两位
        return;
    }
    NSData *getdata00 = self.AllGetData;
    if (self.AllGetData.length > 0) {
        self.AllGetData = nil;
    }
    self.AllGetData = [[NSMutableData alloc]init];
    
//    int head1 = ((Byte *)[headData bytes])[0];
//    int head2 = ((Byte *)[headData bytes])[1];
//    if (head1 != 0x00 || head2 != 0x01) {
//
//
////            [self.delegate errorMassageShowAl:headError];
//
//        return;
//    }
  
    //校验CRC
    NSData *data1 = [self safe_subData:getdata00 withRange:NSMakeRange(0, getdata00.length - 2)];
    NSData *crcData = [BluetoolsHelp changCRC16:data1];
    NSData *backDataCRC = [self safe_subData:getdata00 withRange:NSMakeRange(getdata00.length - 2, 2)];
    
    if (![crcData isEqualToData:backDataCRC]) {
        
        NSLog(@"校验失败");
        if ([self.delegate respondsToSelector:@selector(TCPSocketActionSuccess: CMD: devtype:)]) {
            [self.delegate TCPSocketActionSuccess:NO CMD:0 devtype:_devType];
        }
        return;
    }
    NSMutableData *normalData = [NSMutableData dataWithData:[self safe_subData:getdata00 withRange:NSMakeRange(0, 8)]];
    NSData *AESData = [self safe_subData:getdata00 withRange:NSMakeRange(8, getdata00.length-8-2)];
    AESData = [BluetoolsHelp aci_decryptWithAESData:AESData];//AES解密
    [normalData appendData:AESData];
    
    NSData *LengthData = [self safe_subData:normalData withRange:NSMakeRange(4, 2)];// 截取有效数据长度
    if (LengthData == nil) return;
    NSString *lengthstr = [BluetoolsHelp convertDataToHexStr:LengthData];
    NSNumber *valueAllLength = [BluetoolsHelp numberHexString:lengthstr];
    
    int lengt33 = [valueAllLength intValue];
    NSMutableData *allValueData = [[NSMutableData alloc]initWithData:[self safe_subData:normalData withRange:NSMakeRange(0, 6+lengt33)]];

    [allValueData appendData:crcData];
    NSData *analysisData = [self safe_subData:allValueData withRange:NSMakeRange(8,allValueData.length-8)];
    if (analysisData == nil) return;
//    Byte *MaskEncryption = (Byte*)[analysisData bytes];
//    NSData *anlyData = [BluetoolsHelp MaskEncryption:MaskEncryption length:(int)analysisData.length];//
//    NSLog(@"解码的数据:%@",anlyData);
    NSData *CmdData = [self safe_subData:allValueData withRange:NSMakeRange(7, 1)];// 消息类型
    NSString *Cmdstr = [BluetoolsHelp convertDataToHexStr:CmdData];
    int cmd = [Cmdstr intValue];//((Byte *)[CmdData bytes])[0];
    [self RestoreData:analysisData andCmd:cmd];
    
}

// data-有效数据
- (void)RestoreData:(NSData *)data andCmd:(int)cmd{
    
    if (cmd == 18 || cmd == 19) {
        NSData *statusData = [self safe_subData:data withRange:NSMakeRange(12,1)];//状态码
        if (statusData == nil) return;

        int status = ((Byte *)[statusData bytes])[0];

        if (status == 0x00) {// 状态成功
            
            if (cmd == 18) {
                if ([self.delegate respondsToSelector:@selector(TCPSocketActionSuccess: CMD: devtype:)]) {
                    [self.delegate TCPSocketActionSuccess:YES CMD:cmd devtype:_devType];
                }
            }else{
                if ([_devType isEqualToString:@"WIFILIST"]) {//wifi列表获取整体数据格式：总路由器个数（1 byte）+第1个路由字符长度（1 byte）+第1个路由字符（不定 byte）+第1个路由信号值（1 byte） … +第n个路由字符长度（1 byte）+第n个路由字符（不定 byte）+第n个路由信号值（1 byte）
                    NSData *NeedData = [self safe_subData:data withRange:NSMakeRange(13,data.length-13 - 2)];//减两位CRC校验码
                    self.MassageDic = [[NSMutableDictionary alloc]init];

                    NSData *oneData = [self safe_subData:NeedData withRange:NSMakeRange(0,2)];//编号
                    if (oneData == nil) return;
                    NSString *bianhaostr = [BluetoolsHelp convertDataToHexStr:oneData];
                    NSNumber *bianhao = [BluetoolsHelp numberHexString:bianhaostr];
                    if (oneData == nil) return;
                    NSLog(@"编号:%@",bianhao);
                    NSData *wifilistData = [self safe_subData:NeedData withRange:NSMakeRange(5, NeedData.length - 5)];
                    if (wifilistData == nil) return;

                    NSMutableArray *wifinameArr = [[NSMutableArray alloc]init];
                    if ([bianhao intValue] == 75) {
                        self.MassageDic = [[NSMutableDictionary alloc]init];
                        int length = 0;
                        while (wifilistData.length - length) {
                             //第1个路由字符长度（1 byte）+第1个路由字符（不定 byte）+第1个路由信号值（1 byte）
                            NSData *onewifilength = [self safe_subData:wifilistData withRange:NSMakeRange(length,1)];
                            if (onewifilength == nil) break;
                            NSString *lengthstr = [BluetoolsHelp convertDataToHexStr:onewifilength];
                            NSNumber *wifilength = [BluetoolsHelp numberHexString:lengthstr];
                            length += 1;//长度
                          
                            NSString *wifiName = [self getNSStringWithData:wifilistData Range:NSMakeRange(length,[wifilength intValue])];
                            if (wifiName == nil) break;

                            length += [wifilength intValue];//wifi长度
                            length += 1;//信号长度
                            [wifinameArr addObject:wifiName];
                            
                        }
                        [self.MassageDic setObject:_devType forKey:@"devType"];
                        [self.MassageDic setObject:wifinameArr forKey:@"75"];
                        [self.MassageDic setObject:[NSString stringWithFormat:@"%d",cmd] forKey:@"cmd"];

                        if ([self.delegate respondsToSelector:@selector(TCPSocketReadData:)]) {
                            [self.delegate TCPSocketReadData:self.MassageDic];
                        }
                    }
                    
                    
                }else{
                    NSData *NeedData = [self safe_subData:data withRange:NSMakeRange(13,data.length-13 - 2)];//减两位CRC校验码
                    
                    self.MassageDic = [[NSMutableDictionary alloc]init];

                    int length = 0;
                    while (NeedData.length - length) {
                        NSData *oneData = [self safe_subData:NeedData withRange:NSMakeRange(length,2)];//编号
                        if (oneData == nil) break;

                        NSString *bianhaostr = [BluetoolsHelp convertDataToHexStr:oneData];
                        NSNumber *bianhao = [BluetoolsHelp numberHexString:bianhaostr];
            //            NSString *bianhao = [self getNSStringWithData:NeedData Range:NSMakeRange(length,2)];
                        if (oneData == nil) break;
                        NSLog(@"编号:%@",bianhao);

                        length += 2;
                        NSData *oneDataLength = [self safe_subData:NeedData withRange:NSMakeRange(length,2)];
                        if (oneDataLength == nil) return;

                        length += 2;
                        NSString *dastr = [BluetoolsHelp convertDataToHexStr:oneDataLength];
                        NSNumber *numb = [BluetoolsHelp numberHexString:dastr];
                        int dataLeng = [numb intValue];
                        
                        NSString *lan = [self getNSStringWithData:NeedData Range:NSMakeRange(length,dataLeng)];
                        NSLog(@"数据:%@",lan);
                        
                        if (kStringIsEmpty(lan)) lan = @"0";

            //            NSData *needStrdata = [BluetoolsHelp dataWithString:lan];
            //            NSString *strr = [[NSString alloc]initWithData:needStrdata encoding:NSUTF8StringEncoding];
                        [self.MassageDic setObject:lan forKey:[NSString stringWithFormat:@"%@",bianhao]];
                        NSLog(@"截取保存的数据:%@:%@",bianhao,lan);
                        length += dataLeng;
                        NSLog(@"截取数据长度:%d",length);

                    }
                    [self.MassageDic setObject:[NSString stringWithFormat:@"%d",cmd] forKey:@"cmd"];
                    [self.MassageDic setObject:_devType forKey:@"devType"];

                    if ([self.delegate respondsToSelector:@selector(TCPSocketReadData:)]) {
                        [self.delegate TCPSocketReadData:self.MassageDic];
                    }
                }
                
            }
            
            
            
            
            

        }else if (status == 0x01){// 设置数据不合法
            
            if ([self.delegate respondsToSelector:@selector(TCPSocketActionSuccess: CMD: devtype:)]) {
                [self.delegate TCPSocketActionSuccess:NO CMD:cmd devtype:_devType];
            }
            NSLog(@"设置数据不合法");
        }
    }
    if (cmd == 26) {
        NSData *statusData = [self safe_subData:data withRange:NSMakeRange(10,2)];
        if (statusData == nil) return;
        NSString *AllNumbstr = [BluetoolsHelp convertDataToHexStr:statusData];
        NSNumber *AllNumb = [BluetoolsHelp numberHexString:AllNumbstr];

        int AllNumb1 = [AllNumb intValue];
        NSLog(@"数据总数量包:%d",AllNumb1);

        NSData *nowDataNumb = [self safe_subData:data withRange:NSMakeRange(12,2)];
        if (nowDataNumb == nil) return;
        NSString *nowNumbstr = [BluetoolsHelp convertDataToHexStr:nowDataNumb];
        NSNumber *nowNum = [BluetoolsHelp numberHexString:nowNumbstr];

        int nowNum1 = [nowNum intValue];
        NSLog(@"当前数据包:%d",nowNum1);

        NSData *nowDataStatus = [self safe_subData:data withRange:NSMakeRange(14,1)];
        if (nowDataStatus == nil) return;
        int DataStatus = ((Byte *)[nowDataStatus bytes])[0];
        
        if ([self.delegate respondsToSelector:@selector(TCPSocketUpDataReadDataStatus: AllNumb:  nowData:)]) {

            [self.delegate TCPSocketUpDataReadDataStatus:DataStatus AllNumb:AllNumb1 nowData:nowNum1];
        }

//        if (DataStatus == 0) {//成功
//
//        }else if(DataStatus == 1){//接收异常
//
//
//        }else if(DataStatus == 2){//整体检验错误,重新发送文件第一包
//
//
//        }else{//其他错误（采集器准备失败,重新发送文件第一包
//
//
//        }

    }
    
    
}

// 截取data 装换成 NSString
- (NSString *)getNSStringWithData:(NSData *)data Range:(NSRange)range{
    NSData *strData = [self dataDeleteString:[self safe_subData:data withRange:range]];
    NSString *string = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    return string;
}

- (NSNumber *)getNSNumberWithData:(NSData *)data Range:(NSRange)range{
    NSData *strData = [self dataDeleteString:[self safe_subData:data withRange:range]];
    int num = ((Byte *)[strData bytes])[0];
    return @(num);
}



// 把多余的00去掉
-(NSData *)dataDeleteString:(NSData *)data
{
    NSMutableData *newData = [[NSMutableData alloc]initWithData:data];
    NSData *charData = [self safe_subData:newData withRange:NSMakeRange(newData.length-1, 1)];
    while ([charData isEqualToData:[NSData dataWithBytes:[@"" UTF8String] length:1]]) { // 判断截取位是否为00,是就继续截取下去
        if (newData.length == 0 || newData == nil) { // newData.length == 1
            break; // data已经全部截取，跳出循环
            return [NSData data]; //[NSData dataWithBytes:[@"" UTF8String] length:1];
        }
        newData = [[NSMutableData alloc]initWithData:[self safe_subData:newData withRange:NSMakeRange(0, newData.length-1)]];//减一位
        charData = [self safe_subData:newData withRange:NSMakeRange(newData.length-1, 1)]; //从尾部开始截取,用作判断
    }
    
    return newData;
}

// 判读截取长度是否超出范围
- (NSData *)safe_subData:(NSData *)data withRange:(NSRange)range{
//    if (data.length != 0 && data.length >= (range.location+range.length)) {
//        return [data subdataWithRange:range];
//    } else {
//        NSLog(@"超出data截取长度");
//    }
    int datalen = (int)data.length;
    int localINT = (int)range.location;
    int rangleng = (int)range.length;
    if (localINT < 0 || rangleng < 0) {
        return nil;
    }
    
    if ((datalen != 0) && (datalen >= localINT)) {
        if ((rangleng > 0) && (datalen >= (localINT+rangleng))) {
            return [data subdataWithRange:range];

        }
    } else {
        NSLog(@"超出data截取长度");
    }
    
    
    return nil; //[NSData data];//[NSData dataWithBytes:[@"" UTF8String] length:1];
}


@end
