#import "RedxCollectorShowAlertView.h"
@implementation RedxCollectorShowAlertView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAlerterUI];
    }
    return self;
}
- (void)createAlerterUI{
    UITapGestureRecognizer *pastapg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(paswbgClick)];
    [self addGestureRecognizer:pastapg];
    UIView *pasvie = [[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE, self.frame.size.height/2 - 160*HEIGHT_SIZE*2/3-kNavBarHeight, kScreenWidth - 60*NOW_SIZE, 160*HEIGHT_SIZE)];
    pasvie.backgroundColor = WhiteColor;
    pasvie.layer.cornerRadius = 10*HEIGHT_SIZE;
    pasvie.layer.masksToBounds = YES;
    [self addSubview:pasvie];
    UILabel *pastips1lb = [[UILabel alloc]initWithFrame:CGRectMake(0,5*HEIGHT_SIZE,pasvie.frame.size.width, 40*HEIGHT_SIZE)];
    pastips1lb.adjustsFontSizeToFitWidth = YES;
    pastips1lb.font = FontSize(14*HEIGHT_SIZE);
    pastips1lb.textColor = colorblack_51;
    pastips1lb.textAlignment = NSTextAlignmentCenter;
    [pasvie addSubview:pastips1lb];
    _titleLB = pastips1lb;
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pastips1lb.frame)+5*HEIGHT_SIZE, pasvie.frame.size.width, 1*HEIGHT_SIZE)];
    linev.backgroundColor = backgroundNewColor;
    [pasvie addSubview:linev];
    UITextField *pastf = [[UITextField alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(linev.frame)+5*HEIGHT_SIZE, pasvie.frame.size.width - 20*NOW_SIZE, 40*HEIGHT_SIZE)];
    pastf.adjustsFontSizeToFitWidth = YES;
    pastf.layer.borderColor = colorblack_186.CGColor;
    pastf.layer.borderWidth = 0.6*NOW_SIZE;
    pastf.layer.cornerRadius = 4*HEIGHT_SIZE;
    pastf.layer.masksToBounds = YES;
    pastf.textAlignment = NSTextAlignmentCenter;
    [pasvie addSubview:pastf];
    _contenTF = pastf;
    UIButton *unlockbtn0 = [[UIButton alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(pastf.frame)+20*HEIGHT_SIZE, pasvie.frame.size.width/2, pasvie.frame.size.height - CGRectGetMaxY(pastf.frame)-20*HEIGHT_SIZE)];
    [unlockbtn0 setTitle:root_cancel forState:UIControlStateNormal];
    [unlockbtn0 setTitleColor:buttonColor forState:UIControlStateNormal];
    unlockbtn0.layer.borderColor = backgroundNewColor.CGColor;
    unlockbtn0.layer.borderWidth = 0.8*HEIGHT_SIZE;
    unlockbtn0.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    [unlockbtn0 addTarget:self action:@selector(unlockbtn0Click) forControlEvents:UIControlEventTouchUpInside];
    [pasvie addSubview:unlockbtn0];
    UIButton *unlockbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(unlockbtn0.frame),CGRectGetMaxY(pastf.frame)+20*HEIGHT_SIZE, pasvie.frame.size.width/2, pasvie.frame.size.height - CGRectGetMaxY(pastf.frame)-20*HEIGHT_SIZE)];
    [unlockbtn setTitle:root_OK forState:UIControlStateNormal];
    [unlockbtn setTitleColor:buttonColor forState:UIControlStateNormal];
    unlockbtn.layer.borderColor = backgroundNewColor.CGColor;
    unlockbtn.layer.borderWidth = 0.8*HEIGHT_SIZE;
    unlockbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    [unlockbtn addTarget:self action:@selector(unlockbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pasvie addSubview:unlockbtn];
}
- (void)paswbgClick{
    [self endEditing:YES];
}
- (void)unlockbtn0Click{
    self.hidden = YES;
    [self endEditing:YES];
}
- (void)unlockbtnClick{
    self.backBlock(_contenTF.text);
    [self endEditing:YES];
    self.hidden = YES;
}
- (void)setViewValue:(NSString *)contenStr title:(NSString *)titleStr{
    _titleLB.text = titleStr;
    _contenTF.text = contenStr;
}
@end
