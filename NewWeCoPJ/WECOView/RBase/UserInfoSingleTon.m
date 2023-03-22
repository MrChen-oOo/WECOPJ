//
//  UserInfoSingleTon.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import "UserInfoSingleTon.h"

@implementation UserInfoSingleTon

+(instancetype)userInfoInstance{
    static UserInfoSingleTon *userInfoSingle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfoSingle = [[super allocWithZone:NULL] init];
    });
    return userInfoSingle;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [UserInfoSingleTon userInfoInstance];
}

@end
