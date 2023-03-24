

#import <UIKit/UIKit.h>


typedef void(^backBlock)(NSInteger selectNumb);
@interface RedxCeHuaView : UIView
@property (nonatomic, strong)UIView *leftview;
@property (nonatomic, strong)backBlock selectBlock;

@property (nonatomic, assign)BOOL isHaveDevice;
@property (nonatomic, assign)BOOL isMgrn;

-(void)createValueUIWith:(BOOL)isMgrn isHaveDevice:(BOOL)isHaveDevice;
@end


