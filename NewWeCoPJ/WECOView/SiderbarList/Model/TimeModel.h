//
//  TimeModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import <Foundation/Foundation.h>



@interface TimeModel : NSObject

@property (nonatomic, assign) NSInteger charge;
@property (nonatomic, strong) NSString * order;
@property (nonatomic, strong) NSString * power;
@property (nonatomic, strong) NSString * startHour;
@property (nonatomic, strong) NSString * startMinute;
@property (nonatomic, strong) NSString * endHour;
@property (nonatomic, strong) NSString * endMinute;
@property (nonatomic, assign) NSInteger show;

@end


@interface PlanArrayModel :NSObject

@property (nonatomic,strong) NSMutableArray<TimeModel *> *data;
@property (nonatomic, strong) NSString * errCode;
@property (nonatomic, strong) NSString * errMessage;
@property (nonatomic, strong) NSString * success;

@end


@interface ElectricityPriceTimeModel : NSObject
@property (nonatomic, strong) NSString * order;
@property (nonatomic, strong) NSString * start;
@property (nonatomic, strong) NSString * end;
@property (nonatomic, assign) NSInteger show;
@end


@interface ElectricityPriceModel : NSObject

@property (nonatomic, strong) NSString * tipWhen;
@property (nonatomic, strong) NSMutableArray <ElectricityPriceTimeModel *> * tipWhenList;
@property (nonatomic, strong) NSString * peak;
@property (nonatomic, strong) NSMutableArray <ElectricityPriceTimeModel *> * peakList;
@property (nonatomic, strong) NSString * ordinary;
@property (nonatomic, strong) NSMutableArray <ElectricityPriceTimeModel *> * ordinaryList;
@property (nonatomic, strong) NSString * valley;
@property (nonatomic, strong) NSMutableArray <ElectricityPriceTimeModel *> * valleyList;

@end


@interface SetElectricityPriceTimeModel : NSObject

@property (nonatomic, strong) NSString * order;
@property (nonatomic, strong) NSString * startHour;
@property (nonatomic, strong) NSString * startMinute;
@property (nonatomic, assign) NSString * endHour;
@property (nonatomic, assign) NSString * endMinute;

@end


@interface SetElectricityPriceModel : NSObject

@property (nonatomic, strong) NSString * tip;
@property (nonatomic, strong) NSMutableArray <SetElectricityPriceTimeModel *> * tipList;
@property (nonatomic, strong) NSString * peak;
@property (nonatomic, strong) NSMutableArray <SetElectricityPriceTimeModel *> * peakList;
@property (nonatomic, strong) NSString * ordinary;
@property (nonatomic, strong) NSMutableArray <SetElectricityPriceTimeModel *> * ordinaryList;
@property (nonatomic, strong) NSString * valley;
@property (nonatomic, strong) NSMutableArray <SetElectricityPriceTimeModel *> * valleyList;

@end
