//
//  WeTitleView.h
//  NewWeCoPJ
//
//  Created by 啊清 on 2023/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^backData)(NSString *NameStr,NSInteger rowNumb);
@interface WeTitleView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *devTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) backData SelectBlock;

- (void)reloadTableVData;
@end

NS_ASSUME_NONNULL_END
