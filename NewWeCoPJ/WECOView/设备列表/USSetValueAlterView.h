//
//  USSetValueAlterView.h
//  LocalDebug
//
//  Created by CBQ on 2021/4/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^valueSetBlock)(NSString *valuestr);
@interface USSetValueAlterView : UIView

@property (nonatomic, strong)valueSetBlock valueBlock;
@property (nonatomic, strong)UITextField *valueTF;
@property (nonatomic, strong)UILabel *titLB;
@property (nonatomic, strong)UILabel *fanweiLB;
@property (nonatomic, strong)UILabel *danweiLB;


- (void)valueSet:(NSString *)value fanwei:(NSString *)fanwei danwei:(NSString *)danwei titleStr:(NSString *)titleStr;

- (void)showView;

@end

NS_ASSUME_NONNULL_END
