

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^backBlock)(NSInteger selectNumb);
@interface RedxCeHuaView : UIView
@property (nonatomic, strong)UIView *leftview;
@property (nonatomic, strong)backBlock selectBlock;


@end

NS_ASSUME_NONNULL_END
