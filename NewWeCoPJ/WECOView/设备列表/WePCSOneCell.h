//
//  WePCSOneCell.h
//  NewWeCoPJ
//
//  Created by 啊清 on 2023/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^scrollXBlock)(float xoffSet);
@interface WePCSOneCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *AllNameArr;
@property (nonatomic, strong)NSDictionary *AllValueDic;
@property (nonatomic, strong)NSArray *AllKeyArr;
@property (nonatomic, strong)UIView *onevie;
@property (nonatomic, strong)UIView *twovie;
@property (nonatomic, strong)UIView *threevie;
@property (nonatomic, strong)scrollXBlock ScrollOffSetBlock;

- (void)createCellUI;

@end

NS_ASSUME_NONNULL_END
