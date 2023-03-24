//
//  INVSettingViewModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/15.
//

#import "INVSettingViewModel.h"
#import "MJExtension.h"

@interface INVSettingViewModel()


@end

@implementation INVSettingViewModel


// 获取电站信息
-(void)getPowerStationMessageWith:(NSString *)idStr completeBlock:(void(^)(NSString *resultStr))completeBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/plant/getById",HEAD_URL];

    NSDictionary *dic = @{@"id":idStr};
    [INVSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.deviceModel = [DeviceModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            if ((self.deviceModel.plantType == 1 && self.deviceModel.mgrnList.count > 0) || (self.deviceModel.plantType == 0 && self.deviceModel.pcsList.count > 0)) {
                self.deviceSnStr = self.deviceModel.mgrnList.count > 0 ? self.deviceModel.mgrnList[0] : self.deviceModel.pcsList[0];
                self.isHaveDevice = YES;
                self.deviceType = self.deviceModel.plantType;
            } else {
                self.isHaveDevice = NO;
            }
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}


// 获取逆变器数据
-(void)getSettingInverterParamMsgCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/getInverterParam",HEAD_URL];

    NSDictionary *dic = @{@"deivceSn":self.deviceSnStr};
    [INVSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.settingModel = [SettingModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            self.optionModel.settingModel = self.settingModel;
            [self.optionModel addBasicSettingDataArray];
            [self.optionModel addAdvancedSettingDataArray];
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}

// 设置逆变器数据
-(void)setUpInverterSingleParam:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr))completeBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setUpInverterSingletParam",HEAD_URL];
    NSString *paramStr = [self gs_jsonStringCompactFormatForDictionary:param];
    [INVSettingViewModel requestPostForURL:urlStr withParam:paramStr withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}

// 设置逆变器系统时间
-(void)setInverterTimeParam:(NSDictionary *)param completeBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setInverterTime",HEAD_URL];
    NSString *paramStr = [self gs_jsonStringCompactFormatForDictionary:param];
    [INVSettingViewModel requestPostForURL:urlStr withParam:paramStr withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}


// 获取HMI数据
- (void)getPcsParamMsgCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/getPcsParam",HEAD_URL];

    NSDictionary *dic = @{@"deviceSn":self.deviceSnStr};
    [INVSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.settingModel = [SettingModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            self.optionModel.settingModel = self.settingModel;
            [self.optionModel cabinetAddBasicSettingDataArray];
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        
    }];
}

// HMI数据设置
-(void)setHMIParam:(NSDictionary *)param completeBlock:(void (^)(NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setHmiParam",HEAD_URL];
    [INVSettingViewModel requestPostForURL:urlStr withParam:[self gs_jsonStringCompactFormatForDictionary:param] withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}

// HMI系统时间设置
-(void)setPcsSystemTimeParm:(NSDictionary *)param completeBlock:(void (^)(NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setPcsSystemTime",HEAD_URL];
    [INVSettingViewModel requestPostForURL:urlStr withParam:[self gs_jsonStringCompactFormatForDictionary:param] withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}




-(SettingOptionModel *)optionModel {
    if (!_optionModel) {
        _optionModel = [[SettingOptionModel alloc]init];
    }
    return _optionModel;
}




@end
