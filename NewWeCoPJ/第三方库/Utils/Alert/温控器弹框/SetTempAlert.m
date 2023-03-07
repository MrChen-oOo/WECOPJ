//
//  SetTempAlert.m
 
//
//  Created by BQ123 on 2018/7/6.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import "SetTempAlert.h"

#define bouncedView_Width 300
#define bouncedView_height 260

#define dismissBtn_Windth 24
#define dismissBtn_height dismissBtn_Windth

#define TagValue  1999
#define AlertTime 0.25 //弹出动画时间

@interface SetTempAlert ()<UIScrollViewDelegate>{
    
}

@property (nonatomic, strong)UIView *bouncedView;

@property (nonatomic, strong)UIScrollView *tempScrollView;

@property (nonatomic, assign)CGFloat setTemperature;
@property (nonatomic, assign) CGFloat starTem;
@property (nonatomic, assign) CGFloat endTem;
@end

@implementation SetTempAlert


- (instancetype)initWithCurrentTemp:(CGFloat)starTemp endTemp:(CGFloat)endtemp{
    
    if (self = [super init]) {
        
        _starTem = starTemp;
        _endTem = endtemp;
        
        [self initUIView];
        
    }
    
    return self;
}



- (void)initUIView{
    
    self.frame = KEYWINDOW.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    self.bouncedView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_Width-bouncedView_Width)/2, (SCREEN_Height-bouncedView_height)/2, bouncedView_Width, bouncedView_height)];
    self.bouncedView.backgroundColor = [UIColor whiteColor];
    XLViewBorderRadius(self.bouncedView, 10, 0, kClearColor);
    [self addSubview:self.bouncedView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, bouncedView_Width-100, 40)];
    titleLab.text = HEM_shezhiwendu;
    titleLab.font = FontSize(20);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.bouncedView addSubview:titleLab];
    
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 110, 30, 40)];
    subLabel.text = @"°C";
    subLabel.font = FontSize(25);
    subLabel.textColor = mainColor;
    subLabel.textAlignment = NSTextAlignmentCenter;
    [self.bouncedView addSubview:subLabel];
    
    self.tempScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(95, 80, 105, 100)];
    self.tempScrollView.delegate = self;
    self.tempScrollView.contentSize = CGSizeMake(0, ((_endTem - _starTem)*2 + 1)*100);
//    self.tempScrollView.pagingEnabled = YES;
    self.tempScrollView.showsVerticalScrollIndicator = NO;
    [self.bouncedView addSubview:self.tempScrollView];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(95, self.tempScrollView.frame.origin.y + 1, 105, 0.8)];
    linev.backgroundColor = [UIColor lightGrayColor];
    [self.bouncedView addSubview:linev];
    
    UIView *linev2 = [[UIView alloc]initWithFrame:CGRectMake(95,CGRectGetMaxY(self.tempScrollView.frame), 105, 0.8)];
    linev2.backgroundColor = [UIColor lightGrayColor];
    [self.bouncedView addSubview:linev2];
    
  
    self.setTemperature = _starTem;

    
    for (float i = _starTem; i <= _endTem; i += 0.5) {
        UILabel *numberLab = [[UILabel alloc]init];
        numberLab.textColor = mainColor;
        numberLab.text = [NSString stringWithFormat:@"%.1f", i];
        numberLab.font = FontSize(50);
        numberLab.textAlignment = NSTextAlignmentCenter;
        numberLab.adjustsFontSizeToFitWidth = YES;
        numberLab.frame = CGRectMake(0, 100 * (i-_starTem)*2, 100, 100);
        [self.tempScrollView addSubview:numberLab];
    }
    
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

- (void)tempNowValueSet:(CGFloat)tempValue{
    self.setTemperature = tempValue;
    
    CGFloat cont_y = (tempValue - _starTem)*2*100;
    
    [self.tempScrollView setContentOffset:CGPointMake(0, cont_y)];
    
}


// 滑动减速,将停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat scrollview_y = scrollView.contentOffset.y/100;
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, roundf(scrollview_y)*100);
    }];
    self.setTemperature = (CGFloat)scrollView.contentOffset.y/100 * 0.5 + _starTem;
    
}


- (void)tounchEnter{
    
    NSLog(@"设置的温度为：%f", self.setTemperature);
    if (self.touchEnterBlock) {
        self.touchEnterBlock(self.setTemperature);
    }
    [self hide];
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

@end
