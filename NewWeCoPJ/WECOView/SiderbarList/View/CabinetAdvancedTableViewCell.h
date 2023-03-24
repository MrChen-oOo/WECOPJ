//
//  CabinetAdvancedTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/22.
//

#import <UIKit/UIKit.h>


@protocol CabineBasicSettingDelegate <NSObject>
@optional
-(void)didClickStartUpWithStatus:(NSInteger)status;

@end

@interface CabinetAdvancedTableViewCell : UITableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak)id<CabineBasicSettingDelegate>delegate;


@end


