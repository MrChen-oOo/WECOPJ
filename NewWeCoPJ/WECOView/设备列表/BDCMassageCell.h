//
//  BDCMassageCell.h
//  LocalDebug
//
//  Created by CBQ on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDCMassageCell : UITableViewCell

@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, strong)NSArray *NameSource;
@property (nonatomic, strong)NSArray *dataSource;
@property (nonatomic, strong)NSDictionary *deviceAllDic;

- (void)reloadBDCMessageCell;

@end

NS_ASSUME_NONNULL_END
