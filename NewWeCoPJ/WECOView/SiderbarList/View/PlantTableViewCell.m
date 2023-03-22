//
//  PlantTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import "PlantTableViewCell.h"

@interface PlantTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) NSIndexPath * indexPath;
@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeViewCenterLayer;

@property (weak, nonatomic) IBOutlet UITextField *powerTF;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *ReductionBtn;

@property (nonatomic, strong) PlantSettingViewModel *planVM;

@end

@implementation PlantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.addBtn setTitle:@"" forState:(UIControlStateNormal)];
    [self.ReductionBtn setTitle:@"" forState:(UIControlStateNormal)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath viewModel:(nonnull PlantSettingViewModel *)viewModel{
    self = [[NSBundle mainBundle] loadNibNamed:@"PlantTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.indexPath = indexPath;
        self.planVM = viewModel;
        self.lastView.hidden = YES;
    }
    return self;
}

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
        timeStr = [NSString stringWithFormat:@"%@:%@-%@:%@",model.startHour,model.startMinute,model.endHour,model.endMinute];
        powerStr = [NSString stringWithFormat:@"%@kW",model.power];
    } else {
        TimeModel *model = dischargeArray[self.indexPath.row];
        timeStr = [NSString stringWithFormat:@"%@:%@-%@:%@",model.startHour,model.startMinute,model.endHour,model.endMinute];
        powerStr = [NSString stringWithFormat:@"%@kW",model.power];
    }
    self.timeLabel.text = timeStr;
    self.powerTF.text = powerStr;
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.indexPath.section == 0) {
        self.planVM.batteryChargArray[self.indexPath.row].power = textField.text;
    } else {
        self.planVM.batteryDisChargArray[self.indexPath.row].power = textField.text;
    }
    
    self.powerTF.text = [NSString stringWithFormat:@"%@kW",textField.text];
}


#pragma mark 按钮点击方法

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


-(PlantSettingViewModel *)planVM {
    if (!_planVM) {
        _planVM = [[PlantSettingViewModel alloc]initViewModel];
    }
    return _planVM;
}

@end
