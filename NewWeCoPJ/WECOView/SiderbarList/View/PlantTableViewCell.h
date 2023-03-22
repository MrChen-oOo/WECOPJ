//
//  PlantTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import <UIKit/UIKit.h>
#import "PlantSettingViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PlanTimeDelegate <NSObject>
@optional

-(void)didClickAddAction:(NSIndexPath *)indexPath;
-(void)didClickReductionActionWith:(NSIndexPath *)indexPath;
-(void)didClickChangeTimeActionWith:(NSIndexPath *)indexPath label:(UILabel *)label;
@end

@interface PlantTableViewCell : UITableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath viewModel:(PlantSettingViewModel *)viewModel;

-(void)setMessageWithChargArray:(NSArray *)optionArray dischargeArray:(NSArray *)dischargeArray;

@property (nonatomic, weak)id<PlanTimeDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
