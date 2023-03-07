//
//  USSetValueAlterView.m
//  LocalDebug
//
//  Created by CBQ on 2021/4/29.
//

#import "USSetValueAlterView.h"

@implementation USSetValueAlterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self rightBtnCLick];
    }
    
    return self;
}
- (void)rightBtnCLick{
 
    
    self.backgroundColor = COLOR(0, 0, 0, 0.2);
    UITapGestureRecognizer *bgtapg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgtapclick)];
    [self addGestureRecognizer:bgtapg];
    
    UIView *whitVie = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 120*NOW_SIZE, (kScreenHeight-kNavBarHeight)/2 - 160*HEIGHT_SIZE, 240*NOW_SIZE, 170*HEIGHT_SIZE)];
    whitVie.backgroundColor = WhiteColor;
    whitVie.layer.cornerRadius = 10*HEIGHT_SIZE;
    whitVie.layer.masksToBounds = YES;
   
    [self addSubview:whitVie];
    
    UILabel *templb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, whitVie.frame.size.width, 40*HEIGHT_SIZE)];
    templb.adjustsFontSizeToFitWidth = YES;
    templb.font = FontSize(14*HEIGHT_SIZE);
    templb.textColor = colorblack_51;
    templb.textAlignment = NSTextAlignmentCenter;
    [whitVie addSubview:templb];
    _titLB = templb;
    
    UILabel *fanweilb = [[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE,CGRectGetMaxY(templb.frame), whitVie.frame.size.width - 30*NOW_SIZE, 25*HEIGHT_SIZE)];
    fanweilb.adjustsFontSizeToFitWidth = YES;
    fanweilb.font = FontSize(12*HEIGHT_SIZE);
    fanweilb.textColor = colorblack_154;
//    fanweilb.textAlignment = NSTextAlignmentCenter;
    fanweilb.numberOfLines = 0;
    [whitVie addSubview:fanweilb];
    _fanweiLB = fanweilb;
    
    
    UITextField *temTF = [[UITextField alloc]initWithFrame:CGRectMake(15*NOW_SIZE, CGRectGetMaxY(fanweilb.frame)+10*HEIGHT_SIZE, whitVie.frame.size.width - 30*NOW_SIZE - 15*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
    temTF.font = FontSize(14*HEIGHT_SIZE);
    temTF.layer.cornerRadius = 3*HEIGHT_SIZE;
    temTF.layer.masksToBounds = YES;
    temTF.layer.borderColor = colorblack_186.CGColor;
    temTF.layer.borderWidth = 0.3*HEIGHT_SIZE;
    temTF.tag = 1000;
    temTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [temTF becomeFirstResponder];
    [whitVie addSubview:temTF];
    _valueTF = temTF;
    
    UILabel *danweilb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(temTF.frame)+5*NOW_SIZE, CGRectGetMaxY(fanweilb.frame)+10*HEIGHT_SIZE, 15*NOW_SIZE, 40*HEIGHT_SIZE)];
    danweilb.adjustsFontSizeToFitWidth = YES;
    danweilb.font = FontSize(14*HEIGHT_SIZE);
    danweilb.textColor = colorblack_51;
    danweilb.textAlignment = NSTextAlignmentCenter;
    
    [whitVie addSubview:danweilb];
    _danweiLB = danweilb;
    
    UILabel *linelb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(danweilb.frame)+10*HEIGHT_SIZE, whitVie.frame.size.width, 0.3*HEIGHT_SIZE)];
    linelb.backgroundColor = colorblack_102;
    [whitVie addSubview:linelb];
    
    UIButton *canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(linelb.frame), whitVie.frame.size.width/2, 40*HEIGHT_SIZE)];
    [canbtn setTitle:root_cancel forState:UIControlStateNormal];
    [canbtn addTarget:self action:@selector(cancelclickBtn) forControlEvents:UIControlEventTouchUpInside];
    [canbtn setTitleColor:colorblack_51 forState:UIControlStateNormal];
    [whitVie addSubview:canbtn];
    
    UILabel *linelb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(canbtn.frame), CGRectGetMaxY(linelb.frame),0.3*NOW_SIZE,whitVie.frame.size.height - CGRectGetMaxY(linelb.frame))];
    linelb2.backgroundColor = colorblack_102;
    [whitVie addSubview:linelb2];

    UIButton *surebtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(linelb2.frame), CGRectGetMaxY(linelb.frame), whitVie.frame.size.width/2, 40*HEIGHT_SIZE)];
    [surebtn setTitle:root_OK forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(surebtnclickBtn) forControlEvents:UIControlEventTouchUpInside];
    [surebtn setTitleColor:colorblack_51 forState:UIControlStateNormal];
    [whitVie addSubview:surebtn];
    

 
}

- (void)bgtapclick{
    
    [self endEditing:YES];
}
- (void)cancelclickBtn{
    [self endEditing:YES];

    self.hidden = YES;
}

- (void)surebtnclickBtn{
    [self endEditing:YES];

    self.hidden = YES;

    self.valueBlock(_valueTF.text);
}

- (void)showView{
    
    self.hidden = NO;

}
- (void)valueSet:(NSString *)value fanwei:(NSString *)fanwei danwei:(NSString *)danwei titleStr:(NSString *)titleStr{
    [_valueTF becomeFirstResponder];
    if (kStringIsEmpty(titleStr)) {
        _titLB.hidden = YES;
    }else{
        _titLB.hidden = NO;

        _titLB.text = titleStr;
    }
    
    if (kStringIsEmpty(fanwei)) {
        _fanweiLB.hidden = YES;
    }else{
        _fanweiLB.hidden = NO;

        _fanweiLB.text = fanwei;
    }
    
    if (kStringIsEmpty(danwei)) {
        _danweiLB.hidden = YES;
        _valueTF.xmg_width = 240*NOW_SIZE - 30*NOW_SIZE - 15*HEIGHT_SIZE+15*NOW_SIZE;
    }else{
        _danweiLB.hidden = NO;

        _danweiLB.text = danwei;
        _valueTF.xmg_width = 240*NOW_SIZE - 30*NOW_SIZE - 15*HEIGHT_SIZE;

    }
    if (kStringIsEmpty(fanwei) && kStringIsEmpty(danwei)) {
        _valueTF.xmg_y = CGRectGetMaxY(_titLB.frame)+20*HEIGHT_SIZE;
    }else{
        _valueTF.xmg_y = CGRectGetMaxY(_fanweiLB.frame)+10*HEIGHT_SIZE;

        
    }
    if (kStringIsEmpty(value)) {
        _valueTF.text = @"";
    }else{
        
        _valueTF.text = value;
    }
}

@end
