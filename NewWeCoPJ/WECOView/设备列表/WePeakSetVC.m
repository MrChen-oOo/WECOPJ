//
//  WeDeviceSetVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/31.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WePeakSetVC.h"
#import "WePCSDJCell.h"
#import "WeDeviceListVC.h"
#import "USSetValueAlterView.h"
#import "CGXPickerView.h"

@interface WePeakSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *conTable;
@property (nonatomic, strong)NSMutableArray *TimeValueArray;
@property (nonatomic, strong)NSMutableArray *PeakValueArray;

@property (nonatomic, strong)NSMutableArray *peekKeyArray;
@property (nonatomic, strong)NSMutableArray *timeKeyArray;

@property (nonatomic, strong)USSetValueAlterView *viewAlert;
@property (nonatomic, strong)NSString *paramName;
@property (nonatomic, strong)NSString *paramValue;
@property (nonatomic, strong)NSString *unitStr;

@end

@implementation WePeakSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Electrovalence Setting";
    [self createNameArr];
    // Do any additional setup after loading the view.
}

- (void)createNameArr{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];

    _PeakValueArray = [NSMutableArray array];
    _TimeValueArray = [NSMutableArray array];
    
    _unitStr = @"CNY";
    _PeakValueArray = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0"]];
    _TimeValueArray = [NSMutableArray arrayWithArray:@[@"00:00-00:00",@"00:00-00:00",@"00:00-00:00",@"00:00-00:00"]];
    
    _peekKeyArray = [NSMutableArray arrayWithArray:@[@"peakPrice1",@"peakPrice2",@"peakPrice3",@"peakPrice4",]];
    _timeKeyArray = [NSMutableArray arrayWithArray:@[@"time1",@"time2",@"time3",@"time4",]];

    [self createSetUI];
    [self GetDataClick];
    
}

- (void)createSetUI{
    
    
    
    _conTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 10*HEIGHT_SIZE, kScreenWidth, kScreenHeight - kNavBarHeight-10*HEIGHT_SIZE) style:UITableViewStylePlain];
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
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peekKeyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WePCSDJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"USSETCELL" forIndexPath:indexPath];
    if (!cell) {
        cell = [[WePCSDJCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WePCSDJCellID"];
        
    }
    if(indexPath.row < self.PeakValueArray.count){
        NSString *peekstr = self.PeakValueArray[indexPath.row];
        if([peekstr containsString:_unitStr]){
            
            cell.peekLB.text = peekstr;

        }else{
            cell.peekLB.text = [NSString stringWithFormat:@"%@%@",peekstr,_unitStr];

        }

    }
    if(indexPath.row < self.TimeValueArray.count){
        cell.timeLB.text = self.TimeValueArray[indexPath.row];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.peekSendBlock = ^(UILabel * _Nonnull peekVLB) {
        [self peekClick:peekVLB indexRow:indexPath.row];
    };
    cell.timeSendBlock = ^(UILabel * _Nonnull timeVLB) {
        
        [self timeClick:timeVLB indexRow:indexPath.row];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)peekClick:(UILabel *)peekLB indexRow:(NSInteger)rowNumb{
    
    
    if (_viewAlert) {

        _viewAlert.hidden = NO;
        
        NSString *removeDanweistr = [self removeDanwei:peekLB.text danweiStr:_unitStr];
        __weak typeof(self) weakself = self;
        
        [_viewAlert valueSet:removeDanweistr fanwei:@"" danwei:_unitStr titleStr:@"Peek Price"];
        
        _viewAlert.valueBlock = ^(NSString * _Nonnull valuestr) {
            NSString *peekstrr = [NSString stringWithFormat:@"%@%@",valuestr,weakself.unitStr];

            peekLB.text = [NSString stringWithFormat:@"%@%@",valuestr,weakself.unitStr];
            if(rowNumb < self.PeakValueArray.count){
                
                [weakself.PeakValueArray replaceObjectAtIndex:rowNumb withObject:peekstrr];
            }
            
        };
        
        
    }
}

- (NSString *)removeDanwei:(NSString *)string danweiStr:(NSString *)danwei{
    
    NSArray *conarr = [string componentsSeparatedByString:danwei];
    return conarr.firstObject;
    
}

- (void)timeClick:(UILabel *)timeLB indexRow:(NSInteger)rowNumb{
    
    NSMutableArray *hourData = [[NSMutableArray alloc]init];
    NSMutableArray *minData = [[NSMutableArray alloc]init];
//    NSMutableArray *secondData = [[NSMutableArray alloc]init];
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
            
            
            NSArray *starArr = (NSArray *)selectValue;
            NSString *starstr = [starArr componentsJoinedByString:@":"];
            
            NSArray *starArr2 = (NSArray *)selectValue2;
            NSString *starstr2 = [starArr2 componentsJoinedByString:@":"];
            
            
//            [self timeisOverStarTimeH:[starArr[0] intValue] starTimeM:[starArr[1] intValue] EndTimeH:[starArr2[0] intValue] EndTimeM:[starArr2[1] intValue] :rowNumb];

            
            NSString *timestrr = [NSString stringWithFormat:@"%@-%@",starstr,starstr2];
            timeLB.text = timestrr;
            if(rowNumb < self.TimeValueArray.count){

                [self.TimeValueArray replaceObjectAtIndex:rowNumb withObject:timestrr];
            }
        }];

    }];

            
//    [CGXPickerView showDatePickerWithTitle:@"Select time" DateType:UIDatePickerModeDateAndTime DefaultSelValue:timeLB.text MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
//        timeLB.text = selectValue;
//    }];
            
    
    
}

- (void)timeisOverStarTimeH:(int)StarH starTimeM:(int)StarM EndTimeH:(int)EndH EndTimeM:(int)EndM :(NSInteger)rowNumb{
    
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
    if ((starMin1 < starMin0 && starMin0 < endMin1) || (starMin1 < endMin0 && endMin0 < endMin1) || (starMin0 < starMin1 && starMin1 < endMin0) || (starMin0 < endMin1 && endMin1 < endMin0) || ((starMin0 == starMin1) && (endMin0 == endMin1)) || starMin0 == endMin1 || starMin1 == endMin0) {
            isBeing = YES;
    }
    
    return isBeing;
}

- (void)saveClick{
    
    NSMutableArray *sendArr = [[NSMutableArray alloc]init];
    NSString *allSendStr = @"";
    if(_PeakValueArray.count == _TimeValueArray.count){
        for (int i = 0; i < _PeakValueArray.count; i++) {
            NSString *onepeek = _PeakValueArray[i];
            NSArray *peekarr = [onepeek componentsSeparatedByString:_unitStr];
            onepeek = peekarr.firstObject;
            NSString *onetime = _TimeValueArray[i];

            NSString *oneSend = [NSString stringWithFormat:@"%@-%@",onepeek,onetime];
            [sendArr addObject:oneSend];
        }
        allSendStr = [sendArr componentsJoinedByString:@"#"];
    }else{
        return;
    }
    
    [self showProgressView];

    [RedxBaseRequest myHttpPost:@"/v1/manager/elecSetting" parameters:@{@"pcsID":_devSN,@"paramName":@"elecSetting",@"paramValue":allSendStr} Method:HEAD_URL success:^(id responseObject) {
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
    
    [RedxBaseRequest myHttpPost:@"/v1/manager/getPcsSetInfo" parameters:@{@"pcsID":_devSN} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self.conTable.mj_header endRefreshing];


        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];


        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {

                id obj = datadic[@"obj"];
                if([obj isKindOfClass:[NSDictionary class]]){
                    
                    NSDictionary *objDic = (NSDictionary *)obj;
                    
                    _unitStr = [NSString stringWithFormat:@"%@",objDic[@"priceUnit"]];
                    
                    _PeakValueArray = [NSMutableArray array];
                    _TimeValueArray = [NSMutableArray array];
                    
                    for (int i = 0; i < self.peekKeyArray.count; i ++) {
                        
                        NSString *peekoneKey = self.peekKeyArray[i];
                        NSString *timeoneKey = self.timeKeyArray[i];

                        NSString *peekValue = [NSString stringWithFormat:@"%@",objDic[peekoneKey]];
                        NSString *timeValue = [NSString stringWithFormat:@"%@",objDic[timeoneKey]];

                        if(kStringIsEmpty(peekValue)){
                            peekValue = @"--";
                        }
                        if(kStringIsEmpty(timeValue)){
                            timeValue = @"--";

                        }
                        [_PeakValueArray addObject:peekValue];
                        [_TimeValueArray addObject:timeValue];
                    }
                    
                    
                    [self.conTable reloadData];
                }

            }
//
        }

    } failure:^(NSError *error) {
        [self hideProgressView];
        [self.conTable.mj_header endRefreshing];

    }];
}
@end
