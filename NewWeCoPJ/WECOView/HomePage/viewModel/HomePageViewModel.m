//
//  HomePageViewModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import "HomePageViewModel.h"
#import "MJExtension.h"

@implementation HomePageViewModel

// 获取电站列表
-(void)getPlanListCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/v1/plant/getPlantList",HEAD_URL];

    NSDictionary *dic = @{@"email":[RedxUserInfo defaultUserInfo].email};
    
    [HomePageViewModel requestOldPostForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([[resultData objectForKey:@"result"] intValue] == 0) {
            self.planListModel = [PlanListModel mj_objectWithKeyValues:resultData];
            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;

    }];
    
    
}



// 获取电站信息
-(void)getPowerStationMessageWith:(NSString *)idStr completeBlock:(void (^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/plant/getById",HEAD_URL];

    NSDictionary *dic = @{@"id":idStr};
    [HomePageViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.deviceModel = [DeviceModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            if ((self.deviceModel.plantType == 1 && self.deviceModel.mgrnList.count > 0) || (self.deviceModel.plantType == 0 && self.deviceModel.pcsList.count > 0)) {
                self.deviceSnStr = self.deviceModel.mgrnList.count > 0 ? self.deviceModel.mgrnList[0] : self.deviceModel.pcsList[0];
                self.isHaveDevice = YES;
                self.deviceType = self.deviceModel.plantType;
            } else {
                self.isHaveDevice = NO;
            }
            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}

// 获取首页信息
-(void)getHomePageMessageWith:(NSString *)idStr completeBlock:(void (^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/home/get",HEAD_URL];

    NSDictionary *dic = @{@"deviceSn":idStr};
    [HomePageViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.homeModel = [DeviceStatusModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];

            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}



-(DeviceModel *)deviceModel {
    if (!_deviceModel) {
        _deviceModel = [[DeviceModel alloc]init];
    }
    return _deviceModel;
}

-(PlanListModel *)planListModel {
    if (!_planListModel) {
        _planListModel = [[PlanListModel alloc]init];
    }
    return _planListModel;
}

-(DeviceStatusModel *)homeModel {
    if (!_homeModel) {
        _homeModel = [[DeviceStatusModel alloc]init];
    }
    return _homeModel;
}


@end
