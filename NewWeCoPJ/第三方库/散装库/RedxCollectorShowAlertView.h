#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^backValue)(NSString *backValue);
@interface RedxCollectorShowAlertView : UIView
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UITextField *contenTF;
@property (nonatomic, strong)backValue backBlock;
- (void)setViewValue:(NSString *)contenStr title:(NSString *)titleStr;
@end
NS_ASSUME_NONNULL_END
