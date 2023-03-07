//
//  BluetoolsDataSetVC.h
//  ShinePhone
//
//  Created by CBQ on 2022/4/12.
//  Copyright © 2022 qwl. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface BluetoolsDataSetVC : RedxRootNewViewController
@property (strong, nonatomic)  NSString *wifiName;

@property (nonatomic, strong) NSString *stationID;

@property (nonatomic, strong) NSString *SnString;//采集器序列号
@property (nonatomic, strong) NSString *codeStr;


@property (nonatomic, strong)CBPeripheral *buleDevice;
//@property(nonatomic,strong)NSString *AuthKey;

@end

NS_ASSUME_NONNULL_END
