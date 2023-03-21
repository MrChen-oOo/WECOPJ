//
//  SettingOptionModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import <Foundation/Foundation.h>
#import "SettingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingOptionModel : NSObject

// LV Inverter相关数据以及UI的model
@property (nonatomic, strong) NSMutableArray<NSString *> *basicSettingOptionSectionArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *basicSettingOptionKeyArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *basicSettingOptionValueArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *basicSettingUIArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *basicSettingSelectArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *basicSettingParamArray;



@property (nonatomic, strong) NSMutableArray<NSString *> *advancedSettingOptionSectionArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *advancedSettingOptionKeyArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *advancedSettingOptionValueArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *advancedSettingUIArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *advancedSettingSelectArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *advancedSettingParamArray;

@property (nonatomic, strong) SettingModel *settingModel;

// 相关选择列表的数组
@property (nonatomic, strong) NSMutableArray *gridStandardsValueArray;
@property (nonatomic, strong) NSMutableArray *gridStandardsKeyArray;
@property (nonatomic, strong) NSMutableArray *usaStandardClassArray;
@property (nonatomic, strong) NSMutableArray *gridSetArray;
@property (nonatomic, strong) NSMutableArray *inputTypeArray;
@property (nonatomic, strong) NSMutableArray *parallelArray;
@property (nonatomic, strong) NSMutableArray *phaseEnableArray;
@property (nonatomic, strong) NSMutableArray *modbusArray;

- (void)addBasicSettingDataArray;
- (void)addAdvancedSettingDataArray;

@end

NS_ASSUME_NONNULL_END
