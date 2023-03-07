//
//  CollectorUpdataFirstVC.h
//  ShinePhone
//
//  Created by CBQ on 2022/3/7.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "RedxRootNewViewController.h"
typedef void(^goinblock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface CollectorUpdataFirstVC : RedxRootNewViewController
@property (nonatomic, strong) NSString *isWifiXOrS;//0 x,1 s
@property (nonatomic, strong) NSString *SNStr;
@property (nonatomic, strong) goinblock NextBlock;

@property (nonatomic, strong) NSString *isBlueIN;

@end

NS_ASSUME_NONNULL_END
