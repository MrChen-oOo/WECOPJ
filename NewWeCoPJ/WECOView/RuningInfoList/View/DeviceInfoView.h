//
//  DeviceInfoView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <UIKit/UIKit.h>
#import "CabinetViewModel.h"

typedef void(^DeviceInfoRealoadBlock)(void);


@interface DeviceInfoView : UIView


-(instancetype)initWithViewModel:(CabinetViewModel *)viewModel;

- (void)reloadTableView;

@property (nonatomic,copy) DeviceInfoRealoadBlock headerRealoadBlock;
@end


