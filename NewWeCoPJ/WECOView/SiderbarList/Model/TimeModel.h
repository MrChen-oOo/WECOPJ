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

