//
//  CollectorRenewalFeeAlert.m
 
//
//  Created by BQ123 on 2019/4/17.
//  Copyright © 2019 qwl. All rights reserved.
//

#import "CollectorRenewalFeeAlert.h"

#define AlertTime 0.25 //弹出动画时间

@implementation CollectorRenewalFeeAlert

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        // 初始化弹框
        [self initUIWithAlertSize:frame.size];
    }
    return self;
}

// 创建UI
- (void)initUI{
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.60];// 颜色更加深
    
    float viewW = self.alertView.frame.size.width;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, 120*XLscaleH)];
    view.backgroundColor = COLOR(236, 239, 241, 1);
    [self.alertView addSubview:view];
    
    float imgH = 120*XLscaleH - 20*XLscaleH, imgW = imgH*6/5;
    UIImageView *imgCRF = [[UIImageView alloc]initWithFrame:CGRectMake((viewW-imgW)/2, 10*XLscaleH, imgW, imgH)];
    [view addSubview:imgCRF];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.imageUrl]];
    [imgCRF sd_setImageWithURL:url placeholderImage:IMAGE(@"") options:SDWebImageAllowInvalidSSLCertificates];
    
    // 标题
    float labelH = 25*XLscaleH;
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(15*XLscaleW, CGRectGetMaxY(view.frame)+10*XLscaleH, viewW-30*XLscaleW, labelH)];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData: [self.titleString dataUsingEncoding:NSUnicodeStringEncoding] options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes: nil error: nil];
    lblTitle.attributedText = attributedString;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont boldSystemFontOfSize:[NSString getFontWithText:lblTitle.text size:lblTitle.xmg_size currentFont:18*XLscaleH]];
    [self.alertView addSubview:lblTitle];

    // 内容
    UILabel *lblContent = [[UILabel alloc]initWithFrame:CGRectMake(15*XLscaleW, CGRectGetMaxY(lblTitle.frame)+10*XLscaleH, viewW-30*XLscaleW, labelH*4)];
    lblContent.textAlignment = NSTextAlignmentLeft;
    lblContent.numberOfLines = 0;
    [self.alertView addSubview:lblContent];
//    if (![_languageType isEqualToString:@"0"]) {
//        lblContent.frame = CGRectMake(15*XLscaleW, CGRectGetMaxY(lblTitle.frame)+10*XLscaleH, viewW-30*XLscaleW, labelH*6);
//
//        CGRect rect = self.alertView.frame;
//        rect.size.height += 2*labelH;
//        rect.origin.y -= labelH;
//        self.alertView.frame = rect;
//    }
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithData: [self.content dataUsingEncoding:NSUnicodeStringEncoding] options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes: nil error: nil];
    lblContent.attributedText = attributedString2;
    
    // 确定
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.frame = CGRectMake(30*XLscaleW, CGRectGetMaxY(lblContent.frame)+10*XLscaleH, viewW-60*XLscaleW, 45*XLscaleH);
    confirmBtn.backgroundColor = COLOR(45, 176, 238, 1);
    XLViewBorderRadius(confirmBtn, 45*XLscaleH/2, 0, kClearColor);
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.colors = @[(id)[UIColor colorWithRed:55.0f/255.0f green:143.0f/255.0f blue:250.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:30.0f/255.0f green:206.0f/255.0f blue:238.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(1, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(0, 1)];
    [confirmBtn.layer addSublayer:gradientLayer0];
    [confirmBtn setTitle:self.btnTitle forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16*XLscaleH];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.alertView addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    // 取消
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    btnCancel.frame = CGRectMake(30*XLscaleW, CGRectGetMaxY(confirmBtn.frame)+10*XLscaleH, viewW-60*XLscaleW, 30*XLscaleH);
    [btnCancel setTitle:root_SmartHome_502 forState:UIControlStateNormal];
    [btnCancel setTitleColor:colorblack_102 forState:UIControlStateNormal];
    btnCancel.titleLabel.font = FontSize(14*XLscaleH);
    [self.alertView addSubview:btnCancel];
    [btnCancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    // 取消2
    UIButton *btnCancel2 = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-40*XLscaleH)/2, CGRectGetMaxY(self.alertView.frame)+20*XLscaleH, 40*XLscaleH, 40*XLscaleH)];
    [btnCancel2 setImage:[UIImage imageNamed:@"alert_close"] forState:UIControlStateNormal];
    [self.backgroundView addSubview:btnCancel2];
    [btnCancel2 addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
}

// 确定
- (void)confirmAction{
    if (self.touchRenewalFeeAction) {
        self.touchRenewalFeeAction();
    }
    [self dismissWithAnimation:YES];
}

// 取消
- (void)cancelAction{
    [self dismissWithAnimation:YES];
}


#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
//    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    // 创建UI
    [self initUI];
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
