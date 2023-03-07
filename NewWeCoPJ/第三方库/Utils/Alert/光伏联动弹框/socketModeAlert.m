//
//  socketModeAlert.m
 
//
//  Created by BQ123 on 2019/3/13.
//  Copyright © 2019 qwl. All rights reserved.
//

#import "socketModeAlert.h"

@implementation socketModeAlert

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        // 背景遮罩图层
        [self addSubview:self.backgroundView];
        // 弹出视图
        [self addSubview:self.alertView];
        // 添加右边确定按钮
        [self.alertView addSubview:self.rightBtn];
    }
    
    return self;
}

#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.20];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-(kTopViewHeight-kDatePicHeight2)*HEIGHT_SIZE, ScreenWidth, (kTopViewHeight+kDatePicHeight2)*HEIGHT_SIZE)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

#pragma mark - 右边按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(ScreenWidth - 35*HEIGHT_SIZE, 10*HEIGHT_SIZE, 25*HEIGHT_SIZE, 25*HEIGHT_SIZE);
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"solar_delete"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark -- UIView
// 创建头部view
- (void)setUpUIView{
    float labelH = 30*HEIGHT_SIZE;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/6, 5*HEIGHT_SIZE, ScreenWidth*2/3, labelH)];
    titleLabel.textColor = colorblack_51;
    titleLabel.text = root_SmartHome_423;
//    titleLabel.font = [UIFont boldSystemFontOfSize:16.0*HEIGHT_SIZE];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.alertView addSubview:titleLabel];
    
    float imgW = 40*HEIGHT_SIZE;
    UIImageView *imgDev = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-imgW)/2, CGRectGetMaxY(titleLabel.frame)+20*HEIGHT_SIZE, imgW, imgW)];
    imgDev.image = IMAGE(@"socket_off");
    [self.alertView addSubview:imgDev];
    
    UILabel *lblTips1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgDev.frame)+10*HEIGHT_SIZE, ScreenWidth, labelH)];
    lblTips1.textColor = colorblack_51;
    lblTips1.text = root_SmartHome_503;
    lblTips1.font = FontSize([NSString getFontWithText:lblTips1.text size:lblTips1.xmg_size currentFont:14*HEIGHT_SIZE]);
    lblTips1.textAlignment = NSTextAlignmentCenter;
    lblTips1.numberOfLines = 0;
    [self.alertView addSubview:lblTips1];
    
    UILabel *lblTips2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lblTips1.frame), ScreenWidth, labelH+12*HEIGHT_SIZE)];
    lblTips2.textColor = colorblack_154;
    lblTips2.text = root_SmartHome_411;
    lblTips2.font = [UIFont systemFontOfSize:12.0*HEIGHT_SIZE];
    lblTips2.numberOfLines = 0;
    lblTips2.textAlignment = NSTextAlignmentLeft;
    lblTips2.adjustsFontSizeToFitWidth = YES;
    [self.alertView addSubview:lblTips2];
    
    UIButton *btnSet = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-250*NOW_SIZE)/2, CGRectGetMaxY(lblTips2.frame)+30*HEIGHT_SIZE, 250*NOW_SIZE, 45*HEIGHT_SIZE)];
    [btnSet setTitle:root_SmartHome_505 forState:UIControlStateNormal];
    [btnSet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btnSet setBackgroundColor:mainColor];
//    [btnSet setBackgroundImage:IMAGE(@"btn") forState:UIControlStateNormal];
    [btnSet setBackgroundColor:mainColor];
    btnSet.titleLabel.font = [UIFont boldSystemFontOfSize:14*HEIGHT_SIZE];
    XLViewBorderRadius(btnSet, 22*HEIGHT_SIZE, 0, kClearColor);
    [btnSet addTarget:self action:@selector(btnGoToSettingAction) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:btnSet];
    
}

// 进入设置
- (void)btnGoToSettingAction{
    if (self.touchSettingButton) {
        self.touchSettingButton();
    }
    [self clickLeftBtn];
}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:NO];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    [self dismissWithAnimation:NO];
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    [self setUpUIView];// 创建头部view
    
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = ScreenHeight;
        self.alertView.frame = rect;
        
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= (kDatePicHeight2 + kTopViewHeight)*HEIGHT_SIZE;
            self.alertView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += (kDatePicHeight2 + kTopViewHeight)*HEIGHT_SIZE;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.rightBtn removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.rightBtn = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
}



@end
