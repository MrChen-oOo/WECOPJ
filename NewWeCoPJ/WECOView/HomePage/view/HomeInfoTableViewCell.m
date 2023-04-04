//
//  HomeInfoTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import "HomeInfoTableViewCell.h"



@interface HomeInfoTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *avoidedLabel;  //t
@property (weak, nonatomic) IBOutlet UILabel *pvEnergyLabel; //kWh
@property (weak, nonatomic) IBOutlet UILabel *gridExportedEnergyLabel;
@property (weak, nonatomic) IBOutlet UILabel *gridImportedEnergyLabel;
@property (weak, nonatomic) IBOutlet UILabel *batterInputEnergyLabel;
@property (weak, nonatomic) IBOutlet UILabel *batterOutputEnergyLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadConsumptionLabel;

@property (nonatomic, strong)HomePageViewModel *homePageVM;


@property (weak, nonatomic) IBOutlet UILabel *avoidedTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *pvEnergyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *gridExportedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *gridImportedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *batterInputTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *batterOutputTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadConsumptionTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;





@end



@implementation HomeInfoTableViewCell


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier homeVM:(HomePageViewModel *)homeVM {
    self = [[NSBundle mainBundle] loadNibNamed:@"HomeInfoTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.homePageVM = homeVM;
        if (kScreenWidth == 320) {
            self.avoidedTitlelabel.font = [UIFont systemFontOfSize:12.0f];
            self.pvEnergyTitleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.gridExportedTitleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.gridImportedTitleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.batterInputTitleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.batterOutputTitleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.loadConsumptionTitleLabel.font = [UIFont systemFontOfSize:12.0f];
            [self.pushBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        }
    }
    return self;
}


-(void)reloadCellMessage {
    
    if (self.homePageVM.homeModel.todayInfo == nil) {
        return;
    }
    
    self.avoidedLabel.text = [NSString stringWithFormat:@"%@t",self.homePageVM.homeModel.todayInfo.co2Awolided];
    self.pvEnergyLabel.text = [NSString stringWithFormat:@"%@kWh",self.homePageVM.homeModel.todayInfo.pvElectrical];
    self.gridExportedEnergyLabel.text = [NSString stringWithFormat:@"%@kWh",self.homePageVM.homeModel.todayInfo.gridTotalEnergy];
    self.gridImportedEnergyLabel.text = [NSString stringWithFormat:@"%@kWh",self.homePageVM.homeModel.todayInfo.purchasingTotalEnergy];
    self.batterInputEnergyLabel.text = [NSString stringWithFormat:@"%@kWh",self.homePageVM.homeModel.todayInfo.batDischarge];
    self.batterOutputEnergyLabel.text = [NSString stringWithFormat:@"%@kWh",self.homePageVM.homeModel.todayInfo.batCharge];
    self.loadConsumptionLabel.text = [NSString stringWithFormat:@"%@kWh",self.homePageVM.homeModel.todayInfo.loadElectrical];

}

// 跳转图表
- (IBAction)pushEnergyAction:(UIButton *)sender {
    self.cellPushBlock ? self.cellPushBlock(): nil;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(HomePageViewModel *)homePageVM {
    if (!_homePageVM) {
        _homePageVM = [[HomePageViewModel alloc]init];
    }
    return _homePageVM;
}


@end
