//
//  SettingOptionModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import "SettingOptionModel.h"

@interface SettingOptionModel()



@end


@implementation SettingOptionModel

#pragma mark basic相关model

// basic setting标题数组
-(NSMutableArray<NSString *> *)basicSettingOptionSectionArray {
    if (!_basicSettingOptionSectionArray) {
        
        _basicSettingOptionSectionArray = [NSMutableArray arrayWithObjects:@"Work Mode",@"Sys Setting",@"Battery Setting",@"Grid Setting",@"Parallel Setting",@"Geneator Setting", nil];
    }
    return _basicSettingOptionSectionArray;
}

// basic setting选项数组
-(NSMutableArray<NSArray *> *)basicSettingOptionKeyArray {
    if (!_basicSettingOptionKeyArray) {
        
        NSArray *workingModeArray = @[@"Load Prioritized",@"Plan Mode",@"Bat Prioritized"];
       
        NSArray *sysSettingArray = @[@"Date",@"Time",@"EPS Enable",@"PV Input Type",@"ARC Enable",@"Anti Reflux",@"CT Ratio"];
        
        NSArray *batSettingArray = @[@"Bat Grid DOD",@"Off Grid DOD",@"Soc Threshold Hystet"];
        
        NSArray *gridSettingArray = @[@"Grid Standard",@"Grid Set",@"American Standard"];
        
        NSArray *parallelSettingArray = @[@"Inv Parallel Num",@"Parallel Master/Slave",@"Inv Parallel Addr",@"Common Battery Enable",
                                          @"Common GridCT Enable",@"3 Phase Enable",@"Parallel Charge Current",@"Parallel Discharge Current",@"In Parallel Enable"];
        
        NSArray *geneatorSettingArray = @[@"Generator Start Soc",@"Generator Stop Soc",@"Generator Charges Current",
                                          @"Maximum Operating Time",@"Generator Cooling Time",@"Generator Enable",@"Generator Charge Enable",@"Generator Auto Start",@"Generator Manual On",@"Generator Manual CMD",@"Generator Connect Grid",@"Generator Power"];

        _basicSettingOptionKeyArray = [NSMutableArray arrayWithObjects:workingModeArray,sysSettingArray,batSettingArray,gridSettingArray,parallelSettingArray,geneatorSettingArray, nil];
    }
    return _basicSettingOptionKeyArray;
}

// basic setting UI展示数组
-(NSMutableArray<NSArray *> *)basicSettingUIArray {
    // 0:保留按钮 1:保留文字和箭头 2:特殊符号
    if (!_basicSettingUIArray) {
        NSArray *workingModeArray = @[@"0",@"0",@"0"];
        NSArray *sysSettingArray = @[@"1",@"1",@"0",@"1",@"0",@"0",@"1"];
        NSArray *batSettingArray = @[@"1",@"1",@"1"];
        NSArray *gridSettingArray = @[@"1",@"1",@"1"];
        NSArray *parallelSettingArray = @[@"1",@"1",@"1",@"0",@"0",@"0",@"1",@"1",@"0"];
        NSArray *geneatorSettingArray = @[@"1",@"1",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"1"];
        _basicSettingUIArray = [NSMutableArray arrayWithObjects:workingModeArray,sysSettingArray,batSettingArray,gridSettingArray,parallelSettingArray,geneatorSettingArray, nil];
    }
    return _basicSettingUIArray;
}

// basic setting data数组
-(NSMutableArray<NSArray *> *)basicSettingOptionValueArray {
    if (!_basicSettingOptionValueArray) {
        _basicSettingOptionValueArray = [NSMutableArray array];
    }
    return _basicSettingOptionValueArray;
}

-(void)addBasicSettingDataArray {
    
    NSMutableArray *workingModeArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSInteger modeNum = [self.settingModel.workMode intValue];
        [workingModeArray addObject:modeNum == i ? @"1" : @"0"];
    }
    
    NSArray *sysSettingArray = @[self.settingModel.date,self.settingModel.time,self.settingModel.epsBackupEnable,self.settingModel.pvInputType,
                                                            self.settingModel.arcEnable,self.settingModel.antiReflux,self.settingModel.ctRatio];
    
    NSArray *batSettingArray = @[self.settingModel.batGridDod,self.settingModel.offGridDod,self.settingModel.batEodHyst];
    
    NSArray *gridSettingArray = @[self.settingModel.gridStandard,self.settingModel.gridSet,self.settingModel.usaStandardClass];
    
    NSArray *parallelSettingArray = @[self.settingModel.invParallelNum,self.settingModel.invParallelIdentity,[NSString stringWithFormat:@"%ld", (long)self.settingModel.InvParallelAddr],self.settingModel.commonBatteryEnable,self.settingModel.commonGridctEnable,
                                                                 self.settingModel.pHaseEnable,self.settingModel.parallelChargeCurrent,self.settingModel.parallelDischargeCurrent,self.settingModel.invParallelEnable];
    
    NSArray *geneatorSettingArray = @[self.settingModel.generatorStartSoc,self.settingModel.generatorStopSoc,
                                                                 self.settingModel.generatorChargesCurrent,self.settingModel.maximumOperatingTim,self.settingModel.generatorCoolingTime,self.settingModel.genEnable,self.settingModel.genChargeEnable,self.settingModel.genAutoStart,self.settingModel.genManualOn,self.settingModel.genManualCmd,self.settingModel.genConnectToGridInput,self.settingModel.generatorPower];
    
    NSArray *allArray = [NSArray arrayWithObjects:workingModeArray,sysSettingArray,batSettingArray,gridSettingArray,parallelSettingArray,geneatorSettingArray, nil];
    
    [self.basicSettingOptionValueArray removeAllObjects];
    [self.basicSettingOptionValueArray addObjectsFromArray:allArray];
        
}

- (NSMutableArray<NSArray *> *)basicSettingParamArray {
    if (!_basicSettingParamArray) {
        NSArray *workingModeArray = @[@"sysOperaPolicyMode",@"sysOperaPolicyMode",@"sysOperaPolicyMode"];
        NSArray *sysSettingArray = @[@"date",@"time",@"epsBackupEnable",@"pvInputType",
                                                                @"arcEnable",@"antiReflux",@"ctRatio"];
        NSArray *batSettingArray = @[@"batGridDod",@"offGridDod",@"batEodHyst"];

        NSArray *gridSettingArray = @[@"gridStandard",@"gridSet",@"USA_STANDARD_CLASS"];

        NSArray *parallelSettingArray = @[@"INV_PARALLEL_NUM",@"INV_PARALLEL_IDENTITY",@"INV_PARALLEL_ADDR",@"COMMON_BATTERY_ENABLE",@"COMMON_GRIDCT_ENABLE",
                                        @"P_HASE_ENABLE",@"PARALLEL_CHARGE_CURRENT",@"PARALLEL_DISCHARGE_CURRENT",@"INV_PARALLEL_ENABLE"];

        NSArray *geneatorSettingArray = @[@"GENERATOR_START_SOC",@"GENERATOR_STOP_SOC",@"GENERATOR_CHARGES_CURRENT",@"MAXIMUM_OPERATING_TIM",@"GENERATOR_COOLING_TIME",@"GEN_ENABLE"
                                          ,@"GEN_CHARGE_ENABLE",@"GEN_AUTO_START",@"GEN_MANUAL_ON",@"GEN_MANUAL_CMD",@"GEN_CONNECT_TO_GRID_INPUT",@"GENERATOR_POWER"];
        _basicSettingParamArray = [NSMutableArray arrayWithObjects:workingModeArray,sysSettingArray,batSettingArray,gridSettingArray,parallelSettingArray,geneatorSettingArray, nil];
    }
    return _basicSettingParamArray;
}

-(NSMutableArray<NSArray *> *)basicSettingSelectArray {
    if (!_basicSettingSelectArray) {
        // 0:无操作 1:跳转输入框（百分比） 2:跳转输入框 3:时间弹窗 4:选择界面
        NSArray *workingModeArray = @[@"0",@"0",@"0"];
        NSArray *sysSettingArray = @[@"3",@"3",@"0",@"4",@"0",@"0",@"1"];
        NSArray *batSettingArray = @[@"1",@"1",@"1"];
        NSArray *gridSettingArray = @[@"4",@"4",@"4"];
        NSArray *parallelSettingArray = @[@"2",@"4",@"2",@"0",@"0",@"4",@"1",@"1",@"0"];
        NSArray *geneatorSettingArray = @[@"1",@"1",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"1"];
        _basicSettingSelectArray = [NSMutableArray arrayWithObjects:workingModeArray,sysSettingArray,batSettingArray,gridSettingArray,parallelSettingArray,geneatorSettingArray, nil];
    }
    return _basicSettingSelectArray;
}


#pragma mark advanced相关model

// advanced setting标题数组
-(NSMutableArray<NSString *> *)advancedSettingOptionSectionArray {
    if (!_advancedSettingOptionSectionArray) {
        
        _advancedSettingOptionSectionArray = [NSMutableArray arrayWithObjects:@"Advanced Setting", nil];
    }
    return _advancedSettingOptionSectionArray;
}

// advanced setting选项数组
-(NSMutableArray<NSArray *> *)advancedSettingOptionKeyArray {
    if (!_advancedSettingOptionKeyArray) {
        
        NSArray *array = @[@"Grid Power",@"Bat Discharge Power",@"Bat Charge Current",@"PV Power",@"Modbus ID",@"Moodbus Baud",@"Restore Factory Setting",@"Remote StartUp/ShutDown"];
        
        _advancedSettingOptionKeyArray = [NSMutableArray arrayWithObjects:array, nil];
    }
    return _advancedSettingOptionKeyArray;
}

// advanced data选项数组
-(NSMutableArray<NSArray *> *)advancedSettingOptionValueArray {
    if (!_advancedSettingOptionValueArray) {
        _advancedSettingOptionValueArray = [NSMutableArray array];
    }
    return _advancedSettingOptionValueArray;
}


// basic setting UI展示数组
-(NSMutableArray<NSArray *> *)advancedSettingUIArray {
    // 0:保留按钮 1:保留文字和箭头 2:特殊符号 3:保留刷新按钮 4:保留开关机按钮
    if (!_advancedSettingUIArray) {
        NSArray *array = @[@"1",@"1",@"1",@"1",@"1",@"1",@"3",@"4"];
        _advancedSettingUIArray = [NSMutableArray arrayWithObject:array];
    }
    return _advancedSettingUIArray;
}

-(NSMutableArray<NSArray *> *)advancedSettingSelectArray {
    if (!_advancedSettingSelectArray) {
        // 0:无操作 1:跳转输入框（百分比） 2:跳转输入框（单位） 3:时间弹窗 4:选择国家 
        NSArray *array = @[@"1",@"1",@"1",@"1",@"1",@"4",@"0",@"0"];
        _advancedSettingSelectArray = [NSMutableArray arrayWithObjects:array, nil];
    }
    return _advancedSettingSelectArray;
}

-(NSMutableArray<NSArray *> *)advancedSettingParamArray {
    if (!_advancedSettingParamArray) {
        NSArray *array = @[@"gridPower",@"batDischargePower",@"batChargeCurrent",
                           @"pvPower",@"modbusId",@"MOODBUS_BAUD",@"RESTORE_FACTORY_SETTING",@"SWITCH_MACHINE"];
        _advancedSettingParamArray = [NSMutableArray arrayWithObjects:array, nil];
    }
    return _advancedSettingParamArray;
}

-(void)addAdvancedSettingDataArray {
    NSArray *array = @[self.settingModel.gridPower,self.settingModel.batDischargePower,self.settingModel.batChargeCurrent,
                       self.settingModel.pvPower,self.settingModel.modbusID,self.settingModel.modbusBaud,self.settingModel.restoreFactorySetting,self.settingModel.switchMachine];
    [self.advancedSettingOptionValueArray removeAllObjects];
    [self.advancedSettingOptionValueArray addObject:array];
}


#pragma mark 弹框GridStandard 相关model
-(NSMutableArray *)gridStandardsValueArray {
    if (!_gridStandardsValueArray) {
        _gridStandardsValueArray = [NSMutableArray arrayWithObjects:@"AU",@"AU-W",@"NZ",@"UK",@"PK",@"KR",@"PHI",@"CN",@"US",@"THAIL",@"ZA",@"Custom",@"POL",@"EN50549",@"VDE4105",@"JPN",@"ITA",@"SLO",@"CZE",@"SWE",@"HU",@"SK", nil];
    }
    return _gridStandardsValueArray;
}

-(NSMutableArray *)gridStandardsKeyArray {
    if (!_gridStandardsKeyArray) {
        _gridStandardsKeyArray = [NSMutableArray arrayWithObjects:@"Australia",@"Australasia west",@"New Zealand",@"Britain",@"Pakistan",@"South Korea",@"Philippines",@"China",@"United States",@"Thailand",@"South Africa",@"Customer customizati",@"Poland",@"EN50549",@"VDE4105",@"Japan",@"Italy",@"Slovenia",@"Czech Republic",@"Sweden",@"Hungary",@"Slovakia", nil];
    }
    return _gridStandardsKeyArray;
}

-(NSMutableArray *)usaStandardClassArray {
    if (!_usaStandardClassArray) {
        _usaStandardClassArray = [NSMutableArray arrayWithObjects:@"UL1741&IEEE1547.2020",@"Rule21",@"SRD-UL1741 1.0",@"UL1741 SB",@"UL1741 SA",@"Heco 2.0", nil];
    }
    return _usaStandardClassArray;
}

-(NSMutableArray *)gridSetArray {
    if (!_gridSetArray) {
        _gridSetArray = [NSMutableArray arrayWithObjects:@"220V",@"120V/240V",@"120V/208V",@"120V", nil];
    }
    return _gridSetArray;
}

-(NSMutableArray *)inputTypeArray {
    if (!_inputTypeArray) {
        _inputTypeArray = [NSMutableArray arrayWithObjects:@"Independant",@"Parallel",@"CV", nil];
    }
    return _inputTypeArray;
}

-(NSMutableArray *)parallelArray {
    if (!_parallelArray) {
        _parallelArray = [NSMutableArray arrayWithObjects:@"Master",@"Slave", nil];
    }
    return _parallelArray;
}

-(NSMutableArray *)phaseEnableArray {
    if (!_phaseEnableArray) {
        _phaseEnableArray = [NSMutableArray arrayWithObjects:@"A",@"B",@"C", nil];
    }
    return _phaseEnableArray;
}

-(NSMutableArray *)modbusArray {
    if (!_modbusArray) {
        _modbusArray = [NSMutableArray arrayWithObjects:@"9600",@"19200", nil];
    }
    return _modbusArray;
}

@end
