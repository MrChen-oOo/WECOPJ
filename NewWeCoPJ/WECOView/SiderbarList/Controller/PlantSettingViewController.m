//
//  PlantSettingViewController.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/18.
//

#import "PlantSettingViewController.h"
#import "PlantTableViewCell.h"
#import "PlantSettingViewModel.h"
#import "CGXPickerView.h"

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface PlantSettingViewController ()<UITableViewDelegate,UITableViewDataSource,PlanTimeDelegate>

@property (nonatomic, strong)UITableView *plantTableView;
@property (nonatomic, strong)PlantSettingViewModel *planVM;
@end

@implementation PlantSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Plant Setting";
    [self.plantTableView registerNib:[UINib nibWithNibName:@"PlantTableViewCell" bundle:nil] forCellReuseIdentifier:@"plantCell"];
    [self.view addSubview:self.plantTableView];
    [self.view endEditing:YES];
    [self addNavgationBarButton];
    [self planGetInverterTime];

}

- (void)addNavgationBarButton {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn addTarget:self action:@selector(saveTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Save" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
     
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

- (void)planGetInverterTime{
    [self showProgressView];
    
    [self.planVM getInverterTimeSoltMsgWithParam:self.deviceSnStr completeBlock:^(NSString * _Nonnull resultStr) {
        @WeakObj(self)
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            [selfWeak.plantTableView reloadData];
        } else {
            // 提示错误
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfWeak showToastViewWithTitle:resultStr];
            });
        }
    }];
}

#pragma mark UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.planVM.batteryChargArray.count + 1 : self.planVM.batteryDisChargArray.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    } else if ((indexPath.section == 0 && indexPath.row == self.planVM.batteryChargArray.count) || (indexPath.section == 1 && indexPath.row == self.planVM.batteryDisChargArray.count)) {
        return 100;
    } else {
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel *sectionName = [[UILabel alloc]initWithFrame:CGRectMake(26, 10, kScreenWidth - 40, 29)];
    sectionName.textAlignment = NSTextAlignmentLeft;
    [sectionName setTextColor:[UIColor lightGrayColor]];
    [sectionName setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:14]];
    [sectionName setTextColor:HexRGB(0x999999)];
    sectionName.text = section == 0 ? @"Battery Charg" : @"Battery Discharge";
    [view addSubview:sectionName];
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell的标识
    static NSString* cellIdentity =  @"plantCell";
    PlantTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PlantTableViewCell alloc] initWithReuseIdentifier:cellIdentity andIndexPath:indexPath viewModel:self.planVM];
    }
    cell.delegate = self;
    [cell setMessageWithChargArray:self.planVM.batteryChargArray dischargeArray:self.planVM.batteryDisChargArray];
    
    return cell;
}

#pragma mark cell的代理方法
-(void)didClickAddAction:(NSIndexPath *)indexPath {
    
    TimeModel *model = [[TimeModel alloc]init];
    model.power = self.planVM.batteryChargArray[0].power;
    model.startHour = @"00";
    model.startMinute = @"00";
    model.endHour = @"00";
    model.endMinute = @"00";
    model.show = 1;
    if (indexPath.section == 0) {
        if (self.planVM.batteryChargArray.count >= 3) {
            return;;
        }
        model.charge = 1;
        model.order = [NSString stringWithFormat:@"%ld",self.planVM.batteryChargArray.count];
        [self.planVM.batteryChargArray addObject:model];
        
    } else {
        if (self.planVM.batteryDisChargArray.count >= 3) {
            return;;
        }
        model.charge = 0;
        model.order = [NSString stringWithFormat:@"%ld",self.planVM.batteryDisChargArray.count];
        [self.planVM.batteryDisChargArray addObject:model];
    }
    [self.plantTableView reloadData];
}

-(void)didClickReductionActionWith:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.planVM.batteryChargArray removeObjectAtIndex:indexPath.row];
    } else {
        [self.planVM.batteryDisChargArray removeObjectAtIndex:indexPath.row];
    }
    [self.plantTableView reloadData];
}

-(void)didClickChangeTimeActionWith:(NSIndexPath *)indexPath label:(nonnull UILabel *)label{
    [self timeClick:label indexRow:indexPath.row section:indexPath.section];
}

// 存储
-(void)saveTimeAction:(UIButton *)sender {
    [self showProgressView];

    @WeakObj(self)
    [self.planVM setUpPlantModelParamCompleteBlock:^(NSString * _Nonnull resultStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfWeak showToastViewWithTitle:@"Setting succeeded"];
            });
            [selfWeak planGetInverterTime];
        } else {
            // 提示错误
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfWeak showToastViewWithTitle:resultStr];
            });
        }
    }];
}


#pragma mark 时间选择
- (void)timeClick:(UILabel *)timeLB indexRow:(NSInteger)rowNumb section:(NSInteger)section{
    
    NSMutableArray *hourData = [[NSMutableArray alloc]init];
    NSMutableArray *minData = [[NSMutableArray alloc]init];
    for (int i = 0; i < 24; i++) {
        if (i < 10) {
            [hourData addObject:[NSString stringWithFormat:@"0%d",i]];
            
        }else{
            [hourData addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
    }
    for (int i = 0; i < 60; i++) {
        if (i < 10) {
            [minData addObject:[NSString stringWithFormat:@"0%d",i]];
            
        }else{
            [minData addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
    }
    NSString *valustr = timeLB.text;
    
    NSArray *timeAllArr = [valustr componentsSeparatedByString:@"-"];
    
    NSArray *starOldArr = [timeAllArr.firstObject componentsSeparatedByString:@":"];
    NSArray *endOldArr = [timeAllArr.lastObject componentsSeparatedByString:@":"];

    NSArray *allarr = @[hourData,minData];

//    allarr = @[hourData,minData,secondData];
    [CGXPickerView showStringPickerWithTitle:root_kaishishijian DataSource:allarr DefaultSelValue:starOldArr IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        
        
        
        [CGXPickerView showStringPickerWithTitle:root_YHQ_551 DataSource:allarr DefaultSelValue:endOldArr IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue2, id selectRow2) {
            
            NSMutableArray *starArr = [NSMutableArray arrayWithArray:(NSArray *)selectValue];
            NSMutableArray *starArr2 = [NSMutableArray arrayWithArray:(NSArray *)selectValue2];

            NSArray *onearr = self.planVM.timeValueArray[section];
    
            NSMutableArray *oldtimeArr = [[NSMutableArray alloc]init];
            
            
            for (int i = 0; i < onearr.count; i++) {
                
                NSString *onesrr = onearr[i];
                if (i != rowNumb) {
                    if (![onesrr isEqualToString:@"00:00-00:00"] && !kStringIsEmpty(onesrr)) {
                        [oldtimeArr addObject:onesrr];
                        
                    }
                }
                
           
            }
            
            BOOL isOverlapping = NO; // 判断是否已经存在一个跨天的时间段，如果再出现一个就必定重叠
            NSMutableArray *times = [NSMutableArray array];
            // 1. 先通过循环判断是否有跨天时间段，把跨天的拆分成两段去做其他判断
            for (int i = 0; i < oldtimeArr.count; i++) {
                NSString *time = oldtimeArr[i];
                NSString *startTime = [time componentsSeparatedByString:@"-"][0];// 开始时间
                NSString *endTime = [time componentsSeparatedByString:@"-"][1];// 结束时间
                
                NSArray *starTimes = [startTime componentsSeparatedByString:@":"];
                NSArray *endTimes = [endTime componentsSeparatedByString:@":"];
                
                int starMin = [starTimes[0] intValue]*60 + [starTimes[1] intValue];
                int endMin = [endTimes[0] intValue]*60 + [endTimes[1] intValue];
                
                if (starMin < endMin) {
                    [times addObject:time];
                } else{
                    isOverlapping = YES;
                    [times addObject:[NSString stringWithFormat:@"%@-%@", startTime, @"23:59"]]; // 跨天的情况分两段
                    [times addObject:[NSString stringWithFormat:@"%@-%@", @"00:00", endTime]];
                }
            }
            
            // 2. 通过判断区间是否重合,来判断是否有重叠时间
            int starMin0 = [starArr[0] intValue]*60 + [starArr[1] intValue]; // 新加时间的开始时间
            int endMin0 = [starArr2[0] intValue]*60 + [starArr2[1] intValue]; // 新加时间的结束时间
            
            if (starMin0 == endMin0) {
                [self showToastViewWithTitle:root_bunengchongdie];// 开始结束时间不能相同
                return ;
            }
            NSString *newTime = [NSString stringWithFormat:@"%@:%@-%@:%@", starArr[0],starArr[1], starArr2[0],starArr2[1]];
            
            if (section == 0) {
                self.planVM.batteryChargArray[rowNumb].startHour = starArr[0];
                self.planVM.batteryChargArray[rowNumb].startMinute = starArr[1];
                self.planVM.batteryChargArray[rowNumb].endHour = starArr2[0];
                self.planVM.batteryChargArray[rowNumb].endMinute = starArr2[1];

            } else {
                self.planVM.batteryDisChargArray[rowNumb].startHour = starArr[0];
                self.planVM.batteryDisChargArray[rowNumb].startMinute = starArr[1];
                self.planVM.batteryDisChargArray[rowNumb].endHour = starArr2[0];
                self.planVM.batteryDisChargArray[rowNumb].endMinute = starArr2[1];
            }
            
            
            
            BOOL isBeing = NO;// 是否已存在该时间段
            if (endMin0 < starMin0) { // 结束时间小于开始时间代表是跨天的时间段
                // 因为出现跨天的情况需要拆成两段时间才能判断  23:00-1:00  ->>  23:00-23:59 ,00:00-01:00
                NSString *newTime1 = [NSString stringWithFormat:@"%@:%@-23:59",starArr[0],starArr[1]];
                NSString *newTime2 = [NSString stringWithFormat:@"00:00-%@:%@",starArr2[0],starArr2[1]];
                for (int i = 0; i < times.count; i++) {
                    BOOL B1 = [self isOverlappingWithTime0:newTime1 Time1:times[i]];
                    BOOL B2 = [self isOverlappingWithTime0:newTime2 Time1:times[i]];
                    if (B1 || B2) {
                        isBeing = YES;
                        break;
                    }
                }
            }else{
                for (int i = 0; i < times.count; i++) {
                    isBeing = [self isOverlappingWithTime0:newTime Time1:times[i]];
                    if (isBeing) break; // 发现已存在就结束循环
                }
            }
            
            if (!isBeing) {// 不存在则添加
                timeLB.text = newTime;
                if(self.planVM.timeValueArray.count > section){
    
                    NSMutableArray *muarr0 = [NSMutableArray arrayWithArray:self.planVM.timeValueArray[section]];
                    if(muarr0.count > rowNumb){
                        [muarr0 replaceObjectAtIndex:rowNumb withObject:newTime];
    
                    }
                    [self.planVM.timeValueArray replaceObjectAtIndex:section withObject:muarr0];
                }
            }else{
                [self showToastViewWithTitle:root_bunengchongdie]; // 时间段不能重叠
            }
        }];
    }];
}

- (void)timeisOverStarTimeH:(int)StarH starTimeM:(int)StarM EndTimeH:(int)EndH EndTimeM:(int)EndM :(NSInteger)rowNumb section:(NSInteger)section{
    
    BOOL isOverlapping = NO; // 判断是否已经存在一个跨天的时间段，如果再出现一个就必定重叠
    NSMutableArray *times = [NSMutableArray array];
    // 1. 先通过循环判断是否有跨天时间段，把跨天的拆分成两段去做其他判断
    for (int i = 0; i < self.planVM.timeValueArray.count; i++) {
        NSString *time = self.planVM.timeValueArray[i];
        NSString *startTime = [time componentsSeparatedByString:@"-"][0];// 开始时间
        NSString *endTime = [time componentsSeparatedByString:@"-"][1];// 结束时间
        
        NSArray *starTimes = [startTime componentsSeparatedByString:@":"];
        NSArray *endTimes = [endTime componentsSeparatedByString:@":"];
        
        int starMin = [starTimes[0] intValue]*60 + [starTimes[1] intValue];
        int endMin = [endTimes[0] intValue]*60 + [endTimes[1] intValue];
        
        if (starMin < endMin) {
            [times addObject:time];
        } else{
            isOverlapping = YES;
            [times addObject:[NSString stringWithFormat:@"%@-%@", startTime, @"23:59"]]; // 跨天的情况分两段
            [times addObject:[NSString stringWithFormat:@"%@-%@", @"00:00", endTime]];
        }
    }
    
    // 2. 通过判断区间是否重合,来判断是否有重叠时间
    int starMin0 = StarH*60 + StarM; // 新加时间的开始时间
    int endMin0 = EndH*60 + EndM; // 新加时间的结束时间
    
    if (starMin0 == endMin0) {
        [self showToastViewWithTitle:root_bunengchongdie];// 开始结束时间不能相同
        return ;
    }
    NSString *newTime = [NSString stringWithFormat:@"%d:%d-%d:%d", StarH,StarM, EndH,EndM];

    BOOL isBeing = NO;// 是否已存在该时间段
    if (endMin0 < starMin0) { // 结束时间小于开始时间代表是跨天的时间段
        // 因为出现跨天的情况需要拆成两段时间才能判断  23:00-1:00  ->>  23:00-23:59 ,00:00-01:00
        NSString *newTime1 = [NSString stringWithFormat:@"%d:%d-23:59",StarH,StarM];
        NSString *newTime2 = [NSString stringWithFormat:@"00:00-%d:%d",EndH,EndM];
        for (int i = 0; i < times.count; i++) {
            BOOL B1 = [self isOverlappingWithTime0:newTime1 Time1:times[i]];
            BOOL B2 = [self isOverlappingWithTime0:newTime2 Time1:times[i]];
            if (B1 || B2) {
                isBeing = YES;
                break;
            }
        }
    }else{
        for (int i = 0; i < times.count; i++) {
            isBeing = [self isOverlappingWithTime0:newTime Time1:times[i]];
            if (isBeing) break; // 发现已存在就结束循环
        }
    }
    
    if (!isBeing) {// 不存在则添加
        if(rowNumb < self.planVM.timeValueArray.count){
            
            [self.planVM.timeValueArray replaceObjectAtIndex:rowNumb withObject:newTime];
        }
    }else{
        [self showToastViewWithTitle:root_bunengchongdie]; // 时间段不能重叠
    }
}
// 判断时间段重叠的方法
- (BOOL)isOverlappingWithTime0:(NSString *)time0 Time1:(NSString *)time1{
    BOOL isBeing = NO;// 是否已存在该时间段
    
    // 新时间
    NSArray *arrays0 = [time0 componentsSeparatedByString:@"-"];
    NSArray *starTimes0 = [arrays0[0] componentsSeparatedByString:@":"];
    NSArray *endTimes0 = [arrays0[1] componentsSeparatedByString:@":"];
    
    
    int starMin0 = [starTimes0[0] intValue]*60 + [starTimes0[1] intValue];
    int endMin0 = [endTimes0[0] intValue]*60 + [endTimes0[1] intValue];
    
    // 已存在的时间
    NSArray *arrays1 = [time1 componentsSeparatedByString:@"-"];
    NSArray *starTimes1 = [arrays1[0] componentsSeparatedByString:@":"];
    NSArray *endTimes1 = [arrays1[1] componentsSeparatedByString:@":"];
    
    int starMin1 = [starTimes1[0] intValue]*60 + [starTimes1[1] intValue];
    int endMin1 = [endTimes1[0] intValue]*60 + [endTimes1[1] intValue];
    
    // 通过判断区间是否包含来确定是否时间段重合
    if ((starMin1 < starMin0 && starMin0 < endMin1) || (starMin1 < endMin0 && endMin0 < endMin1) || (starMin0 < starMin1 && starMin1 < endMin0) || (starMin0 < endMin1 && endMin1 < endMin0) || ((starMin0 == starMin1) && (endMin0 == endMin1)) ||  starMin1 == endMin0) {
            isBeing = YES;
    }
    
    return isBeing;
}

- (BOOL)isBetweenDateWith:(NSString *)time0 Time1:(NSString *)time1{
    //设置的是中国时间
    NSString *startTime=@"13:01";
    NSString *expireTime=@"20:01";
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString * todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    today=[ dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    NSLog(@"today today ==%@",today);
    NSLog(@"start start ==%@",start);
    NSLog(@"expire expire ==%@",expire);
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    else{
        return NO;
    }
    return NO;
}



- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.detailsLabelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}




#pragma mark 懒加载
- (UITableView *) plantTableView {
    if (!_plantTableView) {
        _plantTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
        _plantTableView.showsVerticalScrollIndicator = NO;
        _plantTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _plantTableView.delegate = self;
        _plantTableView.dataSource = self;
        _plantTableView.backgroundColor = [UIColor whiteColor];
        _plantTableView.separatorStyle = NO;
    }
    return _plantTableView;
}

-(PlantSettingViewModel *)planVM {
    if (!_planVM) {
        _planVM = [[PlantSettingViewModel alloc]initViewModel];
        _planVM.deviceStr = self.deviceSnStr;
    }
    return _planVM;
}

@end
