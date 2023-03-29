//
//  InveterDeviceView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/28.
//

#import <UIKit/UIKit.h>
#import "InveterViewModel.h"

typedef void(^InvDeviceRealoadBlock)(void);

@interface InveterDeviceView : UIView

-(instancetype)initWithViewModel:(InveterViewModel *)viewModel;

- (void)reloadDeviceTableView;

@property (nonatomic,copy) InvDeviceRealoadBlock headerRealoadBlock;
@end


