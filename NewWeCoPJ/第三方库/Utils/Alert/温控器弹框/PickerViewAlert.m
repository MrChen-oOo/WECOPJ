//
//  PickerViewAlert.m
 
//
//  Created by BQ123 on 2018/7/6.
//  Copyright © 2018年 hshao. All rights reserved.
//

#import "PickerViewAlert.h"

@interface PickerViewAlert ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSInteger leftNumber;
    NSInteger rightNumber;
}

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIView *viewBG;

@property (nonatomic,assign) NSInteger pickerIndex;

@property (nonatomic,assign) BOOL isDayType; // 一个时间选择， 一个天数选择

@property (nonatomic,strong) UILabel *tipLabel;

@end

@implementation PickerViewAlert

- (instancetype)initWithType:(NSString *)type{
    
    if (self = [super init]) {
        
        if ([type isEqualToString:@"day"]) {
            self.isDayType = YES;
        }else{
            self.isDayType = NO;
        }
        
        [self initUIView];
    }
    return self;
}

- (void)initUIView{
    
    self.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
    [self setUserInteractionEnabled:YES];

    self.viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 240)];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBG];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 50, 35)];
    cancelBtn.titleLabel.font = FontSize(16*XLscaleW);
    [cancelBtn setTitle:root_cancel forState:UIControlStateNormal];
    [cancelBtn setTitleColor:textColorGray forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBG addSubview:cancelBtn];
    
    UIButton *enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 70, 15, 50, 35)];
    enterBtn.titleLabel.font = FontSize(16*XLscaleW);
    [enterBtn setTitle:root_OK forState:UIControlStateNormal];
    [enterBtn setTitleColor:mainColor forState:UIControlStateNormal];
    [enterBtn addTarget:self action:@selector(tounchEnter) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBG addSubview:enterBtn];
    
    self.tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 80, 17, 160, 30)];
    self.tipLabel.font = FontSize(XLscaleW*16);
    self.tipLabel.textColor = mainColor;
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.viewBG addSubview:self.tipLabel];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(ScreenWidth/2-100, 40, 200, 200)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    [self.viewBG addSubview:self.pickerView];
    [self sendSubviewToBack:self.viewBG];
    
    leftNumber = 0;
    rightNumber = 0;
}

// 返回有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// 返回第component列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.isDayType) {
        return 10;
    }else{
        if (component == 0) {
            return 24;
        }else{
            return 60;
        }
    }
}

//返回第component列高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}
// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.isDayType) {
        return [NSString stringWithFormat:@"%ld",(long)row];
    }else{
        if (component == 0) {
            return [NSString stringWithFormat:@"%ld",(long)row];
        }else{
            return [NSString stringWithFormat:@"%ld",(long)row];
        }
    }
}

// 监听UIPickerView选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component == 0) {
        leftNumber = row;
    }else{
        rightNumber = row;
    }
    if (self.isDayType) {
        self.tipLabel.text = [NSString stringWithFormat:@"%ld%ld %@",(long)leftNumber,(long)rightNumber,HEM_tian];
    }else{
        self.tipLabel.text = [NSString stringWithFormat:@"%ld : %ld",(long)leftNumber,(long)rightNumber];
    }
}

-(void)show
{
    [self showWithIndex:0];
}

-(void)hide
{
    [UIView animateWithDuration:0.4 animations:^{
        self.viewBG.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 240);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    self.touchCancelBtn();
}

-(void)showWithIndex:(NSInteger)index
{
//    if (index<10) {
//        [self.pickerView selectRow:index inComponent:0 animated:YES];
//        self.pickerIndex=index;
//    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        self.viewBG.frame = CGRectMake(0, ScreenHeight-240, ScreenWidth, 240);
    }];
}

- (void)tounchEnter{
    if (self.touchEnterBlock) {
        if (self.isDayType) {
            NSString *time = [NSString stringWithFormat:@"%ld%ld",leftNumber,rightNumber];
            NSInteger time2 = [time integerValue];
            self.touchEnterBlock(time2);
        }else{
            self.touchEnterBlock(leftNumber*60 + rightNumber);
        }
    }
    [self hide];
}



@end
