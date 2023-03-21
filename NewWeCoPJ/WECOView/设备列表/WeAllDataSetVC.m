//
//  WeDeviceSetVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/31.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeAllDataSetVC.h"
#import "USSet1Cell.h"
#import "WeDeviceListVC.h"
#import "USSetValueAlterView.h"
#import "CGXPickerView.h"
#import "BRPickerView.h"
@interface WeAllDataSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *conTable;
@property (nonatomic, strong)NSArray *nameArray;
@property (nonatomic, strong)USSetValueAlterView *viewAlert;
@property (nonatomic, strong)NSArray *KeyArray;
@property (nonatomic, strong)NSArray *KeyArray22;
@property (nonatomic, strong)NSArray *danweiArr;

@property (nonatomic, strong)NSString *paramName;
@property (nonatomic, strong)NSString *paramValue;
@property (nonatomic, strong)NSDictionary *ValueDic;

@end

@implementation WeAllDataSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titNameStr;
    [self createNameArr];
    [self GetDevSetData];

    // Do any additional setup after loading the view.
}

- (void)createNameArr{
    
    if([_deviceType isEqualToString:@"1"]){
        
        
        
        
        if([_titNameStr isEqualToString:@"Protect Parameters"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"Max SOC",
                @"On-Grid SOC Low Limit",
                @"Off-Grid SOC Low Limit",
                @"SOC For Shutdown"
//                @"Backup SOC"
              
            ]];// @"SOC Dead Zone",
            _KeyArray = @[@"batterySOCLimit",@"gridSOCLowerLimit",@"OffGridSOCLowerLimit",@"ShutdownSOCLimit"];//,@"socReturnDifference"
            
            _KeyArray22 = @[@"maxSoc",@"onGridSocLowLimit",@"offGridSocLowLimit",@"socForShutdown"];//,@"backupSoc"
            _danweiArr = @[@"%",@"%",@"%",@"%"];//,@"%"
            
        }
        if([_titNameStr isEqualToString:@"Operation Control"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"System Shutdown",
                @"System Boot"
           
              
            ]];// @"SOC Dead Zone",
            _KeyArray = @[@"systemUpOff",@"systemUpOff"];//设置的key
            _KeyArray22 = @[@"",@""];//读取的key
            _danweiArr = @[@"",@""];//单位


        }
        if([_titNameStr isEqualToString:@"Grid Power"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"Grid Power",
           
              
            ]];// @"SOC Dead Zone",
            _KeyArray = @[@"capacityOfTransformer"];
            _KeyArray22 = @[@"gridPower"];
            _danweiArr = @[@"kW"];


        }
        
        if([_titNameStr isEqualToString:@"System time"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"System time",
              
            ]];
            _KeyArray = @[@"syncTime"];
            _KeyArray22 = @[@"systemTime"];
            _danweiArr = @[@""];
            
        }

        
    }
    if([_deviceType isEqualToString:@"4"]){
        if([_titNameStr isEqualToString:@"Grid Power"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"Grid Power",
//                @"Grid Code"
           
              
            ]];// @"SOC Dead Zone",
            _KeyArray = @[@"gridPower"];
            _KeyArray22 = @[@"gridPower"];
            _danweiArr = @[@"%"];


        }
        if([_titNameStr isEqualToString:@"Protect Parameters"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"On-Grid Discharge Depth",
                @"Off-Grid  Discharge Depth",
                @"Bat.Charge Current",
                @"Bat.EodHyst"
              
            ]];// @"SOC Dead Zone",
            _KeyArray = @[@"batGridDod",@"offGridDod",@"batChargeCurrent",@"batEodHyst"];
            _KeyArray22 = @[@"onGridDischargeDepth",@"offGridDischargeDepth",@"batChargeCurrent",@"batEodHyst"];
            _danweiArr = @[@"%",@"%",@"A",@"%"];

        }
        
        if([_titNameStr isEqualToString:@"System Setting"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"System time",
                @"Bat.Wake Up",
                @"Anti Reverse",@"Bat discharge power",@"CT Ratio",@"EPS/Backup Enable",@"On/Off Enable"
              
            ]];// @"SOC Dead Zone",
            _KeyArray = @[@"systemTimeSet",@"batteryAwaken",@"antiReflux",@"batDischargePower",@"ctRatio",@"epsBackupEnable",@"onOffButtonEn"];
            _KeyArray22 = @[@"systemTime",@"batWakeUp",@"antiReverse",@"batDischargePower",@"ctRatio",@"epsBackupEnable",@"onOffEnable"];
            _danweiArr = @[@"",@"",@"",@"%",@"",@"",@""];


        }
        
        if([_titNameStr isEqualToString:@"Operation Control"]){
            _nameArray=[NSMutableArray arrayWithArray:@[
                @"System Shutdown",
                @"System Boot"
           
              
            ]];// @"SOC Dead Zone",
            _KeyArray = @[@"onOffButtonEn",@"onOffButtonEn"];//设置的key
            _KeyArray22 = @[@"",@""];//读取的key
            _danweiArr = @[@"",@""];//单位


        }
    }
    
    [self createSetUI];
}

- (void)createSetUI{
    
    
    
    _conTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStylePlain];
    _conTable.delegate = self;
    _conTable.dataSource = self;
    _conTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_conTable];
    
    [_conTable registerClass:[USSet1Cell class] forCellReuseIdentifier:@"USSETCELL"];
    
    
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        [self GetDevSetData];

        
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
    return _nameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    USSet1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"USSETCELL" forIndexPath:indexPath];
    if (!cell) {
        cell = [[USSet1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"USSETCELL"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *namestr = _nameArray[indexPath.row];
    NSString *keystr = _KeyArray22[indexPath.row];
    NSString *danweistr = _danweiArr[indexPath.row];

    cell.titleLB.text = namestr;
    cell.onoffBtn.hidden = YES;
    cell.rightIMG.hidden = NO;
    cell.valueLB.hidden = NO;
    
    
    CGSize textSize = [self getStringSize:14*HEIGHT_SIZE Wsize:kScreenWidth-80*NOW_SIZE Hsize:cell.titleLB.xmg_height stringName:namestr];
    cell.titleLB.xmg_width = textSize.width+20*NOW_SIZE;
    cell.valueLB.xmg_x = CGRectGetMaxX(cell.titleLB.frame);
    cell.valueLB.xmg_width = kScreenWidth-CGRectGetMaxX(cell.titleLB.frame)-10*NOW_SIZE-20*HEIGHT_SIZE;
    
    if([_deviceType isEqualToString:@"4"]){
//        @"System time",
//        @"Bat.Wake Up",
//        @"Anti Reverse",@"Bat discharge power",@"CT Ratio",@"EPS/Backup Enable",@"On/Off Enable"
        
        if([namestr isEqualToString:@"Bat.Wake Up"] || [namestr isEqualToString:@"Anti Reverse"] || [namestr isEqualToString:@"EPS/Backup Enable"] || [namestr isEqualToString:@"On/Off Enable"]){
            
            cell.onoffBtn.hidden = NO;
            cell.rightIMG.hidden = YES;
            cell.valueLB.hidden = YES;
            NSString *valustr = [NSString stringWithFormat:@"%@",_ValueDic[keystr]];

            if([valustr isEqualToString:@"1"]){
                
                cell.onoffBtn.selected = YES;
            }else{
                cell.onoffBtn.selected = NO;

            }
            cell.onoffBtn.tag = 6000+indexPath.row;
            [cell.onoffBtn addTarget:self action:@selector(onoffClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            NSString *valustr = [NSString stringWithFormat:@"%@",_ValueDic[keystr]];
            if(!kStringIsEmpty(valustr)){
                
                cell.valueLB.text = [NSString stringWithFormat:@"%@%@",valustr,danweistr];
            }
        }
    }else{
        
        if([_deviceType isEqualToString:@"1"]){
            
            if([_titNameStr isEqualToString:@"Grid Power"]){
                cell.onoffBtn.hidden = YES;
                cell.rightIMG.hidden = NO;
                cell.valueLB.hidden = NO;
            }
            
        }
        
        NSString *valustr = [NSString stringWithFormat:@"%@",_ValueDic[keystr]];
        if(!kStringIsEmpty(valustr)){
            
            cell.valueLB.text = [NSString stringWithFormat:@"%@%@",valustr,danweistr];
        }
    }
    
 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *namestr = _nameArray[indexPath.row];
    _paramName = _KeyArray[indexPath.row];
//    NSString *keystr = _KeyArray[indexPath.row];
    NSString *keystr22 = _KeyArray22[indexPath.row];

    NSString *valustr = [NSString stringWithFormat:@"%@",_ValueDic[keystr22]];
    if(kStringIsEmpty(_paramName)){
        
        return;
    }
    if([_deviceType isEqualToString:@"1"]){
        
//        if([_titNameStr isEqualToString:@"Grid Parameters"]){
//            return;
//        }
        if([_titNameStr isEqualToString:@"System time"]){
            
            
            NSString *defValue = valustr;
            // 1.创建日期选择器
            BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
            // 2.设置属性
            datePickerView.pickerMode = BRDatePickerModeYMDHMS;
            datePickerView.title = root_xuanzeshijian;
            datePickerView.selectValue = defValue;//@"2019-10-30";
        //    datePickerView.selectDate = [NSDate br_setYear:2019 month:10 day:30];
            datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
//            datePickerView.maxDate = [NSDate date];
            datePickerView.isAutoSelect = NO;
            datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                NSLog(@"选择的值：%@", selectValue);
                
                self.paramValue = selectValue;//[NSString stringWithFormat:@"%@:00",selectValue];
                [self SystemTimeSetData];
                
            };
            // 设置自定义样式
            BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
            customStyle.pickerColor = WhiteColor;//BR_RGB_HEX(0xd9dbdf, 1.0f);
            customStyle.pickerTextColor = colorBlack;//[UIColor redColor];
            customStyle.separatorColor = colorblack_186;//[UIColor redColor];
            datePickerView.pickerStyle = customStyle;

            // 3.显示
            [datePickerView show];
            
            
            
            return;
        }
        
        
        if([namestr isEqualToString:@"System Shutdown"]){
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"System Shutdown" message:@"1.After the system is shut down,all system operation will be stopped,please operate with caution!\n2.Please enter the password" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subview1 = alvc.view.subviews[0];
            UIView *subview2 = subview1.subviews[0];
            UIView *subview3 = subview2.subviews[0];
            UIView *subview4 = subview3.subviews[0];
            UIView *subview5 = subview4.subviews[0];

            UILabel *messageLB = subview5.subviews[2];
            messageLB.textAlignment = NSTextAlignmentLeft;
            
            [alvc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"Please enter...";
            }];
            
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *firtext = alvc.textFields.firstObject;

                self.paramValue = @"1";
                [self DevSetData];
                
            }]];
            [self presentViewController:alvc animated:YES completion:nil];

           
            return;
        }
        if([namestr isEqualToString:@"System Boot"]){
            
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"System Boot" message:@"1.After the system is shut down,all system operation will be stopped,please operate with caution!\n2.Please enter the password" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subview1 = alvc.view.subviews[0];
            UIView *subview2 = subview1.subviews[0];
            UIView *subview3 = subview2.subviews[0];
            UIView *subview4 = subview3.subviews[0];
            UIView *subview5 = subview4.subviews[0];

            UILabel *messageLB = subview5.subviews[2];
            messageLB.textAlignment = NSTextAlignmentLeft;
            
            [alvc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"Please enter...";
            }];
            
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *firtext = alvc.textFields.firstObject;

                self.paramValue = @"3";
                [self DevSetData];
                
            }]];
            
            [self presentViewController:alvc animated:YES completion:nil];

            return;
        }

    }
    if([_deviceType isEqualToString:@"4"]){

        if([namestr isEqualToString:@"Bat.Wake Up"] || [namestr isEqualToString:@"Anti Reverse"] || [namestr isEqualToString:@"EPS/Backup Enable"] || [namestr isEqualToString:@"On/Off Enable"]){
            
            return;
        };
        
        if([namestr isEqualToString:@"System time"]){
            
//            [CGXPickerView showDatePickerWithTitle:@"Select time" DateType:UIDatePickerModeDateAndTime DefaultSelValue:valustr MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
//
//                self.paramValue = [NSString stringWithFormat:@"%@:00",selectValue];
//                [self SystemTimeSetData];
//            }];
            
            NSString *defValue = valustr;
            // 1.创建日期选择器
            BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
            // 2.设置属性
            datePickerView.pickerMode = BRDatePickerModeYMDHMS;
            datePickerView.title = root_xuanzeshijian;
            datePickerView.selectValue = defValue;//@"2019-10-30";
        //    datePickerView.selectDate = [NSDate br_setYear:2019 month:10 day:30];
            datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
//            datePickerView.maxDate = [NSDate date];
            datePickerView.isAutoSelect = NO;
            datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                NSLog(@"选择的值：%@", selectValue);
                
                self.paramValue = selectValue;//[NSString stringWithFormat:@"%@:00",selectValue];
                [self SystemTimeSetData];
                
            };
            // 设置自定义样式
            BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
            customStyle.pickerColor = WhiteColor;//BR_RGB_HEX(0xd9dbdf, 1.0f);
            customStyle.pickerTextColor = colorBlack;//[UIColor redColor];
            customStyle.separatorColor = colorblack_186;//[UIColor redColor];
            datePickerView.pickerStyle = customStyle;

            // 3.显示
            [datePickerView show];
            
            
            
            return;
        }
        
        if([namestr isEqualToString:@"System Shutdown"]){
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"System Shutdown" message:@"1.After the system is shut down,all system operation will be stopped,please operate with caution!\n2.Please enter the password" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subview1 = alvc.view.subviews[0];
            UIView *subview2 = subview1.subviews[0];
            UIView *subview3 = subview2.subviews[0];
            UIView *subview4 = subview3.subviews[0];
            UIView *subview5 = subview4.subviews[0];

            UILabel *messageLB = subview5.subviews[2];
            messageLB.textAlignment = NSTextAlignmentLeft;
            
            [alvc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"Please enter...";
            }];
            
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *firtext = alvc.textFields.firstObject;

                self.paramValue = @"0";
                [self DevSetData];
                
            }]];
            [self presentViewController:alvc animated:YES completion:nil];

            return;
        }
        if([namestr isEqualToString:@"System Boot"]){
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"System Boot" message:@"1.After the system is shut down,all system operation will be stopped,please operate with caution!\n2.Please enter the password" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subview1 = alvc.view.subviews[0];
            UIView *subview2 = subview1.subviews[0];
            UIView *subview3 = subview2.subviews[0];
            UIView *subview4 = subview3.subviews[0];
            UIView *subview5 = subview4.subviews[0];

            UILabel *messageLB = subview5.subviews[2];
            messageLB.textAlignment = NSTextAlignmentLeft;
            
            [alvc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"Please enter...";
            }];
            
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *firtext = alvc.textFields.firstObject;

                self.paramValue = @"1";
                [self DevSetData];
                
            }]];
            [self presentViewController:alvc animated:YES completion:nil];

            return;
        }
    }

    if (_viewAlert) {
//        NSString *fanweiStr = @"";
//        NSString *danweiStr = @"";

        NSString *danweistr = _danweiArr[indexPath.row];


        _viewAlert.hidden = NO;
        __weak typeof(self) weakself = self;
        [_viewAlert valueSet:valustr fanwei:@"" danwei:danweistr titleStr:namestr];
        
        _viewAlert.valueBlock = ^(NSString * _Nonnull valuestr) {
           
            weakself.paramValue = valuestr;
            [weakself DevSetData];

        };
    }
}

- (void)onoffClick:(UIButton *)enabBtn{
    
    enabBtn.selected = !enabBtn.selected;
    
    if(_KeyArray.count > (enabBtn.tag - 6000)){
        
        _paramName = _KeyArray[enabBtn.tag - 6000];
        _paramValue = enabBtn.selected?@"1":@"0";
        [self DevSetData];

    }

    
}

- (void)DevSetData{
    
    [self showProgressView];
    
    NSString *urlstr = @"/v1/manager/setHmiInfo";
    NSString *snstrKey = @"pcsID";
    if([_deviceType isEqualToString:@"4"]){
        
        urlstr = @"/v1/manager/setMgrnInfo";
        snstrKey = @"deviceSn";
    }
    if([_deviceType isEqualToString:@"4"]){
        if([_paramName isEqualToString:@"systemTimeSet"]){
        }
    }
    
    [RedxBaseRequest myHttpPost:urlstr parameters:@{snstrKey:_devSN,@"paramName":_paramName,@"paramValue":_paramValue} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {

                [self GetDevSetData];
          
            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
- (void)SystemTimeSetData{
    
    [self showProgressView];
    
    NSString *urlstr = @"/v1/manager/setMgrnSystemTime";
    NSString *snstrKey = @"deviceSn";
    if([_deviceType isEqualToString:@"1"]){
        
        urlstr = @"/v1/manager/setPcsSystemTime";
        snstrKey = @"deviceSn";
    }
    
    [RedxBaseRequest myHttpPost:urlstr parameters:@{snstrKey:_devSN,@"paramName":_paramName,@"paramValue":_paramValue} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {

                [self GetDevSetData];
          
            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
- (void)GetDevSetData{
    
    [self showProgressView];
    NSString *urlstr = @"/v1/manager/getPcsSetInfo";
    NSString *snstrKey = @"pcsID";
    if([_deviceType isEqualToString:@"4"]){
        
        urlstr = @"/v1/manager/getMgrnSetInfo";
        snstrKey = @"deviceSn";
    }
    [RedxBaseRequest myHttpPost:urlstr parameters:@{snstrKey:_devSN} Method:HEAD_URL success:^(id responseObject) {
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
                    
                    self.ValueDic = (NSDictionary *)obj;
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
