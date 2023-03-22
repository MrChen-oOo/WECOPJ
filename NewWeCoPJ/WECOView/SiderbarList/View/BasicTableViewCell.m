//
//  BasicTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/15.
//

#import "BasicTableViewCell.h"
#import "SettingOptionModel.h"

@interface BasicTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *controlNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;

@property (weak, nonatomic) IBOutlet UILabel *dataMsgLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UIButton *planSettingBtn;

@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *shutDownBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) SettingOptionModel *optionModel;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSMutableArray *gridStandardsKeyArray;
@property (nonatomic, strong) NSMutableArray *gridSetArray;
@property (nonatomic, strong) NSMutableArray *usaStandardClassArray;
@end

@implementation BasicTableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath {
    self = [[NSBundle mainBundle] loadNibNamed:@"BasicTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.indexPath = indexPath;
        [self.reloadBtn setTitle:@"" forState:(UIControlStateNormal)];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}



-(void)setMessageWithOptionArray:(NSArray *)optionArray valueArray:(NSArray *)valueArray keyArray:(NSArray *)keyArray selectArray:(NSArray *)selectArray row:(NSInteger)row {
    NSInteger selectNum = [selectArray[row] intValue];
    NSInteger girdInt = [valueArray[row] intValue];
    
    if (selectNum == 1) {
        NSString *labelText = @"";
        if (self.indexPath.section == 5) {
            switch (self.indexPath.row) {
                case 0:
                    labelText = [NSString stringWithFormat:@"%d%%", [valueArray[row] intValue]];
                    break;
                case 1:
                    labelText = [NSString stringWithFormat:@"%d%%", [valueArray[row] intValue]];
                    break;
                case 2:
                    labelText = [NSString stringWithFormat:@"%dA", [valueArray[row] intValue]];
                    break;
                case 3:
                    labelText = [NSString stringWithFormat:@"%dh", [valueArray[row] intValue]];
                    break;
                case 4:
                    labelText = [NSString stringWithFormat:@"%dh", [valueArray[row] intValue]];
                    break;
                case 11:
                    labelText = [NSString stringWithFormat:@"%dW", [valueArray[row] intValue]];
                    break;
                default:
                    break;
            }
        } else if (self.indexPath.section == 4 || (self.indexPath.section == 0 && self.indexPath.row == 2 && keyArray.count != 3)) {
            labelText = [NSString stringWithFormat:@"%dA", [valueArray[row] intValue]];
        } else if (self.indexPath.section == 1 || (self.indexPath.section == 0 && self.indexPath.row == 4)){
            labelText = [NSString stringWithFormat:@"%d",[valueArray[row] intValue]];
        } else {
            labelText = [NSString stringWithFormat:@"%d%%", [valueArray[row] intValue]];
        }
        self.dataMsgLabel.text = labelText;
    } else {
        if (self.indexPath.section == 3 && row == 0) {
            
            // gridStandad
            self.dataMsgLabel.text = self.gridStandardsKeyArray[girdInt];
        } else if (self.indexPath.section == 3 && row == 2){
            
            // usaStandardClass
            self.dataMsgLabel.text = self.usaStandardClassArray[girdInt];
        } else if (self.indexPath.section == 3 && row == 1) {
            
            // gridSet
            self.dataMsgLabel.text = self.gridSetArray[girdInt];
        } else if(self.indexPath.section == 1 && row == 3 && valueArray.count == 7){
            
            // PV Input Type
            NSArray *array = [NSMutableArray arrayWithObjects:@"Independant",@"Parallel",@"CV", nil];
            self.dataMsgLabel.text = array[girdInt];
        } else if(self.indexPath.section == 4 && row == 1) {
            
            // Parallel
            NSArray * array = @[@"master",@"slave"];
            NSInteger isMaster = [valueArray[row] intValue];
            self.dataMsgLabel.text = array[isMaster];
        } else if (self.indexPath.section == 4 && row == 5){
            
            // 3PhaseEnable
            NSArray *array = @[@"A",@"B",@"C"];
            self.dataMsgLabel.text = array[girdInt];
        } else if(self.indexPath.section == 0 && row == 5 && valueArray.count == 8){
            
            // modbusBaud
            NSArray *array = @[@"9600",@"19200"];
            if (girdInt != 0 && girdInt != 1){
                girdInt = 0;
            }
            self.dataMsgLabel.text = array[girdInt];
        } else {
            self.dataMsgLabel.text = [NSString stringWithFormat:@"%@",valueArray[row]];
        }
    }
    self.dataArray = [NSArray arrayWithArray:valueArray];
    self.controlNameLabel.text = [NSString stringWithFormat:@"%@", optionArray[row]];
    [self setCellUIWithArray:keyArray row:row];
    
}

-(void)setCellUIWithArray:(NSArray *)array row:(NSInteger)row {

    if (row == array.count - 1) {
        self.bottomLayoutConstraint.constant = 10;
        if (self.indexPath.section == 0 && array.count > 3) {
            self.centerLayoutConstraint.constant = -30;
        } else {
            self.centerLayoutConstraint.constant = -15;
        }
        
    } else {
        self.topLayoutConstraint.constant = row == 0 ? 10 : -10;
        self.centerLayoutConstraint.constant = row == 0 ? 15 : 0;
        self.planSettingBtn.hidden = self.indexPath.section == 0 && self.indexPath.row == 1 ? NO : YES;
    }
    if (self.indexPath.section == 0 && self.indexPath.row == 1 && array.count == 3){
        self.planSettingBtn.hidden = NO;
    } else {
        self.planSettingBtn.hidden = YES;
    }
}

-(void)setUIWithUIArray:(NSArray *)array deviceStr:(nonnull NSString *)deviceStr{

    self.device = deviceStr;
    NSInteger num = [array[self.indexPath.row] intValue];
    
    // 0:保留按钮 1:保留文字和箭头 2:特殊符号 3:保留刷新按钮 4:保留开关机按钮
    self.openSwitch.hidden = num == 0 ? NO : YES;
    self.dataMsgLabel.hidden = num == 1 ? NO : YES;
    self.rightImage.hidden = num == 1 ? NO : YES;
    self.reloadBtn.hidden = num == 3 ? NO : YES;
    self.startBtn.hidden = num == 4 ? NO : YES;
    self.shutDownBtn.hidden = num == 4 ? NO : YES;
    
    
    NSInteger selectNum = [self.dataArray[self.indexPath.row] intValue];
    [self.openSwitch setOn:num == 0 ? selectNum : 0];
    if (num == 4) {
        [self setBtnBackgroundColorWith:selectNum];
    }
}


// 刷新按钮颜色
- (void)setBtnBackgroundColorWith:(BOOL)isStart {
    [self.startBtn setBackgroundColor:isStart == YES ? HexRGB(0x4776ff) : [UIColor whiteColor]];
    [self.shutDownBtn setBackgroundColor:isStart == NO ? HexRGB(0x4776ff) : [UIColor whiteColor]];
    [self.startBtn setTitleColor:isStart == YES ? [UIColor whiteColor] : HexRGB(0x4776ff) forState:(UIControlStateNormal)];
    [self.shutDownBtn setTitleColor:isStart == NO ? [UIColor whiteColor]  : HexRGB(0x4776ff) forState:(UIControlStateNormal)];
    self.startBtn.layer.masksToBounds = YES;
    self.shutDownBtn.layer.masksToBounds = YES;
    self.startBtn.layer.borderWidth = 1;
    self.shutDownBtn.layer.borderWidth = 1;
    self.startBtn.layer.borderColor = isStart == YES ? [UIColor clearColor].CGColor : HexRGB(0x4776ff).CGColor;
    self.shutDownBtn.layer.borderColor = isStart == NO ? [UIColor clearColor].CGColor : HexRGB(0x4776ff).CGColor;
    self.startBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.shutDownBtn.titleLabel.font = [UIFont systemFontOfSize:10];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 按钮开关点击方法
- (IBAction)changeSwichAction:(UISwitch *)sender {
    NSInteger isSwich = sender.isOn;
    NSArray *array = self.optionModel.basicSettingParamArray[self.indexPath.section];
    NSString *codeStr = [NSString stringWithFormat:@"%@",array[self.indexPath.row]];
    
    if (self.indexPath.section == 0){
        isSwich = self.indexPath.row;
    }
    NSDictionary *paramDic = @{@"deviceSn":self.device,@"code":codeStr,@"value":@(isSwich)};
    
    if ([self.delegate respondsToSelector:@selector(didClickSwichActionWith:swich:)]) {
        [self.delegate didClickSwichActionWith:paramDic swich:sender];
    }
}

// 计划按钮
- (IBAction)planSettingAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickPlanSetting)]) {
        [self.delegate didClickPlanSetting];
    }
}

// 刷新按钮
- (IBAction)reloadBtnAction:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(didClickReloadAction)]) {
        [self.delegate didClickReloadAction];
    }
}

// 开机按钮
- (IBAction)startUpAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickStartUpWithShutDown:)]) {
        [self.delegate didClickStartUpWithShutDown:YES];
    }
}


// 关机按钮
- (IBAction)cancelAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickStartUpWithShutDown:)]) {
        [self.delegate didClickStartUpWithShutDown:NO];
    }
}


#pragma mark 懒加载

-(SettingOptionModel *)optionModel {
    if (!_optionModel) {
        _optionModel = [[SettingOptionModel alloc]init];
    }
    return _optionModel;
}

-(NSMutableArray *)gridStandardsKeyArray {
    if (!_gridStandardsKeyArray) {
        _gridStandardsKeyArray = [NSMutableArray arrayWithObjects:@"Australia",@"Australasia west",@"New Zealand",@"Britain",@"Pakistan",@"South Korea",@"Philippines",@"China",@"United States",@"Thailand",@"South Africa",@"Customer customizati",@"Poland",@"EN50549",@"VDE4105",@"Japan",@"Italy",@"Slovenia",@"Czech Republic",@"Sweden",@"Hungary",@"Slovakia", nil];
    }
    return _gridStandardsKeyArray;
}

-(NSMutableArray *)usaStandardClassArray {
    if (!_usaStandardClassArray) {
        _usaStandardClassArray = [NSMutableArray arrayWithObjects:@"UL1741&IEEE1547.2020",@"Rule21",@"SRD-UL1741 1.0",@"UL1741 SB",@"UL1741 SA",@"Heco 2.0", nil];
    }
    return _usaStandardClassArray;
}

-(NSMutableArray *)gridSetArray {
    if (!_gridSetArray) {
        _gridSetArray = [NSMutableArray arrayWithObjects:@"220V",@"120V/240V",@"120V/208V",@"120V", nil];
    }
    return _gridSetArray;
}


@end
