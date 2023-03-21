//
//  BDCMassageCell.h
//  LocalDebug
//
//  Created by CBQ on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^scrollXBlock)(int xoffSet);

@interface BDCMassageCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, strong)NSArray *NameSource;
@property (nonatomic, strong)NSArray *dataSource;
@property (nonatomic, strong)NSDictionary *deviceAllDic;

- (void)reloadBDCMessageCell;

@property (nonatomic, strong)NSArray *AllNameArr;
@property (nonatomic, strong)NSDictionary *AllValueDic;
@property (nonatomic, strong)NSArray *AllKeyArr;

@property (nonatomic, strong)scrollXBlock ScrollOffSetBlock;

- (void)createCellUI;


@end

NS_ASSUME_NONNULL_END
