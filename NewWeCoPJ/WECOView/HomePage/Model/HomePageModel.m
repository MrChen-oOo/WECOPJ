//
//  HomePageModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import "HomePageModel.h"

@implementation HomePageModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id"
             };
}

@end
@implementation PlanListModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"obj" : @"HomePageModel"
             };
}

@end

@implementation  TodayInfoModel

@end

@implementation  DeviceStatusModel

@end
