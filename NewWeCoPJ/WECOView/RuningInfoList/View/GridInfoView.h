//
//  GridInfoView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <UIKit/UIKit.h>
#import "CabinetViewModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^GridInfoRealoadBlock)(void);

@interface GridInfoView : UIView


-(instancetype)initWithViewModel:(CabinetViewModel *)viewModel;

- (void)reloadTableView;

@property (nonatomic,copy) GridInfoRealoadBlock headerRealoadBlock;
@end

NS_ASSUME_NONNULL_END
