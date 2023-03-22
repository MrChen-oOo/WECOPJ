//
//  BasicWarningView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/17.
//

#import <UIKit/UIKit.h>
#import "INVSettingViewModel.h"


typedef void(^ShutDownBlock)(BOOL isShutDown);

@interface BasicWarningView : UIView


-(instancetype)initWithViewModel:(INVSettingViewModel *)viewModel;
@property (nonatomic,copy) ShutDownBlock ShutDownBlock;

-(void)showAttentionWith:(BOOL)isAttention;
@end


