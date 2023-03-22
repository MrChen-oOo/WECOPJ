//
//  BasicTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BasicSettingDelegate <NSObject>
@optional

-(void)didClickSwichActionWith:(NSDictionary *)param swich:(UISwitch *)swich;
-(void)didClickPlanSetting;
-(void)didClickStartUpWithShutDown:(BOOL)isStart;
-(void)didClickReloadAction;
@end

@interface BasicTableViewCell : UITableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath;

-(void)setMessageWithOptionArray:(NSArray *)optionArray valueArray:(NSArray *)valueArray keyArray:(NSArray *)keyArray selectArray:(NSArray *)selectArray row:(NSInteger)row;
-(void)setUIWithUIArray:(NSArray *)array deviceStr:(NSString *)deviceStr;

@property (nonatomic, weak)id<BasicSettingDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
