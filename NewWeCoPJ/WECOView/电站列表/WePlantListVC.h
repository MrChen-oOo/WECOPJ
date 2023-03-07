//
//  WePlantListVC.h
//  RedxPJ
//
//  Created by CBQ on 2022/12/2.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "RedxRootNewViewController.h"


typedef void(^SelePlantBlock)(NSString * _Nullable plantID,NSString * _Nullable plantName);
NS_ASSUME_NONNULL_BEGIN

@interface WePlantListVC : RedxRootNewViewController

@property (nonatomic, strong)SelePlantBlock seleClick;
@end

NS_ASSUME_NONNULL_END
