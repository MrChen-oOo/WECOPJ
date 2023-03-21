//
//  InpuPopView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/17.
//

#import "InpuPopView.h"

@interface InpuPopView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hiddenLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterTextFiled;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (weak, nonatomic) IBOutlet UITextField *numTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;

@property (nonatomic,strong) INVSettingViewModel *invVM;
@property (nonatomic, strong) NSString * paramStr;
@property (nonatomic, strong) NSString * textStr;
@end

@implementation InpuPopView

-(instancetype)initWithViewModel:(INVSettingViewModel *)viewModel {
    self = [[NSBundle mainBundle] loadNibNamed:@"InpuPopView" owner:nil options:nil].lastObject;
    if (self) {
        self.invVM = viewModel;
        self.enterTextFiled.delegate = self;
        self.numTextFiled.delegate = self;
        //键盘将要显示时候的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUP:) name:UIKeyboardWillShowNotification object:nil];
        //键盘将要结束时候的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDOWN:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)isHaveUnitWith:(BOOL)isHave numStr:(nonnull NSString *)numStr paramsStr:(nonnull NSString *)paramsStr index:(nonnull NSIndexPath *)indexPath title:(nonnull NSString *)titeleStr{
    self.hiddenView.hidden = isHave;
    self.enterTextFiled.text = numStr;
    self.numTextFiled.text = numStr;
    self.paramStr = paramsStr;
    self.hiddenLabel.hidden = numStr.length == 0 ? NO : YES;
    
    if(isHave == YES) {
        if(indexPath.section == 1 && indexPath.row == 6) {
            self.unitLabel.text =  @"   ";
            self.rangeLabel.text = @"( 1000 ~30000 )";
        } else if (indexPath.section == 2) {
            self.unitLabel.text = @" % ";
            self.rangeLabel.text = @"( 10 ~90%) ";
        } else if (indexPath.section == 4) {
            self.unitLabel.text = @" A ";
            self.rangeLabel.text = @"(0 ~1000A)";
        } else if (indexPath.section == 5) {
            if (indexPath.row == 0 || indexPath.row == 1){
                self.unitLabel.text = @" % ";
                self.rangeLabel.text = @"( 0 ~100%)";
            } else if (indexPath.row == 2){
                self.unitLabel.text = @" A ";
                self.rangeLabel.text = @"( 0 ~200A )";
            } else if (indexPath.row == 11){
                self.unitLabel.text = @" W ";
                self.rangeLabel.text = @"( 0 ~30000W )";
            } else {
                self.unitLabel.text = @" h ";
                self.rangeLabel.text = @"( 0 ~240H )";
            }
        } else if (indexPath.section == 0) {
            if (indexPath.row == 2) {
                self.unitLabel.text =  @" A ";
                self.rangeLabel.text = @"( 1 ~190A )";
            } else if(indexPath.row == 4) {
                self.unitLabel.text =  @"   ";
                self.rangeLabel.text = @"( 1 ~99 )";
            } else{
                self.unitLabel.text = @" % ";
                self.rangeLabel.text = @"( 0 ~100% )";
            }
        }
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.hiddenLabel.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0 ){
        self.hiddenLabel.hidden = NO;
    } else {
        self.hiddenLabel.hidden = YES;
    }
    self.paramStr = textField.text;
}

// 清除输入框
- (IBAction)deleteTextAction:(UIButton *)sender {
    self.hiddenLabel.hidden = NO;
    self.enterTextFiled.text = @"";
}

// 确定
- (IBAction)determineAction:(UIButton *)sender {
    NSDictionary *dic = @{@"deviceSn":self.invVM.deviceSnStr,@"code":self.paramStr,@"value":self.hiddenView.hidden == NO ? self.enterTextFiled.text : self.numTextFiled.text} ;
    self.changeDataBlock ? self.changeDataBlock(dic) : nil;
    [self endEditing:YES];
}

// 返回
- (IBAction)cancelAction:(UIButton *)sender {
    self.hidden = YES;
    [self endEditing:YES];

}
- (IBAction)keybordDisappearAction:(UIButton *)sender {
    self.hidden = YES;
    [self endEditing:YES];
}


//键盘高度
//键盘自适应方法
- (void)keyboardUP:(NSNotification *)sender{
    NSDictionary *info = sender.userInfo;
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //取出键盘位置大小信息
    CGRect keyboardBounds = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //记录Y轴变化
    CGFloat keyboardHeight = keyboardBounds.size.height;
    //上移动画options
    UIViewKeyframeAnimationOptions options = (UIViewKeyframeAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
    } completion:nil];
}
-(void)keyboardDOWN:(NSNotification *)sender{
    NSDictionary *info = sender.userInfo;
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //下移动画options
    UIViewKeyframeAnimationOptions options = (UIViewAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    //回复动画
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}
//最后释放通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
