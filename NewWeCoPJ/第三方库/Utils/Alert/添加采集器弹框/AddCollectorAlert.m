//
//  AddCollectorAlert.m
 
//
//  Created by BQ123 on 2019/2/26.
//  Copyright © 2019 tuolve. All rights reserved.
//

#import "AddCollectorAlert.h"// 添加电表采集器弹框

@interface AddCollectorAlert ()

@end

@implementation AddCollectorAlert

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        // 背景遮罩图层
        [self addSubview:self.backgroundView];
        // 弹出视图
        [self addSubview:self.alertView];
        // 设置弹出视图子视图
        // 添加顶部标题栏
        [self.alertView addSubview:self.topView];
        // 添加左边取消按钮
        [self.topView addSubview:self.leftBtn];
        // 添加右边确定按钮
        [self.topView addSubview:self.rightBtn];
        // 添加中间标题按钮
        [self.topView addSubview:self.titleLabel];
        // 添加分割线
        [self.topView addSubview:self.lineView];
        
        self.titleLabel.text = root_CJQ_tianjia;
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
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - kTopViewHeight - kDatePicHeight2, ScreenWidth, kTopViewHeight + kDatePicHeight2)];
        _alertView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:3/255.0 green:45/255.0 blue:59/255.0 alpha:1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide)];
        [_alertView addGestureRecognizer:tap];
        
        self.textSerialNumber = [[UITextField alloc] initWithFrame:CGRectMake(60, 50+kTopViewHeight, _alertView.frame.size.width-120, 45)];
        self.textSerialNumber.layer.masksToBounds = YES;
        self.textSerialNumber.layer.cornerRadius = 22;
        self.textSerialNumber.layer.borderColor = colorblack_222.CGColor;//[[UIColor colorWithRed:11/255.0 green:138/255.0 blue:224/255.0 alpha:1] CGColor];
        self.textSerialNumber.layer.borderWidth = 1;
//        self.textSerialNumber.placeholder = @"请输入采集器序列号";
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:root_caiJiQi attributes:
                                              @{NSForegroundColorAttributeName:colorblack_154,NSFontAttributeName:self.textSerialNumber.font}];
        self.textSerialNumber.attributedPlaceholder = attrString;
          [self.textSerialNumber setMinimumFontSize:textFiedMinFont];
        self.textSerialNumber.backgroundColor = [UIColor clearColor];
        self.textSerialNumber.textAlignment = NSTextAlignmentCenter;
        self.textSerialNumber.textColor = colorblack_102;//[UIColor colorWithRed:105/255.0 green:205/255.0 blue:253/255.0 alpha:1];
        [_alertView addSubview:self.textSerialNumber];
        
        UIButton *btnScan = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 280)/2.0, 150+kTopViewHeight, 280, 60)];
        [btnScan setTitleColor:colorblack_102 forState:UIControlStateNormal];
        [btnScan setTitle:root_erWeiMa forState:UIControlStateNormal];
        [btnScan setImage:[UIImage imageNamed:@"scan_code"] forState:UIControlStateNormal];
        btnScan.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [btnScan addTarget:self action:@selector(btnScanAction) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:btnScan];
        [btnScan setButtonShowType:RSButtonTypeRight space:5];
    }
    return _alertView;
}

#pragma mark - 顶部标题栏视图
- (UIView *)topView {
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, kTopViewHeight + 0.5)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

#pragma mark - 左边取消按钮
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(5, 8, 60, 28);
        _leftBtn.backgroundColor = [UIColor clearColor];
        _leftBtn.layer.cornerRadius = 14.0f;
        _leftBtn.layer.borderColor = [[UIColor colorWithRed:11/255.0 green:138/255.0 blue:224/255.0 alpha:1] CGColor];
        _leftBtn.layer.borderWidth = 1.0f;
        _leftBtn.layer.masksToBounds = YES;
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_leftBtn setTitleColor:[UIColor colorWithRed:11/255.0 green:138/255.0 blue:224/255.0 alpha:1] forState:UIControlStateNormal];
        [_leftBtn setTitle:root_cancel forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

#pragma mark - 右边确定按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(ScreenWidth - 65, 8, 60, 28);
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.layer.cornerRadius = 14.0f;
//        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundColor:mainColor];
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:root_OK forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark - 中间标题按钮
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, ScreenWidth - 130, kTopViewHeight)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:17.0f];
        _titleLabel.textColor = colorblack_51;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kTopViewHeight, ScreenWidth, 0.5)];
        _lineView.backgroundColor  = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:0.0];
        [self.alertView addSubview:_lineView];
    }
    return _lineView;
}

// 扫码
- (void)btnScanAction{
    [self dismissWithAnimation:NO];
    if (self.btnScanTouchAction) {
        self.btnScanTouchAction();
    }
}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:NO];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    [self dismissWithAnimation:NO];
    if (self.returnWithCollector) {
        self.returnWithCollector(self.textSerialNumber.text, self.textCheckCode.text);
    }
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
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
            rect.origin.y -= kDatePicHeight2 + kTopViewHeight;
            self.alertView.frame = rect;
        }];
    }
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideAction:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kDatePicHeight2 + kTopViewHeight;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.leftBtn removeFromSuperview];
        [self.rightBtn removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.lineView removeFromSuperview];
        [self.topView removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.leftBtn = nil;
        self.rightBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.topView = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

// 键盘隐藏
- (void)keyBoardHide{
    [self endEditing:YES];
}

// 键盘监听事件
- (void)keyboardShowAction:(NSNotification*)sender{
    
    // 弹框上浮
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y = ScreenHeight- kDatePicHeight2 - kTopViewHeight - 50*HEIGHT_SIZE;
        self.alertView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];

}
// 键盘监听事件
- (void)keyboardHideAction:(NSNotification*)sender{
    
    // 弹框上浮
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y = ScreenHeight- kDatePicHeight2 - kTopViewHeight;
        self.alertView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

@end
