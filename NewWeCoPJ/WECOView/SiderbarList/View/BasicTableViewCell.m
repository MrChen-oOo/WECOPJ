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

// SE的UI处理
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnRightLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLeftLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *msgRightLayout;


@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) SettingOptionModel *optionModel;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSMutableArray *gridStandardsKeyArray;
@property (nonatomic, strong) NSMutableArray *gridSetArray;
@property (nonatomic, strong) NSMutableArray *usaStandardClassArray;
@property (nonatomic, assign) NSInteger deviceType;
@end

@implementation BasicTableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(nonnull NSIndexPath *)indexPath deviceType:(NSInteger)deviceType{
    self = [[NSBundle mainBundle] loadNibNamed:@"BasicTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.indexPath = indexPath;
        self.deviceType = deviceType;
        [self.reloadBtn setTitle:@"" forState:(UIControlStateNormal)];
        [self setBtnBackgroundColor];
        [self endEditing:YES];
        
        // SE
        if (kScreenWidth == 320) {
            [self changeSeUi];
        }
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

// 特殊机型SE处理
- (void)changeSeUi {
    self.btnRightLayout.constant = 37;
    self.btnLeftLayout.constant = 37;
    self.msgRightLayout.constant = 5;
}


// 刷新按钮颜色
- (void)setBtnBackgroundColor{
    self.shutDownBtn.layer.masksToBounds = YES;
    self.shutDownBtn.layer.borderWidth = 1;
    self.shutDownBtn.layer.borderColor = HexRGB(0x4776ff).CGColor;
}


-(void)setMessageWithValueArray:(NSArray *)valueArray keyArray:(NSArray *)keyArray unitArray:(NSArray *)unitArray row:(NSInteger)row{
    NSInteger girdInt = [valueArray[row] intValue];
    NSInteger uniInt = [unitArray[row] intValue];
    NSString *labelText = @"";
    
    self.dataArray = [NSArray arrayWithArray:valueArray];
    self.controlNameLabel.text = [NSString stringWithFormat:@"%@", keyArray[row]];
    [self setCellUIWithArray:keyArray row:row value:valueArray[row]];
    
    if (valueArray[row] == nil) {
        self.dataMsgLabel.text = @"0";
        return;
    }
    
    // 0:无单位 1:百分比 2:安 A  3:小时 h  4:瓦 W 5:千兆 kM 6:千瓦kW
    switch (uniInt) {
        case 0:{
            if (self.indexPath.section == 3 && row == 0) {
                
                // gridStandad
                labelText = self.gridStandardsKeyArray[girdInt];
            } else if (self.indexPath.section == 3 && row == 2){
          
                // usaStandardClass
                labelText = self.usaStandardClassArray[girdInt];
            } else if (self.indexPath.section == 3 && row == 1) {
                
                // gridSet
                labelText = self.gridSetArray[girdInt];
            } else if(self.indexPath.section == 1 && row == 3 && valueArray.count == 7){
                
                // PV Input Type
                NSArray *array = [NSMutableArray arrayWithObjects:@"Independant",@"Parallel",@"CV", nil];
                labelText = array[girdInt];
            } else if(self.indexPath.section == 4 && row == 1) {
                
                // Parallel
                NSArray * array = @[@"Master",@"Slave"];
                NSInteger isMaster = [valueArray[row] intValue];
                labelText = array[isMaster];
            } else if (self.indexPath.section == 4 && row == 5){
                
                // 3PhaseEnable
                NSArray *array = @[@"A",@"B",@"C"];
                labelText = array[girdInt];
            } else if(self.indexPath.section == 0 && row == 5 && valueArray.count == 8){
                
                // modbusBaud
                NSArray *array = @[@"9600",@"19200"];
                if (girdInt != 0 && girdInt != 1){
                    girdInt = 0;
                }
                labelText = array[girdInt];
            } else {
                labelText = [NSString stringWithFormat:@"%@",valueArray[row]];
            }
            break;
        }
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
            labelText = [NSString stringWithFormat:@"%dW", [valueArray[row] intValue]];
            break;
        case 5:
            labelText = [NSString stringWithFormat:@"%dkM", [valueArray[row] intValue]];
            break;
        case 6:
            labelText = [NSString stringWithFormat:@"%dkW", [valueArray[row] intValue]];
            break;
        default:
            break;
    }
    self.dataMsgLabel.text = labelText;
  
    
}

-(void)setCellUIWithArray:(NSArray *)array row:(NSInteger)row value:(NSString *)value{

    
    // cell仅仅为一个的时候
    if (array.count == 1) {
        self.bottomLayoutConstraint.constant = 10;
        self.topLayoutConstraint.constant = 10;
        self.planSettingBtn.hidden = YES;
        return;
    }
    
    // cell为最后一个时展示阴影部分下移
    if (row == array.count - 1) {
        self.bottomLayoutConstraint.constant = 10;
        if (self.indexPath.section == 0 && array.count > 3) {
            self.centerLayoutConstraint.constant = -30;
        } else {
            self.centerLayoutConstraint.constant = -10;
        }
        
    } else {
        // cell为第一个时展示阴影部分上移
        self.topLayoutConstraint.constant = row == 0 ? 10 : -10;
        self.centerLayoutConstraint.constant = row == 0 ? 10 : 0;
        self.planSettingBtn.hidden = self.indexPath.section == 0 && self.indexPath.row == 1 ? NO : YES;
    }
    if ((self.indexPath.section == 0 && self.indexPath.row == 1 && array.count == 3)                 // 逆变器的计划入口
        || (self.indexPath.section == 0 && self.indexPath.row == 1 && array.count == 2)){            // HMI的计划入口
        self.planSettingBtn.hidden = NO;
    } else {
        self.planSettingBtn.hidden = YES;
    }
}

-(void)setUIWithUIArray:(NSArray *)array deviceStr:(nonnull NSString *)deviceStr {

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
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 按钮开关点击方法
- (IBAction)changeSwichAction:(UISwitch *)sender {
    NSInteger isSwich = sender.isOn;
    NSArray *array =  self.deviceType == 1 ? self.optionModel.basicSettingParamArray[self.indexPath.section] : self.optionModel.cabinetBasicSettingParamArray[self.indexPath.section];
    NSString *codeStr = [NSString stringWithFormat:@"%@",array[self.indexPath.row]];
    
    if (self.indexPath.section == 0){
        isSwich = self.indexPath.row;
    }
    NSDictionary *paramDic = @{@"deviceSn":self.device,@"code":codeStr,@"value":[NSString stringWithFormat:@"%ld",isSwich]};
    
    if ([self.delegate respondsToSelector:@selector(didClickSwichActionWith:swich:)]) {
        [self.delegate didClickSwichActionWith:paramDic swich:sender];
    }
}

// 计划按钮
- (IBAction)planSettingAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickPlanSettingWithIsTimePlanSetting:)]) {
        [self.delegate didClickPlanSettingWithIsTimePlanSetting:YES];
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

        NSArray *array = @[@"UL1741&IEEE1547.2020",@"Rule21",@"SRD-UL1741 1.0",@"UL1741 SB",@"UL1741 SA",@"Heco 2.0"];
        NSArray *seArray = @[@"UL1741...",@"Rule21",@"SRD-UL...",@"UL1741 SB",@"UL1741 SA",@"Heco 2.0"];
        _usaStandardClassArray = [NSMutableArray array];
        [_usaStandardClassArray addObjectsFromArray:kScreenWidth == 320 ? seArray : array];
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
