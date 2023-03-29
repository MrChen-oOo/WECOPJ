//
//  BasicTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/15.
//

#import <UIKit/UIKit.h>
#import "INVSettingViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BasicSettingDelegate <NSObject>
@optional

-(void)didClickSwichActionWith:(NSDictionary *)param swich:(UISwitch *)swich;
-(void)didClickPlanSettingWithIsTimePlanSetting:(BOOL)isTime;
-(void)didClickStartUpWithShutDown:(BOOL)isStart;
-(void)didClickReloadAction;
@end

@interface BasicTableViewCell : UITableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath deviceType:(NSInteger)deviceType;

-(void)setMessageWithValueArray:(NSArray *)valueArray keyArray:(NSArray *)keyArray unitArray:(NSArray *)unitArray row:(NSInteger)row;
-(void)setUIWithUIArray:(NSArray *)array deviceStr:(NSString *)deviceStr;

@property (nonatomic, weak)id<BasicSettingDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
