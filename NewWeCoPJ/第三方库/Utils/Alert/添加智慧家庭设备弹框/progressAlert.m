//
//  progressAlert.m
 
//
//  Created by BQ123 on 2018/6/22.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import "progressAlert.h"

#define bouncedView_Width 300
#define bouncedView_height 260

#define TagValue  1002
#define AlertTime 0.25 //弹出动画时间

@interface progressAlert ()

@property (nonatomic, strong) UIView *bouncedView;

@property (nonatomic, strong) UILabel *progressLabel;

@end

@implementation progressAlert

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
    titleLab.text = HEM_lianjiezhong;
    titleLab.font = FontSize(20*XLscaleW);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.bouncedView addSubview:titleLab];
    
    UILabel *progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 80, 110, 100)];
    progressLabel.text = @"100";
    progressLabel.font = FontSize(70*XLscaleW);
    progressLabel.adjustsFontSizeToFitWidth = YES;
    progressLabel.textColor = mainColor;
    progressLabel.textAlignment = NSTextAlignmentCenter;
    [self.bouncedView addSubview:progressLabel];
    self.progressLabel = progressLabel;
    
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 110, 30, 40)];
    subLabel.text = @"%";
    subLabel.font = FontSize(25*XLscaleW);
    subLabel.textColor = mainColor;
    subLabel.textAlignment = NSTextAlignmentCenter;
    [self.bouncedView addSubview:subLabel];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, bouncedView_height-40, bouncedView_Width, 40)];
    [cancelBtn setTitle:root_cancel forState:UIControlStateNormal];
    [cancelBtn setTitleColor:textColorGray forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:colorGary];
    [self.bouncedView addSubview:cancelBtn];
    
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

- (void)setProgress:(NSInteger)progress{
    
    _progress = progress;
    
    if (_progress == 100) {
        __block NSInteger currentprogress = [self.progressLabel.text integerValue];
        [NSTimer scheduledTimerWithTimeInterval:0.01f repeats:YES block:^(NSTimer * _Nonnull timer) {
            currentprogress++;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressLabel.text = [NSString stringWithFormat:@"%ld",currentprogress];
            });
            if (currentprogress == 100) {
                [timer invalidate];
            }
        }];
    }else{
        self.progressLabel.text = [NSString stringWithFormat:@"%ld",progress];
    }
    
}



@end
