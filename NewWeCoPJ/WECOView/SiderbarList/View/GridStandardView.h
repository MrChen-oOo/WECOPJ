//
//  GridStandardView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import <UIKit/UIKit.h>
#import "INVSettingViewModel.h"

typedef void(^SelectCellBlock)(NSDictionary *dic);


@interface GridStandardView : UIView

-(instancetype)initWithViewModel:(INVSettingViewModel *)viewModel;

-(void)selectCellActionWith:(NSInteger)cellNum type:(NSString *)typeStr title:(NSString *)titleStr;

@property (nonatomic,copy) SelectCellBlock selectCellBlock;
@property (nonatomic, strong)NSMutableArray *titleArray;

@end


