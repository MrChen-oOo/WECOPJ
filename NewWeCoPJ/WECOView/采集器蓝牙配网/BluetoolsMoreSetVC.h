//
//  BluetoolsMoreSetVC.h
//  ShinePhone
//
//  Created by CBQ on 2022/4/12.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "RedxRootNewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BluetoolsMoreSetVC : RedxRootNewViewController
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *SNStr;

@property(nonatomic,strong)NSString *whereIN;//注册进1采集器列表进2,oss进3,其他0，采集器列表上面的添加4，我的页面进采集器配置5,登录的添加采集器进6
@end

NS_ASSUME_NONNULL_END
