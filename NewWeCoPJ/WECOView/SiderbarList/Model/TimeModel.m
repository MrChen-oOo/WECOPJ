//
//  TimeModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import "TimeModel.h"

@implementation TimeModel

@end

@implementation PlanArrayModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"data" : @"TimeModel"
             };
}

@end

@implementation ElectricityPriceTimeModel


@end


@implementation ElectricityPriceModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"tipWhenList" : @"ElectricityPriceTimeModel",
             @"peakList" : @"ElectricityPriceTimeModel",
             @"ordinaryList" : @"ElectricityPriceTimeModel",
             @"valleyList" : @"ElectricityPriceTimeModel"
             };
}

@end

@implementation SetElectricityPriceTimeModel


@end


@implementation SetElectricityPriceModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"tipList" : @"SetElectricityPriceTimeModel",
             @"peakList" : @"SetElectricityPriceTimeModel",
             @"ordinaryList" : @"SetElectricityPriceTimeModel",
             @"valleyList" : @"SetElectricityPriceTimeModel"
             };
}


@end
