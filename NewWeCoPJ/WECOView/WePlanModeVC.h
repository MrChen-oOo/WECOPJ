//
//  WePlanModeVC.h
//  RedxPJ
//
//  Created by CBQ on 2023/1/12.
//  Copyright © 2023 qwl. All rights reserved.
//

#import "RedxRootNewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WePlanModeVC : RedxRootNewViewController
@property (nonatomic, strong)NSString *devSN;
@property (nonatomic, strong)NSString *maindevType;//0：PCS；1：逆变器

@end

NS_ASSUME_NONNULL_END
