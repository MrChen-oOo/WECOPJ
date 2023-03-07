#import <UIKit/UIKit.h>
typedef void(^SelectedItem)(NSString *item);
typedef void(^rightItemBlock)();
@interface RedxAnotherSearchViewController : UIViewController
@property (strong, nonatomic) SelectedItem block;
@property (strong, nonatomic) rightItemBlock rightItemBlock;
@property (assign, nonatomic) BOOL isNeedRightItem;
@property (strong, nonatomic) NSArray *dataSource;
- (void)didSelectedItem:(SelectedItem)block;
@end
