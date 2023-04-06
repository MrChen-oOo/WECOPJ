//
//  InfoTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "InfoTableViewCell.h"

@interface InfoTableViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLayoutConstraint;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *hiddenLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dataMsg;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation InfoTableViewCell


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier index:(nonnull NSIndexPath *)indexpath{
    self = [[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.dataMsg.constant = kScreenWidth == 320 ? 100 : 200;
        self.indexPath = indexpath;
    }
    return self;
}

-(void)setCellUIWithKey:(NSString *)key value:(NSString *)value isLast:(BOOL)isLast isFirst:(BOOL)isFirst isSegment:(BOOL)isSegment unit:(NSInteger)unit typeNum:(NSInteger)typeNum{

    
    if (isLast) {
        self.bottomLayoutConstraint.constant = 10;
        self.centerLayoutConstraint.constant = -10;
    } else if (isFirst) {
        self.hiddenLabel.hidden = !isSegment;
        self.topLayoutConstraint.constant = isSegment == NO ? 10 : 10;
        self.centerLayoutConstraint.constant = isSegment == NO ? 10 : 10;
    } else {
        self.topLayoutConstraint.constant = -10;
        self.centerLayoutConstraint.constant = 0;
    }

    
    self.keyLabel.text = key;
    
    if (value == nil) {
        value = @"0";
    }
    
    CGFloat valueFloat = [value floatValue];
    NSString *unitStr = @"";
    // 0:无单位 1:伏特 V  2:安 A 3:千瓦 kW 4:赫兹 Hz 5:% 6:摄氏度 C° 7:版本号 前面加V 8:kVar
    switch (unit) {
        case 0:
            unitStr = [NSString stringWithFormat:@"%@",value];
            break;
        case 1:
            unitStr = [NSString stringWithFormat:@"%.fV",valueFloat];
            break;
        case 2:
            unitStr = [NSString stringWithFormat:@"%.fA",valueFloat];
            break;
        case 3:
            unitStr = [NSString stringWithFormat:@"%.fkW",valueFloat];
            break;
        case 4:
            unitStr = [NSString stringWithFormat:@"%.fHz",valueFloat];
            break;
        case 5:
            unitStr = [NSString stringWithFormat:@"%@%%",value];
            break;
        case 6:
            unitStr = [NSString stringWithFormat:@"%.fC°",valueFloat];
            break;
        case 7:
            unitStr = [NSString stringWithFormat:@"V%@",value];
            break;
        case 8:
            unitStr = [NSString stringWithFormat:@"%@kVar",value];
            break;
        default:
            break;
    }
    
    NSArray *basicWorkMode = @[@"Auto Mode",@"Peak Shaving"];
    NSArray *pcsModelArray = @[@"No Avail",@"DC Constant Voltage",@"DC Constant Current",@"DC Constant Power",@"AC Constant Voltage",@"AC Constant Current",@"AC Constant Power"];
    NSArray *pcsInfoStatusArray = @[@"No Avail",@"Standby",@"Self-Check",@"On-Grid",@"Off-Grid"];
    
    NSArray *pvInfoStausArray = @[@"No Avail",@"Standby",@"Self-Check",@"Runing"];
    
    NSArray *batteryStatusArray = @[@"Sleep",@"Charge",@"Discharge",@"Standby"];
    
    NSArray *invBasicInfoArray = @[@"Auto Mode",@"Peak Shaving",@"BBattery Priority"];
    
    switch (typeNum) {
        case 1:{
            if (self.indexPath.section == 0 && self.indexPath.row == 1){
                unitStr = [value intValue] == 6 ? basicWorkMode[0] : basicWorkMode[1];
            }
            
            if (self.indexPath.section == 1 && self.indexPath.row == 0) {
                NSInteger num = [value intValue];
                unitStr = num >= pcsModelArray.count ? @"Invalid" : pcsModelArray[num];
            }
            
            if (self.indexPath.section == 1 && self.indexPath.row == 1) {
                NSInteger num = [value intValue];
                unitStr = num >= pcsInfoStatusArray.count ? @"Invalid" : pcsInfoStatusArray[num];
            }
            break;
        }
        case 2:{
            if (self.indexPath.section == 0 && self.indexPath.row == 0){
                unitStr = pvInfoStausArray[[value intValue]];
            }
            break;
        }
        case 3:
            if (self.indexPath.section == 0 && self.indexPath.row == 0){
                unitStr = batteryStatusArray[[value intValue]];
            }
            break;
        case 4:
            if (self.indexPath.section == 0 && self.indexPath.row == 1){
                unitStr = invBasicInfoArray[[value intValue]];
            }
            break;
        default:
            break;
    }
    
    self.valueLabel.text = unitStr;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
