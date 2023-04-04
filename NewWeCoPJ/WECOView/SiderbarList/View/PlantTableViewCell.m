//
//  PlantTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import "PlantTableViewCell.h"

@interface PlantTableViewCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeViewCenterLayer;

@property (weak, nonatomic) IBOutlet UILabel *powerLabel;
@property (weak, nonatomic) IBOutlet UITextField *powerTF;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *ReductionBtn;

@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UIButton *textfieldBtn;


@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) PlantSettingViewModel *planVM;

@end

@implementation PlantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.addBtn setTitle:@"" forState:(UIControlStateNormal)];
    [self.ReductionBtn setTitle:@"" forState:(UIControlStateNormal)];
    self.powerTF.delegate = self;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


// 点击提示框视图以外的其他地方时隐藏弹框
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.contentView endEditing:YES];
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath viewModel:(nonnull PlantSettingViewModel *)viewModel{
    self = [[NSBundle mainBundle] loadNibNamed:@"PlantTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.indexPath = indexPath;
        self.planVM = viewModel;
        self.lastView.hidden = YES;
        self.powerLabel.text = viewModel.isTimeSet == 1 ? @"Power" : @"Price";
        
        
        if (viewModel.deviceType == 1 || viewModel.isTimeSet == YES) {
            self.powerLabel.hidden = NO;
            self.powerTF.hidden = NO;
            self.textfieldBtn.hidden = viewModel.deviceType == 1 ? YES : NO;
            self.powerTF.userInteractionEnabled = viewModel.deviceType == 1 ? NO : YES;
            self.unitLabel.hidden = NO;
        } else {
            self.powerLabel.hidden = indexPath.row == 0 ? NO : YES;
            self.powerTF.hidden = indexPath.row == 0 ? NO : YES;
            self.textfieldBtn.hidden = indexPath.row == 0 ? NO : YES;
            self.powerTF.userInteractionEnabled = YES;
            self.unitLabel.hidden = indexPath.row == 0 ? NO : YES;
        }
        self.unitLabel.text = viewModel.isTimeSet == 1 ? @"kW" : @"$";
        
//        //键盘将要显示时候的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUP:) name:UIKeyboardWillShowNotification object:nil];
//        //键盘将要结束时候的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDOWN:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


// 逆变器赋值操作
-(void)setMessageWithChargArray:(NSArray *)optionArray dischargeArray:(NSArray *)dischargeArray {

    // UI
    if ((self.indexPath.section == 0 && self.indexPath.row == optionArray.count) || (self.indexPath.section == 1 && self.indexPath.row == dischargeArray.count)){
        self.bottomLayoutConstraint.constant = 10;
        self.lastView.hidden = NO;
    } else {
        self.topLayoutConstraint.constant = self.indexPath.row == 0 ? 10 : -10;
        self.timeViewCenterLayer.constant = self.indexPath.row == 0 ? 15 : 0;
        self.lastView.hidden = YES;
    }
    self.ReductionBtn.hidden = self.indexPath.row == 0 ? YES :NO;
    
    // 赋值
    NSString *timeStr;
    NSString *powerStr;
    if (self.indexPath.section == 0) {
        TimeModel *model = optionArray[self.indexPath.row];
        
        timeStr = model == nil ? @"00:00-00:00" :  [NSString stringWithFormat:@"%@:%@-%@:%@",model.startHour,model.startMinute,model.endHour,model.endMinute];
        powerStr = model == nil ? @"0" : [NSString stringWithFormat:@"%@",model.power];
    } else {
        TimeModel *model = dischargeArray[self.indexPath.row];
        timeStr = model == nil ? @"00:00-00:00" : [NSString stringWithFormat:@"%@:%@-%@:%@",model.startHour,model.startMinute,model.endHour,model.endMinute];
        powerStr = model == nil ? @"0" : [NSString stringWithFormat:@"%@",model.power];
    }
    self.timeLabel.text = timeStr;
    self.powerTF.text = powerStr;
}

// HMI赋值操作
- (void)setPriceMessageWithArray:(NSArray *)priceArray {
    // UI
    if (self.indexPath.row == priceArray.count) {
        self.bottomLayoutConstraint.constant = 10;
        self.lastView.hidden = NO;
    } else {
        self.topLayoutConstraint.constant = self.indexPath.row == 0 ? 10 : -10;
        self.timeViewCenterLayer.constant = self.indexPath.row == 0 ? 15 : 0;
        self.lastView.hidden = YES;
    }
    self.ReductionBtn.hidden = self.indexPath.row == 0 ? YES :NO;
    
    //赋值
    ElectricityPriceTimeModel *model = priceArray[self.indexPath.row];
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",model.start,model.end];
    self.powerTF.text = [NSString stringWithFormat:@"%@",self.planVM.priceArray[self.indexPath.section]];
}




#pragma mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.powerTF.text = [NSString stringWithFormat:@"%@",textField.text];
    
    if (self.planVM.isTimeSet == YES) {
        if (self.indexPath.section == 0) {
            self.planVM.batteryChargArray[self.indexPath.row].power = textField.text;
        } else {
            self.planVM.batteryDisChargArray[self.indexPath.row].power = textField.text;
        }
    } else {
        [self.planVM.priceArray replaceObjectAtIndex:self.indexPath.section withObject:textField.text];
    }
    self.textfieldBtn.hidden = NO;
//    if ([self.delegate respondsToSelector:@selector(didClickHiddenKeyboard)]) {
//        [self.delegate didClickHiddenKeyboard];
//    }
}


#pragma mark 按钮点击方法

// 输入功率/电价
- (IBAction)startTextFieldAction:(UIButton *)sender {
    [self.powerTF becomeFirstResponder];
    self.textfieldBtn.hidden = YES;
//    if ([self.delegate respondsToSelector:@selector(didClickShowKeyboard)]) {
//        [self.delegate didClickShowKeyboard];
//    }
}

// 删除当前cell
- (IBAction)reductionAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickReductionActionWith:)]) {
        [self.delegate didClickReductionActionWith:self.indexPath];
    }
}

// 增加一个新cell
- (IBAction)addCellAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickAddAction:)]) {
        [self.delegate didClickAddAction:self.indexPath];
    }
}

// 时间选择器
- (IBAction)changeTimeAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickChangeTimeActionWith:label:)]) {
        [self.delegate didClickChangeTimeActionWith:self.indexPath label:self.timeLabel];
    }
}

/*
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

*/
-(PlantSettingViewModel *)planVM {
    if (!_planVM) {
        _planVM = [[PlantSettingViewModel alloc]initViewModel];
    }
    return _planVM;
}

@end
