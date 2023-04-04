//
//  CabinetModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "CabinetModel.h"

@implementation CabinetModel

@end

@implementation CabinetBasicInfoModel

@end


@implementation CabinetBatteryInfoModel

@end

@implementation CabinetGridInfoModel

@end

@implementation CabinetMpptModel

@end


@implementation CabinetMsgInfoModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"acModelList" : @"CabinetModel",
             @"mpptList" : @"CabinetMpptModel"
             };
}

@end
