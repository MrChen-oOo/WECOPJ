//
//  HomePageViewModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import <Foundation/Foundation.h>
#import "RBaseViewModel.h"
#import "SettingModel.h"
#import "HomePageModel.h"

@interface HomePageViewModel : RBaseViewModel

@property (nonatomic, strong)NSString *deviceSnStr;
@property (nonatomic, assign)BOOL isHaveDevice;                     // 是否绑定逆变器或者HMI设备
@property (nonatomic, assign)NSInteger deviceType;                  // 设备类型 0:HMI 1:MGRN
@property (nonatomic, strong)DeviceModel *deviceModel;              // 电站信息
@property (nonatomic, strong)PlanListModel *planListModel;          // 电站列表信息
@property (nonatomic, strong)DeviceStatusModel *homeModel;          // 流向图信息

// 获取电站列表
-(void)getPlanListCompleteBlock:(void(^)(NSString *resultStr))completeBlock;

// 电站信息获取（区分设备类型 0:HMI 1:MGRN）
-(void)getPowerStationMessageWith:(NSString *)idStr completeBlock:(void(^)(NSString *resultStr, NSString* codeStr))completeBlock;

// 首页流向图
-(void)getHomePageMessageWith:(NSString *)idStr completeBlock:(void(^)(NSString *resultStr, NSString* codeStr))completeBlock;


@end


