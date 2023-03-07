//
//  WeSystemView.h
//  RedxPJ
//
//  Created by CBQ on 2022/11/24.
//  Copyright © 2022 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "CircleView.h"
#import "DeviceBatteryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeSystemView : UIView

@property (nonatomic, strong)UILabel *ppvLB;
@property (nonatomic, strong)UILabel *GridLB;
@property (nonatomic, strong)UILabel *batPowerLB;
@property (nonatomic, strong)UILabel *socLB;
@property (nonatomic, strong)UILabel *HomeLB;
@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, strong)UIImageView *SolarIMGV;
@property (nonatomic, strong)UIImageView *GridMGV;
@property (nonatomic, strong)UIImageView *BatIMGV;
@property (nonatomic, strong)UIImageView *HomeIMGV;
@property (nonatomic, strong)CircleView *progressView;
@property (nonatomic, assign)CGFloat socPercentValue;
@property (nonatomic, strong)NSTimer *timer;




- (void)createSystemUI;


@end

NS_ASSUME_NONNULL_END
