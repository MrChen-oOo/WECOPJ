//
//  InpuPopView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/17.
//

#import <UIKit/UIKit.h>
#import "INVSettingViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeDataBlock)(NSDictionary *dic);


@interface InpuPopView : UIView

-(instancetype)initWithViewModel:(INVSettingViewModel *)viewModel;

- (void)isHaveUnitWith:(BOOL)isHave numStr:(NSString *)numStr paramsStr:(NSString *)paramsStr index:(NSIndexPath *)indexPath title:(NSString *)titeleStr; 
@property (nonatomic,copy) ChangeDataBlock changeDataBlock;

@end










NS_ASSUME_NONNULL_END
