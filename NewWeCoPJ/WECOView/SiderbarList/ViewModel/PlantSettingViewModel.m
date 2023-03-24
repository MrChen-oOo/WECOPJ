//
//  PlantSettingViewModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import "PlantSettingViewModel.h"
#import "MJExtension.h"

@implementation PlantSettingViewModel


// 获取计划时间数据
-(void)getInverterTimeSoltMsgWithCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/getInverterTimeSolt",HEAD_URL];

    NSDictionary *dic = @{@"deviceSn":self.deviceStr};
    [PlantSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.planModel = [PlanArrayModel mj_objectWithKeyValues:resultData];
            
            [self.batteryChargArray removeAllObjects];
            [self.batteryDisChargArray removeAllObjects];
            
            // 时间数据处理
            for (TimeModel *model in self.planModel.data) {
                if (model.charge == 0 && model.show == 1){
                    [self.batteryDisChargArray addObject:model];
                } else if (model.charge == 1 && model.show == 1){
                    [self.batteryChargArray addObject:model];
                }
            }
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}

// 设置计划时间数据
-(void)setUpPlantModelParamCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setUpPlantModel",HEAD_URL];

    NSMutableArray *chargeArray = [NSMutableArray array];
    NSMutableArray *disChargArray = [NSMutableArray array];

    NSInteger timeNum = self.deviceType == 1 ? 3 : 4;
    
    // 自动填充，必定要3个
    for (int i = 0; i < timeNum; i++) {
        if (i <= self.batteryChargArray.count - 1) {
            NSDictionary *dic = @{@"isCharge":@(self.batteryChargArray[i].charge),@"startHour":self.batteryChargArray[i].startHour,@"startMinute":self.batteryChargArray[i].startMinute,@"endHour":self.batteryChargArray[i].endHour,@"endMinute":self.batteryChargArray[i].endMinute,@"power":self.batteryChargArray[i].power,@"order":@(i)};
            [chargeArray addObject:dic];
        } else {
            NSDictionary *dic = @{@"isCharge":@(0),@"startHour":@"00",@"startMinute":@"00",@"endHour":@"00",@"endMinute":@"00",@"power":@"0",@"order":@(i)};
            [chargeArray addObject:dic];
        }
        
        
        if (i <= self.batteryDisChargArray.count - 1) {
            NSDictionary *dic = @{@"isCharge":@(self.batteryDisChargArray[i].charge),@"startHour":self.batteryDisChargArray[i].startHour,@"startMinute":self.batteryDisChargArray[i].startMinute,@"endHour":self.batteryDisChargArray[i].endHour,@"endMinute":self.batteryDisChargArray[i].endMinute,@"power":self.batteryDisChargArray[i].power,@"order":@(i)};
            [disChargArray addObject:dic];
        } else {
            NSDictionary *dic = @{@"isCharge":@(1),@"startHour":@"00",@"startMinute":@"00",@"endHour":@"00",@"endMinute":@"00",@"power":@"0",@"order":@(i)};
            [disChargArray addObject:dic];
        }
    }
    
    NSDictionary *param = @{@"charge":chargeArray,@"disCharge":disChargArray,@"deviceSn":self.deviceStr};
    [PlantSettingViewModel requestPostForURL:urlStr withParam:[self gs_jsonStringCompactFormatForDictionary:param] withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failur") : nil;
    }];
}


// HMI充放电计划时间获取
- (void)getHmiTimeSoltMsgWithCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/getHmiTimeSolt",HEAD_URL];
    NSDictionary *dic = @{@"deviceSn":self.deviceStr};
    [PlantSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.planModel = [PlanArrayModel mj_objectWithKeyValues:resultData];
            
            [self.batteryChargArray removeAllObjects];
            [self.batteryDisChargArray removeAllObjects];
            
            // 时间数据处理
            for (TimeModel *model in self.planModel.data) {
                if (model.charge == 0 && model.show == 1){
                    [self.batteryDisChargArray addObject:model];
                } else if (model.charge == 1 && model.show == 1){
                    [self.batteryChargArray addObject:model];
                }
            }
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}

// HMI电价与时间段获取
- (void)getHmiElectricityPriceCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/getElectricityPrice",HEAD_URL];
    NSDictionary *dic = @{@"deviceSn":self.deviceStr};
    [PlantSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.priceModel = [ElectricityPriceModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            
            [self.electricityPriceArray removeAllObjects];
            [self.priceArray removeAllObjects];
            
            NSArray *array = @[self.priceModel.tipWhen,self.priceModel.peak,self.priceModel.ordinary,self.priceModel.valley];
            [self.priceArray addObjectsFromArray: array];
            [self.electricityPriceArray addObject: [self getShowPriceArray:self.priceModel.tipWhenList]];
            [self.electricityPriceArray addObject: [self getShowPriceArray:self.priceModel.peakList]];
            [self.electricityPriceArray addObject: [self getShowPriceArray:self.priceModel.ordinaryList]];
            [self.electricityPriceArray addObject: [self getShowPriceArray:self.priceModel.valleyList]];
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}

// HMI电价与时间段设置
- (void)setHmiElectricityPriceCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    
    NSMutableDictionary *allDic = [NSMutableDictionary dictionary];

    for (int i = 0; i < self.electricityPriceArray.count; i++) {
        NSArray<ElectricityPriceTimeModel *> *array = self.electricityPriceArray[i];
        NSMutableArray *setArray = [NSMutableArray array];
       
        for (ElectricityPriceTimeModel *model in array) {
            NSMutableDictionary * listDic = [NSMutableDictionary dictionary];
            [listDic setValue:[model.start substringToIndex:2] forKey:@"startHour"];
            [listDic setValue:[model.start substringFromIndex:3] forKey:@"startMinute"];
            [listDic setValue:[model.end substringToIndex:2] forKey:@"endHour"];
            [listDic setValue:[model.end substringFromIndex:3] forKey:@"endMinute"];
            [listDic setValue:model.order forKey:@"order"];
            [setArray addObject:listDic];
        }
        for (int j = 0; j < 4; j++) {
            if (j > setArray.count - 1 ) {
                NSDictionary *dic = @{@"startHour":@"00",@"startMinute":@"00",@"endHour":@"00",@"endMinute":@"00",@"order":@(j)};
                [setArray addObject:dic];
            }
        }
        
        switch (i) {
            case 0:
                [allDic setValue:setArray forKey:@"tipList"];
                [allDic setValue:self.priceArray[0] forKey:@"tip"];
                break;
            case 1:
                [allDic setValue:setArray forKey:@"peakList"];
                [allDic setValue:self.priceArray[1] forKey:@"peak"];
                break;
            case 2:
                [allDic setValue:setArray forKey:@"ordinaryList"];
                [allDic setValue:self.priceArray[2] forKey:@"ordinary"];
                break;
            case 3:
                [allDic setValue:setArray forKey:@"valleyList"];
                [allDic setValue:self.priceArray[3] forKey:@"valley"];
                break;
            default:
                break;
        }
    }
    
    
    
    
    [allDic setValue:self.deviceStr forKey:@"deviceSn"];
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setElectricityPrice",HEAD_URL];
    [PlantSettingViewModel requestPostForURL:urlStr withParam:[self gs_jsonStringCompactFormatForDictionary:allDic] withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}


- (NSMutableArray *)getShowPriceArray:(NSArray<ElectricityPriceTimeModel*>*)array {
    NSMutableArray *listArray = [NSMutableArray array];
    for (ElectricityPriceTimeModel *model in array) {
        if (model.show == 1) {
            [listArray addObject:model];
        }
    }
    return listArray;
}






-(NSMutableArray<TimeModel *> *)batteryChargArray {
    if (!_batteryChargArray) {
        TimeModel *model = [[TimeModel alloc]init];
        model.startHour = @"00";
        model.endHour = @"00";
        model.startMinute = @"00";
        model.endMinute = @"00";
        model.power = @"0";
        model.order = @"0";
        model.show = 1;
        model.charge = 1;
        _batteryChargArray = [NSMutableArray arrayWithObjects:model, nil];
    }
    return _batteryChargArray;
}

-(NSMutableArray<TimeModel *> *)batteryDisChargArray {
    if (!_batteryDisChargArray) {
        TimeModel *model = [[TimeModel alloc]init];
        model.startHour = @"00";
        model.endHour = @"00";
        model.startMinute = @"00";
        model.endMinute = @"00";
        model.power = @"0";
        model.order = @"0";
        model.show = 1;
        model.charge = 0;
        _batteryDisChargArray = [NSMutableArray arrayWithObjects:model,nil];
    }
    return _batteryDisChargArray;
}

-(NSMutableArray <NSMutableArray*> *)electricityPriceArray{
    if (!_electricityPriceArray) {
        ElectricityPriceTimeModel *model = [[ElectricityPriceTimeModel alloc]init];
        _electricityPriceArray = [NSMutableArray arrayWithObject:[NSArray arrayWithObject:model]];
    }
    return _electricityPriceArray;
}

-(NSMutableArray *)timeValueArray {
    if (!_timeValueArray) {
        _timeValueArray = [NSMutableArray arrayWithArray:@[@[@"00:00-00:00",@"00:00-00:00",@"00:00-00:00",@"00:00-00:00"],@[@"00:00-00:00",@"00:00-00:00",@"00:00-00:00",@"00:00-00:00"]]];

    }
    return _timeValueArray;
}

-(NSMutableArray *)electricityTitleArray {
    if (!_electricityTitleArray) {
        _electricityTitleArray = [NSMutableArray arrayWithObjects:@"TOP",@"PEAK",@"OFF PEAK",@"PLAT", nil];

    }
    return _electricityTitleArray;
}

-(NSMutableArray *)priceArray {
    if (!_priceArray) {
        _priceArray = [NSMutableArray array];
    }
    return _priceArray;
}

-(SetElectricityPriceModel *)priceParamModel{
    if (!_priceParamModel) {
        _priceParamModel = [[SetElectricityPriceModel alloc]init];
    }
    return _priceParamModel;
}
@end
