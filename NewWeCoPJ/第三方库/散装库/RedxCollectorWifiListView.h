#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^block)(NSString *backStr);
@interface RedxCollectorWifiListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)NSArray *dataSource;
@property (nonatomic, strong)block backwifi;
@end
NS_ASSUME_NONNULL_END
