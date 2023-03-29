//
//  InveterBatteryInfoView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/28.
//

#import <UIKit/UIKit.h>
#import "InveterViewModel.h"

typedef void(^InvBatteryRealoadBlock)(void);

@interface InveterBatteryInfoView : UIView

-(instancetype)initWithViewModel:(InveterViewModel *)viewModel;

- (void)reloadTableView;

@property (nonatomic,copy) InvBatteryRealoadBlock headerRealoadBlock;

@end


