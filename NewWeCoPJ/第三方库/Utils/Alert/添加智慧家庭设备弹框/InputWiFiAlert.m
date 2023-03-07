//
//  InputWiFiAlert.m
 
//
//  Created by BQ123 on 2018/6/21.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import "InputWiFiAlert.h"

#define bouncedView_Width 300
#define bouncedView_height 260

#define dismissBtn_Windth 24
#define dismissBtn_height dismissBtn_Windth

#define TagValue  1000
#define AlertTime 0.25 //弹出动画时间

@interface InputWiFiAlert ()

@property (nonatomic, strong)UIView *bouncedView;

@property (nonatomic, strong)UILabel *WiFiNameLabel;

@property (nonatomic, strong)UITextField *textField;

@end

@implementation InputWiFiAlert

- (instancetype)init{
    
    if (self = [super init]) {

        [self initUI];
        
    }
    return self;
}

- (void)initUI{
    
    self.frame = KEYWINDOW.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    self.bouncedView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_Width-bouncedView_Width)/2, (SCREEN_Height-bouncedView_height)/2, bouncedView_Width, bouncedView_height)];
    self.bouncedView.backgroundColor = [UIColor whiteColor];
    XLViewBorderRadius(self.bouncedView, 10, 0, kClearColor);
    [self addSubview:self.bouncedView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, bouncedView_Width-100, 40)];
    titleLab.text = HEM_shurulianjiedeWiFimima;
//    titleLab.font = FontSize(20*XLscaleW);
    titleLab.adjustsFontSizeToFitWidth = YES;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.numberOfLines = 0;
    [self.bouncedView addSubview:titleLab];
    
    UIImageView *wifiImageV = [[UIImageView alloc]initWithFrame:CGRectMake(25, 83, 16, 12)];
    wifiImageV.image = [UIImage imageNamed:@"wifi@3"];
    [self.bouncedView addSubview:wifiImageV];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(45,70, 80, 40)];
    tipLabel.text = HEM_dangqianlianjieWiFi;
    tipLabel.textColor = textColorGray;
    tipLabel.font = FontSize(12);
    tipLabel.adjustsFontSizeToFitWidth = YES;
    tipLabel.numberOfLines = 0;
    [self.bouncedView addSubview:tipLabel];
    
    UILabel *WiFiNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 70, bouncedView_Width-130-20, 40)];
    WiFiNameLabel.textColor = textColorGray;
    WiFiNameLabel.textAlignment = NSTextAlignmentCenter;
    WiFiNameLabel.font = FontSize(12);
    WiFiNameLabel.adjustsFontSizeToFitWidth = YES;
    WiFiNameLabel.numberOfLines = 0;
    [self.bouncedView addSubview:WiFiNameLabel];
    self.WiFiNameLabel = WiFiNameLabel;
    
    UIButton *replaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    replaceBtn.frame = CGRectMake(220, 80, 60, 20);
    replaceBtn.titleLabel.font = FontSize(12*XLscaleW);
    replaceBtn.titleLabel.textColor = mainColor;
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:root_WO_dianji_huoqu];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:mainColor range:titleRange];
    [replaceBtn setAttributedTitle:title forState:UIControlStateNormal];
//    [self.bouncedView addSubview:replaceBtn];
    [replaceBtn addTarget:self action:@selector(replaceWiFi) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 130, bouncedView_Width-40, 40)];
    textField.backgroundColor = colorGary;
    XLViewBorderRadius(textField, 5, 0, kClearColor);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:HEM_shuruWiFimima attributes:@{NSFontAttributeName:FontSize(13*XLscaleW), NSParagraphStyleAttributeName:style}];
    textField.attributedPlaceholder = attri;
           [textField setMinimumFontSize:textFiedMinFont];
    textField.textAlignment = NSTextAlignmentCenter;
//    textField.secureTextEntry = YES;
    textField.font = FontSize(13*XLscaleW);
    [self.bouncedView addSubview:textField];
    self.textField = textField;
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, bouncedView_height-40, bouncedView_Width/2-1, 40)];
    [cancelBtn setTitle:root_cancel forState:UIControlStateNormal];
    [cancelBtn setTitleColor:textColorGray forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:colorGary];
    [self.bouncedView addSubview:cancelBtn];
    
    UIButton *enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(bouncedView_Width/2, bouncedView_height-40, bouncedView_Width/2, 40)];
    [enterBtn setTitle:root_OK forState:UIControlStateNormal];
    [enterBtn setTitleColor:mainColor forState:UIControlStateNormal];
    [enterBtn addTarget:self action:@selector(tounchEnter) forControlEvents:UIControlEventTouchUpInside];
    [enterBtn setBackgroundColor:colorGary];
    [self.bouncedView addSubview:enterBtn];
    
}

- (void)tounchEnter{
    
//    if (self.textField.text.length == 0) {
//        [self showToastViewWithTitle: @"密码不能为空!"];
//        return;
//    }
    
    if (self.touchEnterBlock) {
        self.touchEnterBlock(self.textField.text);
    }
    
    [self hide];
}

- (void)replaceWiFi{
    
    if (self.replaceWiFiBlock) {
        self.replaceWiFiBlock();
    }
    
}

- (void)show {
    
    UIView *oldView = [KEYWINDOW viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    
    self.tag = TagValue;
    [KEYWINDOW addSubview:self] ;
    
    self.alpha = 0;
    self.bouncedView.alpha = 0;
    self.bouncedView.transform = CGAffineTransformScale(self.bouncedView.transform,0.1,0.1);
    [UIView animateWithDuration:AlertTime animations:^{
        self.alpha = 1;
        self.bouncedView.alpha = 1;
        self.bouncedView.transform = CGAffineTransformIdentity;
    }];
    
}

- (void)hide {
    
    self.alpha = 1;
    self.bouncedView.alpha = 1;
    [UIView animateWithDuration:AlertTime animations:^{
        self.alpha = 0;
        self.bouncedView.alpha = 1;
        self.bouncedView.transform = CGAffineTransformScale(self.bouncedView.transform,0.1,0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEYWINDOW animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

- (void)setWifiName:(NSString *)wifiName{
    
    _wifiName = wifiName;
    
    self.WiFiNameLabel.text = wifiName;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [KEYWINDOW endEditing:YES];
}

@end
