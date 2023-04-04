//
//  InveterInfoModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/28.
//

#import "InveterInfoModel.h"

@implementation InveterInfoModel


#pragma mark -第一页Model
-(NSMutableArray *)inveterSectionOneArray {
    if (!_inveterSectionOneArray) {
        _inveterSectionOneArray = [NSMutableArray arrayWithObjects:@"Device Info",@"Inverter Info", nil];
    }
    return _inveterSectionOneArray;
}

-(NSMutableArray<NSArray *> *)inveterKeyOneArray {
    if (!_inveterKeyOneArray) {
        NSArray *deviceInfo = @[@"Device SN",@"Work Mode",@"ARM Software Version",@"DSP Software Version",@"Data Update Time"];
        NSArray *inverterInfo = @[@"A-Phase Inv Voltage",@"B-Phase Inv Voltage",@"C-Phase Inv Voltage",@"A-Phase Inv Current",@"B-Phase Inv Current",@"C-Phase Inv Current",@"A-Phase Inv Power",@"B-Phase Inv Power",@"C-Phase Inv Power",@"A-Phase Inv Frequency",@"B-Phase Inv Frequency",@"C-Phase Inv Frequency"];
        _inveterKeyOneArray = [NSMutableArray arrayWithObjects:deviceInfo,inverterInfo, nil];
    }
    return _inveterKeyOneArray;
}

-(NSMutableArray<NSArray *> *)inveterUnitOneArray {
    // 0:无单位 1:伏特 V  2:安 A 3:千瓦 kW 4:赫兹 HZ 5:% 6:摄氏度 C° 7:版本号 前面加V
    if (!_inveterUnitOneArray) {
        NSArray *deviceInfo = @[@"0",@"0",@"0",@"0",@"0"];
        NSArray *inverterInfo = @[@"1",@"1",@"1",@"2",@"2",@"2",@"3",@"3",@"3",@"4",@"4",@"4"];
        _inveterUnitOneArray = [NSMutableArray arrayWithObjects:deviceInfo,inverterInfo, nil];
    }
    return _inveterUnitOneArray;
}

-(NSMutableArray<NSArray *> *)inveterValueOneArray {
    if(!_inveterValueOneArray) {
        _inveterValueOneArray = [NSMutableArray array];
    }
    return _inveterValueOneArray;
}

-(void)addInveterSectionOneArray {
    [self.inveterValueOneArray removeAllObjects];

    NSArray *deviceInfo = @[self.dataModel.basicInfo.deviceSn,self.dataModel.basicInfo.workMode,self.dataModel.basicInfo.armInnerVer,self.dataModel.basicInfo.dspInnerVer,self.dataModel.basicInfo.lastUpdateTime];
    NSArray *pcsInfo = @[self.dataModel.inverterInfo.invAVoltage,self.dataModel.inverterInfo.invBVoltage,self.dataModel.inverterInfo.invCVoltage,self.dataModel.inverterInfo.invACurrent,
                         self.dataModel.inverterInfo.invBCurrent,self.dataModel.inverterInfo.invCCurrent,self.dataModel.inverterInfo.invAPower,self.dataModel.inverterInfo.invBPower,
                         self.dataModel.inverterInfo.invCPower,self.dataModel.inverterInfo.invAFreq,self.dataModel.inverterInfo.invBFreq,self.dataModel.inverterInfo.invCFreq];
    [self.inveterValueOneArray addObject:deviceInfo];
    [self.inveterValueOneArray addObject:pcsInfo];
}

#pragma mark - 第二页Model
-(NSMutableArray *)inveterSectionTwoArray {
    if (!_inveterSectionTwoArray) {
        _inveterSectionTwoArray = [NSMutableArray arrayWithObjects:@"PV Info",@"Grid Info", nil];
    }
    return _inveterSectionTwoArray;
}

-(NSMutableArray<NSArray *> *)inveterKeyTwoArray {
    if (!_inveterKeyTwoArray) {
        NSArray *PVInfo = @[@"PV1 Voltage",@"PV2 Voltage",@"PV3 Voltage",@"PV4 Voltage",@"PV1 Current",@"PV2 Current",@"PV3 Current",@"PV4 Current",@"PV1 Power",@"PV2 Power",@"PV3 Power",@"PV4 Power"];
        NSArray *gridInfo = @[@"A-Phase Grid Voltage",@"B-Phase Grid Voltage",@"C-Phase Grid Voltage",@"A-Phase Grid Current",@"B-Phase Grid Current",@"C-Phase Grid Current",@"A-Phase Grid Power",@"B-Phase Grid Power",@"C-Phase Grid Power",@"Grid Frequency"];
        _inveterKeyTwoArray = [NSMutableArray arrayWithObjects:PVInfo,gridInfo, nil];
    }
    return _inveterKeyTwoArray;
}

-(NSMutableArray<NSArray *> *)inveterUnitTwoArray {
    // 0:无单位 1:伏特 V  2:安 A 3:千瓦 kW 4:赫兹 HZ 5:% 6:摄氏度 C° 7:版本号 前面加V
    if (!_inveterUnitTwoArray) {
        NSArray *pvInfo = @[@"1",@"1",@"1",@"1",@"2",@"2",@"2",@"2",@"3",@"3",@"3",@"3",@"4",@"4",@"4",@"4",];
        NSArray *gridInfo = @[@"1",@"1",@"1",@"2",@"2",@"2",@"3",@"3",@"3",@"4"];
        _inveterUnitTwoArray = [NSMutableArray arrayWithObjects:pvInfo,gridInfo, nil];
    }
    return _inveterUnitTwoArray;
}

-(NSMutableArray<NSArray *> *)inveterValueTwoArray {
    if(!_inveterValueTwoArray) {
       
        _inveterValueTwoArray = [NSMutableArray array];
    }
    return _inveterValueTwoArray;
}

-(void)addInveterSectionTwoArray {
    [self.inveterValueTwoArray removeAllObjects];

    NSArray *PVInfo = @[self.dataModel.pvInfo.pv1Voltage,self.dataModel.pvInfo.pv2Voltage,self.dataModel.pvInfo.pv3Voltage,self.dataModel.pvInfo.pv4Voltage,self.dataModel.pvInfo.pv1Current,self.dataModel.pvInfo.pv2Current,self.dataModel.pvInfo.pv3Current,self.dataModel.pvInfo.pv4Current,self.dataModel.pvInfo.pv1Power,self.dataModel.pvInfo.pv2Power,self.dataModel.pvInfo.pv3Power,self.dataModel.pvInfo.pv4Power];
    NSArray *gridInfo = @[self.dataModel.gridInfo.gridAVoltage,self.dataModel.gridInfo.gridBVoltage,self.dataModel.gridInfo.gridCVoltage,self.dataModel.gridInfo.gridACurrent,self.dataModel.gridInfo.gridBCurrent,self.dataModel.gridInfo.gridCCurrent,self.dataModel.gridInfo.gridAPower,self.dataModel.gridInfo.gridBPower,self.dataModel.gridInfo.gridCPower,self.dataModel.gridInfo.gridFreq];
    [self.inveterValueTwoArray addObject:PVInfo];
    [self.inveterValueTwoArray addObject:gridInfo];
}


#pragma mark - 第三页Model
-(NSMutableArray *)inveterSectionThreeArray {
    if (!_inveterSectionThreeArray) {
        _inveterSectionThreeArray = [NSMutableArray arrayWithObjects:@"Load Info",@"Battery Info", nil];
    }
    return _inveterSectionThreeArray;
}

-(NSMutableArray<NSArray *> *)inveterKeyThreeArray {
    if (!_inveterKeyThreeArray) {
        NSArray *loadInfo = @[@"A-Phase Load Voltage",@"B-Phase Load Voltage",@"C-Phase Load Voltage",@"A-Phase Load Current",@"B-Phase Load Current",@"C-Phase Load Current",@"A-Phase Load Power",@"B-Phase Load Power",@"C-Phase Load Power",@"A-Phase Load Rate",@"B-Phase Load Rate",@"C-Phase Load Rate"];
        NSArray *batteryInfo = @[@"SOC",@"Voltage",@"Current",@"Max Charge Current",@"Max DisCharge Current",@"Min Cell Voltage",@"Max Cell Voltage",@"Min Cell Temp",@"Max Cell Temp"];
     
        _inveterKeyThreeArray = [NSMutableArray arrayWithObjects:loadInfo,batteryInfo, nil];
    }
    return _inveterKeyThreeArray;
}

-(NSMutableArray<NSArray *> *)inveterUnitThreeArray {
    // 0:无单位 1:伏特 V  2:安 A 3:千瓦 kW 4:赫兹 HZ 5:% 6:摄氏度 C° 7:版本号 前面加V
    if (!_inveterUnitThreeArray) {
        NSArray *loadInfo = @[@"1",@"1",@"1",@"2",@"2",@"2",@"3",@"3",@"3",@"5",@"5",@"5"];
        NSArray *batteryInfo = @[@"5",@"1",@"2",@"2",@"2",@"1",@"1",@"6",@"6"];
        _inveterUnitThreeArray = [NSMutableArray arrayWithObjects:loadInfo,batteryInfo, nil];
    }
    return _inveterUnitThreeArray;
}


-(NSMutableArray<NSArray *> *)inveterValueThreeArray {
    if(!_inveterValueThreeArray) {
        _inveterValueThreeArray = [NSMutableArray array];
    }
    return _inveterValueThreeArray;
}

-(void)addInveterSectionThreeArray {
    [self.inveterValueThreeArray removeAllObjects];
    NSArray *loadInfo = @[self.dataModel.loadInfo.loadAVoltage,self.dataModel.loadInfo.loadBVoltage,self.dataModel.loadInfo.loadCVoltage,self.dataModel.loadInfo.loadACurrent,self.dataModel.loadInfo.loadBCurrent,self.dataModel.loadInfo.loadCCurrent,self.dataModel.loadInfo.loadAPower,self.dataModel.loadInfo.loadBPower,self.dataModel.loadInfo.loadCPower,self.dataModel.loadInfo.loadARate,self.dataModel.loadInfo.loadBRate,self.dataModel.loadInfo.loadCRate];
    NSArray *batterInfo = @[self.dataModel.batteryInfo.batSoc,self.dataModel.batteryInfo.batVoltage,self.dataModel.batteryInfo.batCurrent,self.dataModel.batteryInfo.batChargeCurrentLimite,self.dataModel.batteryInfo.batDisChargeCurrentLimite,self.dataModel.batteryInfo.bmsBatCellMinVoltage,self.dataModel.batteryInfo.bmsBatCellMaxVoltage,self.dataModel.batteryInfo.bmsBatCellMinTemperature,self.dataModel.batteryInfo.bmsBatCellMaxTemperature];
    [self.inveterValueThreeArray addObject:loadInfo];
    [self.inveterValueThreeArray addObject:batterInfo];
}



@end
