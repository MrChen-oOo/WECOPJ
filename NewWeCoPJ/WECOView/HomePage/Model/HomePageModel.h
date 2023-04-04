//
//  HomePageModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * incomeUnit;
@property (nonatomic, strong) NSString * installationData;
@property (nonatomic, strong) NSString * loadPower;
@property (nonatomic, strong) NSString * plantName;
@property (nonatomic, strong) NSString * plantPicturePath;
@property (nonatomic, strong) NSString * plantPicturePathText;
@property (nonatomic, strong) NSString * plantStatus;
@property (nonatomic, strong) NSString * plantType;
@property (nonatomic, strong) NSString * pvCapacity;
@property (nonatomic, strong) NSString * timeZone;
@property (nonatomic, strong) NSString * todayCharge;
@property (nonatomic, strong) NSString * totalCharge;

@end


@interface PlanListModel : NSObject
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSMutableArray <HomePageModel *> * obj;
@property (nonatomic, assign) NSInteger result;


@end


@interface  TodayInfoModel: NSObject
@property (nonatomic, strong) NSString * batCharge;
@property (nonatomic, strong) NSString * batDischarge;
@property (nonatomic, strong) NSString * co2Awolided;
@property (nonatomic, strong) NSString * gridTotalEnergy;
@property (nonatomic, strong) NSString * loadElectrical;
@property (nonatomic, strong) NSString * purchasingTotalEnergy;
@property (nonatomic, strong) NSString * pvElectrical;


@end

@interface  DeviceStatusModel: NSObject
@property (nonatomic, strong) NSString * batPower;
@property (nonatomic, strong) NSString * batSoc;
@property (nonatomic, strong) NSString * gridPower;
@property (nonatomic, strong) NSString * loadPower;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, strong) NSString * pvPower;
@property (nonatomic, assign) NSInteger  systemState;
@property (nonatomic, strong) TodayInfoModel * todayInfo;
@property (nonatomic, assign) NSInteger workModel;


@end
