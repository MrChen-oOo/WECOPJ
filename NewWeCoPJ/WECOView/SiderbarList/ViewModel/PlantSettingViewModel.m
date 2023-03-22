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
-(void)getInverterTimeSoltMsgWithParam:(NSString *)param completeBlock:(void(^)(NSString *resultStr))completeBlock {
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

    for (int i = 0; i < 3; i++) {
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

-(NSMutableArray<TimeModel *> *)batteryChargArray {
    if (!_batteryChargArray) {
        TimeModel *model = [[TimeModel alloc]init];
        _batteryChargArray = [NSMutableArray arrayWithObjects:model, nil];
    }
    return _batteryChargArray;
}

-(NSMutableArray<TimeModel *> *)batteryDisChargArray {
    if (!_batteryDisChargArray) {
        TimeModel *model = [[TimeModel alloc]init];
        _batteryDisChargArray = [NSMutableArray arrayWithObjects:model,model,nil];
    }
    return _batteryDisChargArray;
}



-(NSMutableArray *)timeValueArray {
    if (!_timeValueArray) {
        _timeValueArray = [NSMutableArray arrayWithArray:@[@[@"00:00-00:00",@"00:00-00:00",@"00:00-00:00",@"00:00-00:00"],@[@"00:00-00:00",@"00:00-00:00",@"00:00-00:00",@"00:00-00:00"]]];

    }
    return _timeValueArray;
}

@end
