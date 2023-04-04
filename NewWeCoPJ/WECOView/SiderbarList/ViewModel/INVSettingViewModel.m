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


// 获取逆变器数据
-(void)getSettingInverterParamMsgCompleteBlock:(void (^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/getInverterParam",HEAD_URL];

    NSDictionary *dic = @{@"deivceSn":self.deviceSnStr};
    [INVSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.settingModel = [SettingModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            self.optionModel.settingModel = self.settingModel;
            [self.optionModel addBasicSettingDataArray];
            [self.optionModel addAdvancedSettingDataArray];
            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}

// 设置逆变器数据
-(void)setUpInverterSingleParam:(NSDictionary *)param completeBlock:(void(^)(NSString *, NSString *))completeBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setUpInverterSingletParam",HEAD_URL];
    NSString *paramStr = [self gs_jsonStringCompactFormatForDictionary:param];
    [INVSettingViewModel requestPostForURL:urlStr withParam:paramStr withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}

// 设置逆变器系统时间
-(void)setInverterTimeParam:(NSDictionary *)param completeBlock:(void(^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setInverterTime",HEAD_URL];
    NSString *paramStr = [self gs_jsonStringCompactFormatForDictionary:param];
    [INVSettingViewModel requestPostForURL:urlStr withParam:paramStr withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}


// 获取HMI数据
- (void)getPcsParamMsgCompleteBlock:(void(^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/getPcsParam",HEAD_URL];

    NSDictionary *dic = @{@"deviceSn":self.deviceSnStr};
    [INVSettingViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.settingModel = [SettingModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            self.optionModel.settingModel = self.settingModel;
            [self.optionModel cabinetAddBasicSettingDataArray];
            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}

// HMI数据设置
-(void)setHMIParam:(NSDictionary *)param completeBlock:(void (^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setHmiParam",HEAD_URL];
    [INVSettingViewModel requestPostForURL:urlStr withParam:[self gs_jsonStringCompactFormatForDictionary:param] withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}

// HMI系统时间设置
-(void)setPcsSystemTimeParm:(NSDictionary *)param completeBlock:(void (^)(NSString *, NSString *))completeBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/terminal/setting/setPcsSystemTime",HEAD_URL];
    [INVSettingViewModel requestPostForURL:urlStr withParam:[self gs_jsonStringCompactFormatForDictionary:param] withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}




-(SettingOptionModel *)optionModel {
    if (!_optionModel) {
        _optionModel = [[SettingOptionModel alloc]init];
    }
    return _optionModel;
}




@end
