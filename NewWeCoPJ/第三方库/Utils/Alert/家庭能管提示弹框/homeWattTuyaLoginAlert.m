//
//  homeWattTuyaLoginAlert.m
 
//
//  Created by BQ123 on 2019/10/8.
//  Copyright © 2019 qwl. All rights reserved.
//

#import "homeWattTuyaLoginAlert.h"

#define AlertTime 0.25 //弹出动画时间

@interface homeWattTuyaLoginAlert ()

@property (nonatomic, strong) UILabel *lblTips1;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, assign) BOOL isTabbar;

@end

@implementation homeWattTuyaLoginAlert

- (instancetype)initWithFrame:(CGRect)frame isTabbar:(BOOL)isTabbar{
    
    if (self = [super initWithFrame:frame]) {
        self.isTabbar = isTabbar;
        // 初始化弹框
        [self initUIWithAlertSize:frame.size];
        // 创建UI
        [self initUI];
    }
    return self;
}

// 创建UI
- (void)initUI{
    
    float babbarH = TabbarHeight;
    if (!_isTabbar) babbarH = kBottomBarHeight;
    CGRect bgRect = self.backgroundView.frame;
    bgRect.size.height = ScreenHeight-babbarH-kNavBarHeight;
    self.frame = bgRect;
    self.backgroundView.frame = bgRect;
    CGRect aRect = self.alertView.frame;
    aRect.origin.y -= (babbarH+kNavBarHeight)/2;
    self.alertView.frame = aRect;
    
    float viewW = self.alertView.frame.size.width, imgW = 65*XLscaleH;
    UIImageView *imgSL = [[UIImageView alloc]initWithFrame:CGRectMake((viewW-imgW)/2, 30*XLscaleH, imgW, imgW)];
    imgSL.image = IMAGE(@"toast_liandong_not");
    [self.alertView addSubview:imgSL];
    // 提示1
    float labelH = 40*XLscaleH;
    UILabel *lblTips1 = [[UILabel alloc]initWithFrame:CGRectMake(15*XLscaleW, CGRectGetMaxY(imgSL.frame)+15*XLscaleH, viewW-30*XLscaleW, labelH)];
    lblTips1.text = root_SmartHome_1149;
    lblTips1.textColor = colorblack_51;
    lblTips1.textAlignment = NSTextAlignmentCenter;
    lblTips1.font = [UIFont systemFontOfSize:16.0*XLscaleH];
    lblTips1.numberOfLines = 0;
    [self.alertView addSubview:lblTips1];
    self.lblTips1 = lblTips1;
    // 提示2
    UILabel *lblTips2 = [[UILabel alloc]initWithFrame:CGRectMake(15*XLscaleW, CGRectGetMaxY(lblTips1.frame)+5*XLscaleH, viewW-30*XLscaleW, labelH)];
    lblTips2.text = root_SmartHome_1150;
    lblTips2.textColor = colorblack_102;
    lblTips2.textAlignment = NSTextAlignmentCenter;
    lblTips2.font = FontSize(14*XLscaleH);
    lblTips2.numberOfLines = 0;
    [self.alertView addSubview:lblTips2];
    // 确定
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.frame = CGRectMake(30*XLscaleW, CGRectGetMaxY(lblTips2.frame)+20*XLscaleH, viewW-60*XLscaleW, 50*XLscaleH);
    XLViewBorderRadius(confirmBtn, 48*XLscaleH/2, 0, kClearColor);
    [confirmBtn setBackgroundColor:mainColor];
    [confirmBtn setTitle:root_log_in forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16*XLscaleH];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.alertView addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn = confirmBtn;
    
    self.backgroundView.alpha = 0;
    [self.alertView setHidden:YES];
    [self.backgroundView setHidden:YES];
    [self setHidden:YES];
}

// 确定
- (void)confirmAction{
    // 点击重新登录
    if(self.touchAlertReconnection){
        self.touchAlertReconnection();
    }
}



#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    
    if (animation) {
        [self.alertView setHidden:NO];
        [self.backgroundView setHidden:NO];
        [self setHidden:NO];
        
        self.alpha = 0;
        self.backgroundView.alpha = 0;
        self.alertView.transform = CGAffineTransformScale(self.alertView.transform,0.1,0.1);
        // 浮现动画
        [UIView animateWithDuration:AlertTime animations:^{
            self.alpha = 1;
            self.backgroundView.alpha = 1;
            self.alertView.transform = CGAffineTransformIdentity;
        }];
    }else{
        [self.alertView setHidden:NO];
        [self.backgroundView setHidden:NO];
        [self setHidden:NO];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    
    if(animation){
        // 关闭动画
        [UIView animateWithDuration:AlertTime animations:^{
            
            self.alertView.transform = CGAffineTransformScale(self.alertView.transform,0.1,0.1);
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            
            self.backgroundView.alpha = 0;
            [self.alertView setHidden:YES];
            [self.backgroundView setHidden:YES];
            [self setHidden:YES];
        }];
    } else{
        self.backgroundView.alpha = 0;
        [self.alertView setHidden:YES];
        [self.backgroundView setHidden:YES];
        [self setHidden:YES];
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
