//
//  solarLinkNoAmmeterPromptAlert.m
 
//
//  Created by BQ123 on 2019/4/17.
//  Copyright © 2019 qwl. All rights reserved.
//

#import "solarLinkNoAmmeterPromptAlert.h"// 电表未接入提示框

#define AlertTime 0.25 //弹出动画时间

@implementation solarLinkNoAmmeterPromptAlert

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        // 初始化弹框
        [self initUIWithAlertSize:frame.size];
        // 创建UI
        [self initUI];
//        // 视图展开
//        [self showWithAnimation:YES];
    }
    return self;
}

// 创建UI
- (void)initUI{
    
    float viewW = self.alertView.frame.size.width, imgW = 65*XLscaleH;
    UIImageView *imgSL = [[UIImageView alloc]initWithFrame:CGRectMake((viewW-imgW)/2, 30*XLscaleH, imgW, imgW)];
    imgSL.image = IMAGE(@"toast_liandong_not");
    [self.alertView addSubview:imgSL];
    // 提示1
    float labelH = 40*XLscaleH;
    UILabel *lblTips1 = [[UILabel alloc]initWithFrame:CGRectMake(15*XLscaleW, CGRectGetMaxY(imgSL.frame)+15*XLscaleH, viewW-30*XLscaleW, labelH)];
    lblTips1.text = root_SmartHome_506;
    lblTips1.textColor = colorblack_51;
    lblTips1.textAlignment = NSTextAlignmentCenter;
    lblTips1.font = [UIFont systemFontOfSize:16.0*XLscaleH];
    lblTips1.numberOfLines = 0;
    [self.alertView addSubview:lblTips1];
    // 提示2
    UILabel *lblTips2 = [[UILabel alloc]initWithFrame:CGRectMake(15*XLscaleW, CGRectGetMaxY(lblTips1.frame)+5*XLscaleH, viewW-30*XLscaleW, labelH)];
    lblTips2.text = root_SmartHome_507;
    lblTips2.textColor = colorblack_102;
    lblTips2.textAlignment = NSTextAlignmentCenter;
//    lblTips2.font = FontSize([NSString getFontWithText:lblTips2.text size:lblTips2.xmg_size currentFont:15*XLscaleH]);
    lblTips2.font = FontSize(14*XLscaleH);
    lblTips2.numberOfLines = 0;
    [self.alertView addSubview:lblTips2];
    // 确定
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.frame = CGRectMake(30*XLscaleW, CGRectGetMaxY(lblTips2.frame)+20*XLscaleH, viewW-60*XLscaleW, 50*XLscaleH);
    XLViewBorderRadius(confirmBtn, 48*XLscaleH/2, 0, kClearColor);
//    [confirmBtn setBackgroundImage:IMAGE(@"btn") forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:mainColor];
    [confirmBtn setTitle:root_quereng forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16*XLscaleH];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.alertView addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
}

// 确定
- (void)confirmAction{
    [self dismissWithAnimation:YES];
}



#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    
    [KEYWINDOW addSubview:self] ;
    if (animation) {
        self.alpha = 0;
        self.backgroundView.alpha = 0;
        self.alertView.transform = CGAffineTransformScale(self.alertView.transform,0.1,0.1);
        // 浮现动画
        [UIView animateWithDuration:AlertTime animations:^{
            self.alpha = 1;
            self.backgroundView.alpha = 1;
            self.alertView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:AlertTime animations:^{
        
        self.alertView.transform = CGAffineTransformScale(self.alertView.transform,0.1,0.1);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.alertView = nil;
        self.backgroundView = nil;
    }];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}








@end
