//
//  WeDeviceSetVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/31.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WePlanModeVC.h"
#import "WePCSDJCell.h"
#import "WeDeviceListVC.h"
#import "USSetValueAlterView.h"
#import "CGXPickerView.h"

@interface WePlanModeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *conTable;
@property (nonatomic, strong)NSMutableArray *TimeValueArray;
@property (nonatomic, strong)NSMutableArray *PeakValueArray;

@property (nonatomic, strong)NSMutableArray *peekKeyArray;
@property (nonatomic, strong)NSMutableArray *timeKeyArray;

@property (nonatomic, strong)USSetValueAlterView *viewAlert;
@property (nonatomic, strong)NSString *paramName;
@property (nonatomic, strong)NSString *paramValue;

@end

@implementation WePlanModeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Plant Mode";
    [self createNameArr];
    // Do any additional setup after loading the view.
}

- (void)createNameArr{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];

    _PeakValueArray = [NSMutableArray array];
    _TimeValueArray = [NSMutableArray array];
    
    _PeakValueArray = [NSMutableArray arrayWithArray:@[@[@"0.0kW",@"0.0kW",@"0.0kW",@"0.0kW"],@[@"0.0kW",@"0.0kW",@"0.0kW",@"0.0kW"]]];
    _TimeValueArray = [NSMutableArray arrayWithArray:@[@[@"00:00-00:00",@"00:00-00:00",@"00:00-00:00",@"00:00-00:00"],@[@"00:00-00:00",@"00:00-00:00",@"00:00-00:00",@"00:00-00:00"]]];
    _peekKeyArray = [NSMutableArray arrayWithArray:@[@[@"chargePower1",@"chargePower2",@"chargePower3",@"chargePower4"],@[@"dischargePower1",@"dischargePower2",@"dischargePower3",@"dischargePower4"]]];
    _timeKeyArray = [NSMutableArray arrayWithArray:@[@[@"batteryChargingTime1",@"batteryChargingTime2",@"batteryChargingTime3",@"batteryChargingTime4"],@[@"batteryDischargingTime1",@"batteryDischargingTime2",@"batteryDischargingTime3",@"batteryDischargingTime4"]]];

    [self createSetUI];
    [self GetDataClick];
    
}

- (void)createSetUI{
    
    
    
    _conTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
    _conTable.delegate = self;
    _conTable.dataSource = self;
    _conTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_conTable];
    
    [_conTable registerClass:[WePCSDJCell class] forCellReuseIdentifier:@"USSETCELL"];
    
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        [self GetDataClick];

    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    header2.stateLabel.hidden = YES;
    _conTable.mj_header = header2;
    
    _viewAlert = [[USSetValueAlterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight)];
    [self.view addSubview:_viewAlert];
    _viewAlert.hidden = YES;
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _PeakValueArray.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *onepeakArr = _PeakValueArray[section];
    return onepeakArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WePCSDJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"USSETCELL" forIndexPath:indexPath];
    if (!cell) {
        cell = [[WePCSDJCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WePCSDJCellID"];
        
    }
    cell.leftNameLB.text = @"Power";
    cell.headimg.image = IMAGE(@"WePlanListIcon");
    if(indexPath.section == 0){
        
        cell.RighLB.text = @"Battery Charging";

    }else{
        cell.RighLB.text = @"Discharging";

        
    }
    NSArray *powerArr = _PeakValueArray[indexPath.section];
    NSArray *timeArr = _TimeValueArray[indexPath.section];

    if(indexPath.row < powerArr.count){
        cell.peekLB.text = [NSString stringWithFormat:@"%@kW",powerArr[indexPath.row]];

    }
    if(indexPath.row < timeArr.count){
        cell.timeLB.text = timeArr[indexPath.row];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.peekSendBlock = ^(UILabel * _Nonnull peekVLB) {
        [self peekClick:peekVLB indexRow:indexPath.row section:indexPath.section];
    };
    cell.timeSendBlock = ^(UILabel * _Nonnull timeVLB) {
        
        [self timeClick:timeVLB indexRow:indexPath.row section:indexPath.section];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)peekClick:(UILabel *)peekLB indexRow:(NSInteger)rowNumb section:(NSInteger)section{
    
    
    if (_viewAlert) {

        _viewAlert.hidden = NO;
        
        NSString *removeDanweistr = [self removeDanwei:peekLB.text danweiStr:@"kW"];
        __weak typeof(self) weakself = self;
        
        _viewAlert.valueTF.keyboardType = UIKeyboardTypeNumberPad;
        [_viewAlert valueSet:removeDanweistr fanwei:@"" danwei:@"kW" titleStr:@"Power"];
        
        _viewAlert.valueBlock = ^(NSString * _Nonnull valuestr) {
            NSString *peekstrr = [NSString stringWithFormat:@"%@",valuestr];

            peekLB.text = [NSString stringWithFormat:@"%@kW",valuestr];
            
            if(weakself.PeakValueArray.count > section){
                
                NSMutableArray *muarr0 = [NSMutableArray arrayWithArray:weakself.PeakValueArray[section]];
                if(muarr0.count > rowNumb){
                    [muarr0 replaceObjectAtIndex:rowNumb withObject:peekstrr];
                    
                }
                [weakself.PeakValueArray replaceObjectAtIndex:section withObject:muarr0];

            }
            
           
            
        };
        
        
    }
}

- (NSString *)removeDanwei:(NSString *)string danweiStr:(NSString *)danwei{
    
    NSArray *conarr = [string componentsSeparatedByString:danwei];
    return conarr.firstObject;
    
}

- (void)timeClick:(UILabel *)timeLB indexRow:(NSInteger)rowNumb section:(NSInteger)section{
    
    NSMutableArray *hourData = [[NSMutableArray alloc]init];
    NSMutableArray *minData = [[NSMutableArray alloc]init];
    NSMutableArray *secondData = [[NSMutableArray alloc]init];
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
//    for (int i = 0; i < 60; i++) {
//        if (i < 10) {
//            [secondData addObject:[NSString stringWithFormat:@"0%d",i]];
//
//        }else{
//            [secondData addObject:[NSString stringWithFormat:@"%d",i]];
//
//        }
//
//    }
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

//            NSArray *starArr2 = (NSArray *)selectValue2;
//            int StarH = [starArr[0] intValue];
//            int StarM = [starArr[1] intValue];
//            int EndH = [starArr2[0] intValue];
//            int EndM = [starArr2[1] intValue];
            
//            if ([starArr[0] intValue] < 10) {
//
//                starArr[0] = [NSString stringWithFormat:@"0%@",starArr[0]];
//            }
//            if ([starArr[1] intValue] < 10) {
//
//                starArr[1] = [NSString stringWithFormat:@"0%@",starArr[1]];
//            }
//            if ([starArr2[0] intValue] < 10) {
//
//                starArr2[0] = [NSString stringWithFormat:@"0%@",starArr2[0]];
//            }
//            if ([starArr2[1] intValue] < 10) {
//
//                starArr2[1] = [NSString stringWithFormat:@"0%@",starArr2[1]];
//            }
            
            NSArray *onearr = _TimeValueArray[section];
    
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

            BOOL isBeing = NO;// 是否已存在该时间段
            if (endMin0 < starMin0) { // 结束时间小于开始时间代表是跨天的时间段
                // 判断是否已经存在一个跨天的时间段，如果再出现一个就必定重叠
        //        if (isOverlapping) {
        //            [self showToastViewWithTitle:root_bunengchongdie]; // 时间段不能重叠
        //            return ;
        //        }
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
                if(self.TimeValueArray.count > section){
    
                    NSMutableArray *muarr0 = [NSMutableArray arrayWithArray:self.TimeValueArray[section]];
                    if(muarr0.count > rowNumb){
                        [muarr0 replaceObjectAtIndex:rowNumb withObject:newTime];
    
                    }
                    [self.TimeValueArray replaceObjectAtIndex:section withObject:muarr0];
    
                }

            }else{
                [self showToastViewWithTitle:root_bunengchongdie]; // 时间段不能重叠
            }
            
            
//            NSArray *starArr = (NSArray *)selectValue;
//            NSString *starstr = [starArr componentsJoinedByString:@":"];
//            
//            NSArray *starArr2 = (NSArray *)selectValue2;
//            NSString *starstr2 = [starArr2 componentsJoinedByString:@":"];
//            NSString *timestrr = [NSString stringWithFormat:@"%@-%@",starstr,starstr2];
//            timeLB.text = timestrr;
//            
//            if(self.TimeValueArray.count > section){
//                
//                NSMutableArray *muarr0 = [NSMutableArray arrayWithArray:self.TimeValueArray[section]];
//                if(muarr0.count > rowNumb){
//                    [muarr0 replaceObjectAtIndex:rowNumb withObject:timestrr];
//                    
//                }
//                [self.TimeValueArray replaceObjectAtIndex:section withObject:muarr0];
//
//            }
          
        }];

    }];

            
//    [CGXPickerView showDatePickerWithTitle:@"Select time" DateType:UIDatePickerModeDateAndTime DefaultSelValue:timeLB.text MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
//        timeLB.text = selectValue;
//    }];
            
    
    
}

- (void)timeisOverStarTimeH:(int)StarH starTimeM:(int)StarM EndTimeH:(int)EndH EndTimeM:(int)EndM :(NSInteger)rowNumb section:(NSInteger)section{
    
    
    
    BOOL isOverlapping = NO; // 判断是否已经存在一个跨天的时间段，如果再出现一个就必定重叠
    NSMutableArray *times = [NSMutableArray array];
    // 1. 先通过循环判断是否有跨天时间段，把跨天的拆分成两段去做其他判断
    for (int i = 0; i < _TimeValueArray.count; i++) {
        NSString *time = _TimeValueArray[i];
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
        // 判断是否已经存在一个跨天的时间段，如果再出现一个就必定重叠
//        if (isOverlapping) {
//            [self showToastViewWithTitle:root_bunengchongdie]; // 时间段不能重叠
//            return ;
//        }
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
        if(rowNumb < self.TimeValueArray.count){
            
            [self.TimeValueArray replaceObjectAtIndex:rowNumb withObject:newTime];
        }
//        [self.TimeValueArray replaceObjectAtIndex:rowNumb withObject:newTime];

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




- (void)saveClick{
    
    if (kStringIsEmpty(_devSN)) {
        [self showToastViewWithTitle:HEM_meiyoushebei];
        return;
    }
    
    NSMutableArray *sendArr = [[NSMutableArray alloc]init];

    NSString *allSendStr = @"";
    if(_PeakValueArray.count == _TimeValueArray.count){
        for (int i = 0; i < _PeakValueArray.count; i++) {
            
            NSArray *peakoneArr = _PeakValueArray[i];
            NSArray *timeoneArr = _TimeValueArray[i];
            
            for (int t = 0; t < peakoneArr.count; t++) {
                NSString *onepeek = peakoneArr[t];
                NSString *onetime = timeoneArr[t];

                NSString *oneSend = [NSString stringWithFormat:@"%@-%@",onepeek,onetime];
                [sendArr addObject:oneSend];
            }

            
        }
        allSendStr = [sendArr componentsJoinedByString:@"#"];
    }else{
        return;
    }
    
    [self showProgressView];

    [RedxBaseRequest myHttpPost:@"/v1/manager/setPlantModel" parameters:@{@"deviceSn":_devSN,@"paramName":@"setPlantModel",@"paramValue":allSendStr} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];


        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];


        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                [self GetDataClick];

            }
//
        }

    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
- (void)GetDataClick{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/manager/getPlanningModeInfo" parameters:@{@"deviceSn":_devSN} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];


        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];


        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {

                id obj = datadic[@"obj"];
                if([obj isKindOfClass:[NSDictionary class]]){
                    
                    NSDictionary *objDic = (NSDictionary *)obj;
                    _PeakValueArray = [NSMutableArray array];
                    _TimeValueArray = [NSMutableArray array];
                    for (int i = 0; i < self.peekKeyArray.count; i ++) {
                        
                        NSArray *onekeyArr = self.peekKeyArray[i];
                        NSArray *onetimekeyArr = self.timeKeyArray[i];
                        
                        NSMutableArray *peekVArr = [[NSMutableArray alloc]init];
                        NSMutableArray *timeVArr = [[NSMutableArray alloc]init];


                        for (int t = 0; t<onekeyArr.count; t++) {
                            NSString *peekoneKey = onekeyArr[t];
                            NSString *timeoneKey = onetimekeyArr[t];

                            NSString *peekValue = [NSString stringWithFormat:@"%@",objDic[peekoneKey]];
                            NSString *timeValue = [NSString stringWithFormat:@"%@",objDic[timeoneKey]];

                            if(kStringIsEmpty(peekValue)){
                                peekValue = @"";
                            }
                            if(kStringIsEmpty(timeValue)){
                                timeValue = @"";

                            }
                            [peekVArr addObject:peekValue];
                            [timeVArr addObject:timeValue];
                        }
                        
                        [_PeakValueArray addObject:peekVArr];
                        [_TimeValueArray addObject:timeVArr];
                    }
                    
                    
                    [self.conTable reloadData];
                }

            }
//
        }

    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
@end
