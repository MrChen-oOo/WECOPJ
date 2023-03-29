//
//  CabinetInfoModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "CabinetInfoModel.h"

@implementation CabinetInfoModel

#pragma mark -第一页Model
-(NSMutableArray *)cabinetSectionOneArray {
    if (!_cabinetSectionOneArray) {
        _cabinetSectionOneArray = [NSMutableArray arrayWithObjects:@"Device Info",@"PCS Info", nil];
    }
    return _cabinetSectionOneArray;
}

-(NSMutableArray<NSArray *> *)cabinetKeyOneArray {
    if (!_cabinetKeyOneArray) {
        NSArray *deviceInfo = @[@"Device SN",@"Work mode",@"Software Version",@"Firmware Version",@"Data Update Time"];
        NSArray *pcsInfo = @[@"Mode",@"Status",@"AC A-Phase Voltage",@"AC B-Phase Voltage",@"AC C-Phase Voltage",@"AC A-Phase Current",@"AC B-Phase Current",@"AC C-Phase Current",@"AC Active Power",@"AC Reactive Power",@"AC Frequency",@"DC Port Voltage",@"DC Port Current",@"DC Port Power"];
        _cabinetKeyOneArray = [NSMutableArray arrayWithObjects:deviceInfo,pcsInfo, nil];
    }
    return _cabinetKeyOneArray;
}

-(NSMutableArray<NSArray *> *)cabinetValueOneArray {
    if(!_cabinetValueOneArray) {
        _cabinetValueOneArray = [NSMutableArray array];
    }
    return _cabinetValueOneArray;
}

-(void)addICabinetSectionOneArrayWithIndex:(NSInteger)index {
    [self.cabinetValueOneArray removeAllObjects];
    NSArray *deviceInfoArray = @[self.cabinetModel.basicInfo.deviceSn,self.cabinetModel.basicInfo.sysOperaPolicyMode,self.cabinetModel.basicInfo.softWareVer,self.cabinetModel.basicInfo.hardWareVer,self.cabinetModel.basicInfo.lastUpdateTime];
    NSArray *pcsInfoArray = @[self.cabinetModel.acModelList[index].workingMode,self.cabinetModel.acModelList[index].runtimeStatus,self.cabinetModel.acModelList[index].acACAV,self.cabinetModel.acModelList[index].acACBV,self.cabinetModel.acModelList[index].acACCV,self.cabinetModel.acModelList[index].acACAA,self.cabinetModel.acModelList[index].acACBA,self.cabinetModel.acModelList[index].acACCA,self.cabinetModel.acModelList[index].acACActivePower,self.cabinetModel.acModelList[index].acACReactivePower,self.cabinetModel.acModelList[index].acACFrequency,self.cabinetModel.acModelList[index].acDCPortV,self.cabinetModel.acModelList[index].acDCPortA,self.cabinetModel.acModelList[index].acDCPortPower];
    [self.cabinetValueOneArray addObject:deviceInfoArray];
    [self.cabinetValueOneArray addObject:pcsInfoArray];
}

-(NSMutableArray<NSArray *> *)cabinetUnitOneArray {
    // 0:无单位 1:伏特 V  2:安 A 3:千瓦 kW 4:赫兹 HZ 5:% 6:摄氏度 C° 7:版本号 前面加V

    if(!_cabinetUnitOneArray) {
        NSArray *deviceInfoArray = @[@"0",@"0",@"7",@"7",@"0"];
        NSArray *pcsInfoArray = @[@"1",@"1",@"1",@"2",@"2",@"2",@"3",@"3",@"5",@"1",@"1",@"3"];
        _cabinetUnitOneArray = [NSMutableArray arrayWithObjects:deviceInfoArray,pcsInfoArray,nil];
    }
    return _cabinetUnitOneArray;
}

#pragma mark - 第二页Model
-(NSMutableArray *)cabinetSectionTwoArray {
    if (!_cabinetSectionTwoArray) {
        _cabinetSectionTwoArray = [NSMutableArray arrayWithObjects:@"PV Info",@"Grid Info", nil];
    }
    return _cabinetSectionTwoArray;
}

-(NSMutableArray<NSArray *> *)cabinetKeyTwoArray {
    if (!_cabinetKeyTwoArray) {
        NSArray *pvInfo = @[@"Status",@"High Side Voltage",@"High Side Current",@"High Side Power",@"Low Side Voltage",@"Low Side Current",@"Low Side Power"];
        NSArray *gridInfo = @[@"A-Phase Voltage",@"B-Phase Voltage",@"C-Phase Voltage",@"A-Phase Current",@"B-Phase Current",@"C-Phase Current",@"Active Power",@"Reactive Power",@"Frequency"];
        _cabinetKeyTwoArray = [NSMutableArray arrayWithObjects:pvInfo,gridInfo, nil];
    }
    return _cabinetKeyTwoArray;
}

-(NSMutableArray<NSArray *> *)cabinetValueTwoArray {
    if(!_cabinetValueTwoArray) {
        _cabinetValueTwoArray = [NSMutableArray array];
    }
    return _cabinetValueTwoArray;
}

-(void)addICabinetSectionTwoArrayWithIndex:(NSInteger)index{
    [self.cabinetValueTwoArray removeAllObjects];
    NSArray *pvInfo = @[self.cabinetModel.mpptList[index].mpptRuntimeStatus,self.cabinetModel.mpptList[index].mpptHighSideV,self.cabinetModel.mpptList[index].mpptLowSideA,self.cabinetModel.mpptList[index].mpptLowSideP,self.cabinetModel.mpptList[index].mpptLowSideV,self.cabinetModel.mpptList[index].mpptLowSideA,self.cabinetModel.mpptList[index].mpptLowSideP];
    NSArray *gridInfo = @[self.cabinetModel.gridInfo.gridSideMeteVoltageUA,self.cabinetModel.gridInfo.gridSideMeteVoltageUB,self.cabinetModel.gridInfo.gridSideMeteVoltageUC,self.cabinetModel.gridInfo.gridSideMeterACurrent,self.cabinetModel.gridInfo.gridSideMeterBCurrent,self.cabinetModel.gridInfo.gridSideMeterCCurrent,self.cabinetModel.gridInfo.gridSideMeterThreeActivePower,self.cabinetModel.gridInfo.gridSideMeterThreeReactivePower,self.cabinetModel.gridInfo.gridSideMeterFrequencyF];
    [self.cabinetValueTwoArray addObject:pvInfo];
    [self.cabinetValueTwoArray addObject:gridInfo];
}

-(NSMutableArray<NSArray *> *)cabinetUnitTwoArray {
    // 0:无单位 1:伏特 V  2:安 A 3:千瓦 kW 4:赫兹 HZ 5:% 6:摄氏度 C° 7:版本号 前面加V

    if (!_cabinetUnitTwoArray) {
        
        NSArray *pvInfo = @[@"0",@"1",@"2",@"3",@"1",@"2",@"3"];
        NSArray *gridInfo = @[@"1",@"1",@"1",@"2",@"2",@"2",@"3",@"3",@"1",@"4"];
        
        _cabinetUnitTwoArray = [NSMutableArray arrayWithObjects:pvInfo,gridInfo, nil];
    }
    return _cabinetUnitTwoArray;
}

#pragma mark - 第三页Model
-(NSMutableArray *)cabinetSectionThreeArray {
    if (!_cabinetSectionThreeArray) {
        _cabinetSectionThreeArray = [NSMutableArray arrayWithObjects:@"Battery Info", nil];
    }
    return _cabinetSectionThreeArray;
}

-(NSMutableArray<NSArray *> *)cabinetKeyThreeArray {
    if (!_cabinetKeyThreeArray) {
        NSArray *batteryInfo = @[@"Status",@"SOC",@"SOH",@"Voltage",@"Current",@"Max Charge Current",@"Max DisCharge Current",@"Min Cell Voltage",@"Max Cell Voltage",@"Min Cell Temp",@"Max Cell Temp"];
     
        _cabinetKeyThreeArray = [NSMutableArray arrayWithObjects:batteryInfo, nil];
    }
    return _cabinetKeyThreeArray;
}

-(NSMutableArray<NSArray *> *)cabinetValueThreeArray {
    if(!_cabinetValueThreeArray) {
        _cabinetValueThreeArray = [NSMutableArray array];
    }
    return _cabinetValueThreeArray;
}

-(void)addICabinetSectionThreeArray {
    [self.cabinetValueThreeArray removeAllObjects];
    NSArray *batteryInfo = @[self.cabinetModel.batteryInfo.batteryRunStatus,self.cabinetModel.batteryInfo.batterySOC,self.cabinetModel.batteryInfo.batterySOH,self.cabinetModel.batteryInfo.batteryV,self.cabinetModel.batteryInfo.batteryCurrent,self.cabinetModel.batteryInfo.batteryMaxRechargeCurrent,self.cabinetModel.batteryInfo.batteryMaxDischargeCurrent,self.cabinetModel.batteryInfo.batteryAHighV,self.cabinetModel.batteryInfo.batteryALowV,self.cabinetModel.batteryInfo.batteryMinTemperature,self.cabinetModel.batteryInfo.batteryMaxTemperature];
    [self.cabinetValueThreeArray addObject:batteryInfo];
}

-(NSMutableArray<NSArray *> *)cabinetUnitThreeArray {
    // 0:无单位 1:伏特 V  2:安 A 3:千瓦 kW 4:赫兹 HZ 5:% 6:摄氏度 C° 7:版本号 前面加V

    if (!_cabinetUnitThreeArray) {
        NSArray *batteryInfo = @[@"0",@"5",@"5",@"1",@"2",@"2",@"2",@"1",@"1",@"6",@"6"];
        _cabinetUnitThreeArray = [NSMutableArray arrayWithObjects:batteryInfo, nil];
    }
    return _cabinetUnitThreeArray;
}


@end
