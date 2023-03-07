//
//  ProgressLineView.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/28.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "ProgressLineView.h"

@interface ProgressLineView ()

@property (strong,nonatomic) UIView *firstView;
@property (strong,nonatomic) UIView *secondView;
@property (strong,nonatomic) UILabel *progressLabel;
@property (strong,nonatomic) UILabel *progressLabel2;

@end

@implementation ProgressLineView

- (UIView *)firstView{
    if (_firstView == nil){
        UIView *fView = [[UIView alloc]init];
        fView.backgroundColor = _progressBackGroundColor;
        fView.layer.masksToBounds = YES;
        fView.layer.cornerRadius = _progressCornerRadius;
        [self addSubview:fView];
        _firstView = fView;
    }
    return _firstView;
}

- (UIView *)secondView{
    if (_secondView == nil){
        UIView *sView = [[UIView alloc]init];
        sView.backgroundColor = _progressTintColor;
        sView.layer.masksToBounds = YES;
        sView.layer.cornerRadius = _progressCornerRadius;
        [self.firstView addSubview:sView];
        _secondView = sView;
    }
    return _secondView;
}

- (UILabel *)progressLabel{
    if (_progressLabel == nil){
        UILabel *lb = [[UILabel alloc]init];
        lb.textAlignment = NSTextAlignmentLeft;
        CGFloat value = _progressValue * 100;
        NSString *valueStr = [[NSString stringWithFormat:@"%.1f",value]stringByAppendingString:@"%"];
        lb.text = valueStr;
        lb.textColor = [UIColor whiteColor];
        lb.font = FontSize(self.frame.size.height-5);
        _progressLabel = lb;
        [self insertSubview:lb aboveSubview:_secondView];
    }
    return _progressLabel;
}

- (UILabel *)progressLabel2{
    if (_progressLabel2 == nil){
        UILabel *lb = [[UILabel alloc]init];
        lb.textAlignment = NSTextAlignmentRight;
        CGFloat value = (1 - _progressValue) * 100;
        NSString *valueStr = [[NSString stringWithFormat:@"%.1f",value]stringByAppendingString:@"%"];
        lb.text = valueStr;
        lb.textColor = [UIColor whiteColor];
        lb.font = FontSize(self.frame.size.height-5);
        _progressLabel2 = lb;
        [self insertSubview:lb aboveSubview:_secondView];
    }
    return _progressLabel2;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.secondView.frame = CGRectMake(0, 0, self.frame.size.width * _progressValue, self.frame.size.height);
    self.firstView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (!self.isBeing) {
        self.firstView.backgroundColor = COLOR(236, 239, 241, 1);
    }
    if (self.isBeing) {
        self.progressLabel.frame = CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height);
        self.progressLabel2.frame = CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height);
    }
}

#pragma mark - set&&get
- (void)setProgressBackGroundColor:(UIColor *)progressBackGroundColor{
    
    _progressBackGroundColor = progressBackGroundColor;
}

- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor{
    self.layer.borderColor = progressTintColor.CGColor;
    
    _progressTintColor = progressTintColor;
}


- (void)setProgressCornerRadius:(NSInteger)progressCornerRadius{
    
    _progressCornerRadius = progressCornerRadius;
}

- (void)setProgressBorderWidth:(NSInteger)progressBorderWidth{
    self.layer.borderWidth = progressBorderWidth;
    _progressBorderWidth = progressBorderWidth;
}

@end
