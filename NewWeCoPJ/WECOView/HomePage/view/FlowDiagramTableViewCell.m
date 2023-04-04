//
//  FlowDiagramTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import "FlowDiagramTableViewCell.h"
#import <SDWebImage/UIImage+GIF.h>
@interface FlowDiagramTableViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftOnLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tightOnLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftDownLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDownLayoutConstraint;

@property (weak, nonatomic) IBOutlet UILabel *systemStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *workModeLabel;

@property (weak, nonatomic) IBOutlet UILabel *pvPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *gridPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *gridLoadPowerLabel;

@property (weak, nonatomic) IBOutlet UILabel *batteryNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pvPowerImage;
@property (weak, nonatomic) IBOutlet UIImageView *gridPowerImage;
@property (weak, nonatomic) IBOutlet UIImageView *batteryImage;
@property (weak, nonatomic) IBOutlet UIImageView *gridLoadImage;
@property (weak, nonatomic) IBOutlet UIImageView *deviceImage;

@property (weak, nonatomic) IBOutlet UIView *addView;

@property (nonatomic, strong)HomePageViewModel *homePageVM;

@property (weak, nonatomic) IBOutlet UIImageView *gridPowerImageV;
@property (weak, nonatomic) IBOutlet UIImageView *batPowerImageV;

@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *addTextLabel;




@property (weak, nonatomic) IBOutlet UIImageView *leftOnAnimationImageV;          
@property (weak, nonatomic) IBOutlet UIImageView *rightOnAnimationImageV;
@property (weak, nonatomic) IBOutlet UIImageView *leftDownAnimationImageV;
@property (weak, nonatomic) IBOutlet UIImageView *rightDownAnimationImageV;

@property (nonatomic, strong) NSMutableArray * pvPowerImageArray;                 // pv流向图
@property (nonatomic, strong) NSMutableArray * gridPowerLeftImageArray;           // grid流向图（正）
@property (nonatomic, strong) NSMutableArray * gridPowerRightImageArray;          // grid流向图（负）
@property (nonatomic, strong) NSMutableArray * batPowerLeftImageArray;            // bat流向图(正)
@property (nonatomic, strong) NSMutableArray * batPowerRightImageArray;           // bat流向图（负）
@property (nonatomic, strong) NSMutableArray * loadPowerImageArray;               // load流向图

@end


@implementation FlowDiagramTableViewCell


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier homeVM:(HomePageViewModel *)homeVM {
    self = [[NSBundle mainBundle] loadNibNamed:@"FlowDiagramTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.homePageVM = homeVM;
        self.leftOnAnimationImageV.hidden = YES;
        self.leftDownAnimationImageV.hidden = YES;
        self.rightOnAnimationImageV.hidden = YES;
        self.rightDownAnimationImageV.hidden = YES;
        self.hiddenView.hidden = YES;
    }
    return self;
}



-(void)reloadCellMessage {
  
    // 判断是否显示添加电站/设备背景图
    if (self.homePageVM.planListModel.obj.count == 0 || (self.homePageVM.deviceModel.pcsList.count == 0 && self.homePageVM.deviceModel.mgrnList.count == 0)) {
        [self.contentView bringSubviewToFront:self.hiddenView];
        self.hiddenView.hidden = NO;
    } else {
        self.hiddenView.hidden = YES;
        [self.contentView sendSubviewToBack:self.hiddenView];
    }
    [self.addImage setImage:[UIImage imageNamed:self.homePageVM.planListModel.obj.count == 0 ? @"powerStation" : @"devicePlaceHolder"]];
    [self.addButton setTitle:self.homePageVM.planListModel.obj.count == 0 ? @"Add Plant" : @"Add device" forState:(UIControlStateNormal)];
    self.addTextLabel.text = self.homePageVM.planListModel.obj.count == 0 ? @"The user does not have Plant,please create." : @"Plant not bound device,Please scan device QR code to add.";
    
    
    NSString *systemStateStr = @"";
    NSString *workModeStr = @"";

    if (self.homePageVM.deviceType == 1) {
        // 逆变器的工作模式
        NSArray *inverterSystemArray = @[@"Standby",@"Off Grid",@"On Grid",@"Off Grid PL",@"Service Mode",@"Open Test",@"Close Test",@"Inv To PFC"];
        NSArray *inverterWorkModeArray = @[@"Load Prioritized",@"Plan Mode",@"Bat Prioritized"];
        systemStateStr = self.homePageVM.homeModel.systemState >= inverterSystemArray.count ? @"No Avail" : inverterSystemArray[self.homePageVM.homeModel.systemState];
        workModeStr = self.homePageVM.homeModel.workModel >= inverterWorkModeArray.count ? @"No Avail" : inverterWorkModeArray[self.homePageVM.homeModel.workModel];
        if (self.homePageVM.homeModel.online == 0) {
            systemStateStr = @"Offline";
        }
        self.deviceImage.image = [UIImage imageNamed:self.homePageVM.homeModel.online == 1 ? @"inverterDeviceOnline" : @"inverterDeviceOffline"];
    } else {
        // HMI工作模式
        NSArray *inverterSystemArray = @[@"No Avail",@"Standby",@"Self Check",@"On Grid",@"Off Grid"];
        NSArray *inverterWorkModeArray = @[@"No Avail",@"Bat Prioritized",@"Remote Mode",@"Plan Mode",@"No Avail",@"Local Mode",@"Load Prioritized"];
        systemStateStr = self.homePageVM.homeModel.systemState >= inverterSystemArray.count ? @"No Avail" : inverterSystemArray[self.homePageVM.homeModel.systemState];
        workModeStr = self.homePageVM.homeModel.workModel >= inverterWorkModeArray.count ? @"No Avail" : inverterWorkModeArray[self.homePageVM.homeModel.workModel];
        if (self.homePageVM.homeModel.online == 0) {
            systemStateStr = @"Offline";
        }
        [self.deviceImage setImage:[UIImage imageNamed:self.homePageVM.homeModel.online == 1 ? @"hmiDeviceOnline" : @"hmiDeviceOffline"]];
    }
    self.systemStateLabel.text = [NSString stringWithFormat:@"System State：%@",systemStateStr];
    self.workModeLabel.text = [NSString stringWithFormat:@"Work Mode：%@",workModeStr];
    [self changeStrWith:self.systemStateLabel.text changeStr:@"System State：" label:self.systemStateLabel];
    [self changeStrWith:self.workModeLabel.text changeStr:@"Work Mode：" label:self.workModeLabel];

    // 若无数据全部默认为0
    if (!self.homePageVM.homeModel.systemState) {
        return;
    }
    
    // 电池百分比图片获取
    NSString *batteryImageString = @"";
    if (self.homePageVM.homeModel.batSoc.length == 1) {
        if ([self.homePageVM.homeModel.batSoc isEqualToString:@"0"]) {
            batteryImageString =  self.homePageVM.homeModel.online == 1 ? @"online0" : @"offline0";
        } else {
            batteryImageString =  self.homePageVM.homeModel.online == 1 ? @"online1" : @"offline1";
        }
    } else {
        NSInteger num =[ [self.homePageVM.homeModel.batSoc substringToIndex:1] intValue];
        batteryImageString =  self.homePageVM.homeModel.online == 1 ? [NSString stringWithFormat:@"online%ld",num] : [NSString stringWithFormat:@"offline%ld",num];
    }
    
    // 流向图
    CGFloat gridPowerFloat = [self.homePageVM.homeModel.gridPower floatValue];   // 电网功率
    CGFloat batPowerFloat = [self.homePageVM.homeModel.batPower floatValue];     // 电池功率
    CGFloat pvPowerFloat = [self.homePageVM.homeModel.pvPower floatValue];       // 光伏功率
    CGFloat loadPowerFloat = [self.homePageVM.homeModel.loadPower floatValue];       // 光伏功率

    if (self.homePageVM.homeModel.online == 1) {
        // 开机显示流向图
        [self addImageAnimationWith:self.leftOnAnimationImageV imageArray:self.pvPowerImageArray];
        [self addImageAnimationWith:self.rightOnAnimationImageV imageArray:gridPowerFloat < 0 ? self.gridPowerRightImageArray: self.gridPowerLeftImageArray ];
        [self addImageAnimationWith:self.leftDownAnimationImageV imageArray:batPowerFloat < 0 ? self.batPowerLeftImageArray : self.batPowerRightImageArray];
        
        [self.gridPowerImageV setImage:[UIImage imageNamed:gridPowerFloat < 0 ? @"gridPowerRight" : @"gridPowerLeft"]];
        [self.batPowerImageV setImage:[UIImage imageNamed:batPowerFloat < 0 ? @"batPowerLeft" : @"batPowerRight"]];

        [self addImageAnimationWith:self.rightDownAnimationImageV imageArray:self.loadPowerImageArray];
        self.leftOnAnimationImageV.hidden = pvPowerFloat <= 0 ? YES : NO;
        self.leftDownAnimationImageV.hidden = batPowerFloat == 0 ? YES : NO;
        self.rightOnAnimationImageV.hidden = gridPowerFloat == 0 ? YES : NO;
        self.rightDownAnimationImageV.hidden = loadPowerFloat <= 0 ? YES : NO;

    }
    
    
    // 赋值操作
    [self.pvPowerImage setImage:[UIImage imageNamed: (self.homePageVM.homeModel.online == 1 && [self.homePageVM.homeModel.pvPower floatValue] > 0)? @"pvPowerOnline" : @"pvOffline"]];
    [self.gridPowerImage setImage:[UIImage imageNamed:self.homePageVM.homeModel.online == 1 ? @"gridPowerOnline" : @"gridOffline"]];
    [self.gridLoadImage setImage:[UIImage imageNamed:(self.homePageVM.homeModel.online == 1 && [self.homePageVM.homeModel.loadPower floatValue] > 0)? @"gridLoadOnline" : @"gridLoadOffline"]];
    [self.batteryImage setImage:[UIImage imageNamed:batteryImageString]];

    self.pvPowerLabel.text = [NSString stringWithFormat:@"%@kW",self.homePageVM.homeModel.pvPower];
    self.gridLoadPowerLabel.text = [NSString stringWithFormat:@"%@kW",self.homePageVM.homeModel.loadPower];
    self.batteryNumLabel.text = [NSString stringWithFormat:@"%@%%",self.homePageVM.homeModel.batSoc];
    
    self.gridPowerLabel.text = [NSString stringWithFormat:@"%@kW",[self.homePageVM.homeModel.gridPower stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    self.batteryPowerLabel.text = [NSString stringWithFormat:@"%@kW",[self.homePageVM.homeModel.batPower stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    
}



// 添加设备/电站
- (IBAction)addAction:(UIButton *)sender {
    self.cellPushBlock ? self.cellPushBlock(): nil;
}

- (void)addImageAnimationWith:(UIImageView *)imageV imageArray:(NSMutableArray *)imageArray{
    imageV.animationImages = imageArray;
    imageV.animationDuration = 3.0f;
    imageV.animationRepeatCount = 0;
    [imageV startAnimating];
}








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)changeStrWith:(NSString *)Str changeStr:(NSString *)changeStr label:(UILabel *)label{
    NSMutableAttributedString *normalPriceStr = [[NSMutableAttributedString alloc] initWithString:Str];
    // 找出特定字符在整个字符串的位置的位置
    NSRange normalRange = NSMakeRange([[normalPriceStr string] rangeOfString:changeStr].location, [[normalPriceStr string] rangeOfString:changeStr].length);
    // 修改特定字符的颜色
    [normalPriceStr addAttribute:NSForegroundColorAttributeName value:HexRGB(0x838383) range:normalRange];
    label.attributedText = normalPriceStr;
}


#pragma mark - 懒加载

-(HomePageViewModel *)homePageVM {
    if (!_homePageVM) {
        _homePageVM = [[HomePageViewModel alloc]init];
    }
    return _homePageVM;
}

-(NSMutableArray *)pvPowerImageArray {
    if (!_pvPowerImageArray) {
        _pvPowerImageArray = [NSMutableArray array];
        for (int i = 0 ; i < 75 ; i++) {
            NSInteger num = 100 + i;
            [_pvPowerImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"pvPower%ld",(long)num]]];
        }
    }
    return _pvPowerImageArray;
}
-(NSMutableArray *)gridPowerLeftImageArray {
    if (!_gridPowerLeftImageArray) {
        _gridPowerLeftImageArray = [NSMutableArray array];
        for (int i = 0 ; i < 75 ; i++) {
            NSInteger num = 100 + i;
            [_gridPowerLeftImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"gridPowerleft%ld",(long)num]]];
        }
    }
    return _gridPowerLeftImageArray;
}
-(NSMutableArray *)gridPowerRightImageArray {
    if (!_gridPowerRightImageArray) {
        _gridPowerRightImageArray = [NSMutableArray array];
        for (int i = 0 ; i < 75 ; i++) {
            NSInteger num = 100 + i;
            [_gridPowerRightImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"gridPowerRight%ld",(long)num]]];
        }
    }
    return _gridPowerRightImageArray;
}

-(NSMutableArray *)batPowerLeftImageArray {
    if (!_batPowerLeftImageArray) {
        _batPowerLeftImageArray = [NSMutableArray array];
        for (int i = 0 ; i < 75 ; i++) {
            NSInteger num = 100 + i;
            [_batPowerLeftImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"batLeft%ld",(long)num]]];
        }
    }
    return _batPowerLeftImageArray;
}

-(NSMutableArray *)batPowerRightImageArray {
    if (!_batPowerRightImageArray) {
        _batPowerRightImageArray = [NSMutableArray array];
        for (int i = 0 ; i < 75 ; i++) {
            NSInteger num = 100 + i;
            [_batPowerRightImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"batRight%ld",(long)num]]];
        }
    }
    return _batPowerRightImageArray;
}

-(NSMutableArray *)loadPowerImageArray {
    if (!_loadPowerImageArray) {
        _loadPowerImageArray = [NSMutableArray array];
        for (int i = 0 ; i < 75 ; i++) {
            NSInteger num = 100 + i;
            [_loadPowerImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loadPower%ld",(long)num]]];
        }
    }
    return _loadPowerImageArray;
}

@end
