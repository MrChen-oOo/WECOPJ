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
    for (TimeModel *model in self.batteryChargArray) {
        NSDictionary *dic = @{@"isCharge":@(model.charge),@"startHour":model.startHour,@"startMinute":model.startMinute,@"endHour":model.endHour,@"endMinute":model.endMinute,@"power":model.power};
        [chargeArray addObject:dic];
    }
    for (TimeModel *model in self.batteryDisChargArray) {
        NSDictionary *dic = @{@"isCharge":@(model.charge),@"startHour":model.startHour,@"startMinute":model.startMinute,@"endHour":model.endHour,@"endMinute":model.endMinute,@"power":model.power};
        [disChargArray addObject:dic];
    }
    NSDictionary *chargeDic =  @{@"isCharge":@(0),@"startHour":@"00",@"startMinute":@"00",@"endHour":@"00",@"endMinute":@"00",@"power":@"0"};
    if (chargeArray.count < 3) {
        NSInteger num = 3 - chargeArray.count;
        for (int i = 0; i < num; i++) {
            [chargeArray addObject:chargeDic];
        }
    }
    NSDictionary *disChargeDic =  @{@"isCharge":@(1),@"startHour":@"00",@"startMinute":@"00",@"endHour":@"00",@"endMinute":@"00",@"power":@"0"};
    if (disChargArray.count < 3) {
        NSInteger num = 3 - chargeArray.count;
        for (int i = 0; i < num; i++) {
            [chargeArray addObject:disChargeDic];
        }
    }
    
    NSDictionary *param = @{@"deviceSn":self.deviceStr,@"charge":chargeArray,@"disCharge":disChargArray};
    NSLog(@"时间参数：%@",param);

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
