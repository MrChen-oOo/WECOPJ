//
//  PlantSettingViewModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import <Foundation/Foundation.h>
#import "TimeModel.h"
#import "RBaseViewModel.h"


@interface PlantSettingViewModel : RBaseViewModel

@property (nonatomic, strong) NSMutableArray<TimeModel *> *batteryChargArray;
@property (nonatomic, strong) NSMutableArray<TimeModel *> *batteryDisChargArray;
@property (nonatomic, strong) NSMutableArray *timeChargArray;
@property (nonatomic, strong) NSMutableArray *timeValueArray;

@property (nonatomic, strong) PlanArrayModel *planModel;
@property (nonatomic, strong) NSString *deviceStr;

-(void)getInverterTimeSoltMsgWithParam:(NSString *)param completeBlock:(void(^)(NSString *resultStr))completeBlock;

-(void)setUpPlantModelParamCompleteBlock:(void(^)(NSString *resultStr))completeBlock;

@end


