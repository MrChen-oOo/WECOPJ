//
//  WeDeviceSetVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/31.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeDeviceSetVC.h"
#import "USSet1Cell.h"
#import "WeDeviceListVC.h"
#import "WeAllDataSetVC.h"
#import "WePeakSetVC.h"
#import "BRPickerView.h"
#import "RedxBaseRequest.h"

@interface WeDeviceSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *conTable;
@property (nonatomic, strong)NSArray *nameArray;
@property (nonatomic, strong)NSDictionary *ValueDic;

@end

@implementation WeDeviceSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _devSN;//@"Electrical Cabinet";
    [self createSetUI];
    [self GetDevSetData];
    // Do any additional setup after loading the view.
}

- (void)createSetUI{
    
    if([_deviceType isEqualToString:@"1"]){
        _nameArray=[NSMutableArray arrayWithArray:@[
            @"Protect Parameters",
            @"Grid Power",
            @"Electrovalence Setting",
            @"Operation Control",
            @"System time"
    //        @"Firmware Update"
          
        ]];
        
    }
    if([_deviceType isEqualToString:@"4"]){
        _nameArray=[NSMutableArray arrayWithArray:@[
            @"System Setting",
            @"Protect Parameters",
            @"Grid Power",
            @"Operation Control",
//            @"WIFI Config"
    //        @"Firmware Update"
          
        ]];
        
    }
    
    _conTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight-85*HEIGHT_SIZE-10*HEIGHT_SIZE) style:UITableViewStylePlain];
    _conTable.delegate = self;
    _conTable.dataSource = self;
    _conTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_conTable];
    
    [_conTable registerClass:[USSet1Cell class] forCellReuseIdentifier:@"USSETCELL"];
    
    
    UIButton *deletebtn = [self goToInitButton:CGRectMake(30*NOW_SIZE, kScreenHeight-40*HEIGHT_SIZE-45*HEIGHT_SIZE, kScreenWidth-60*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"Delete" selImgString:@"" norImgString:@""];
    deletebtn.backgroundColor = mainColor;
    deletebtn.layer.cornerRadius = 8*HEIGHT_SIZE;
    deletebtn.layer.masksToBounds = YES;
    [deletebtn addTarget:self action:@selector(deleteclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deletebtn];
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
    cell.titleLB.text = namestr;
    cell.onoffBtn.hidden = YES;
    cell.rightIMG.hidden = NO;
    cell.valueLB.hidden = YES;
    CGSize textSize = [self getStringSize:14*HEIGHT_SIZE Wsize:kScreenWidth-80*NOW_SIZE Hsize:cell.titleLB.xmg_height stringName:namestr];
    cell.titleLB.xmg_width = textSize.width+20*NOW_SIZE;
    cell.valueLB.xmg_x = CGRectGetMaxX(cell.titleLB.frame);
    cell.valueLB.xmg_width = kScreenWidth-CGRectGetMaxX(cell.titleLB.frame)-10*NOW_SIZE-20*HEIGHT_SIZE;
    if([_deviceType isEqualToString:@"1"]){
        if([namestr isEqualToString:@"System time"]){
            NSString *valustr = [NSString stringWithFormat:@"%@",_ValueDic[@"systemTime"]];
            cell.valueLB.hidden = NO;
            cell.valueLB.text = valustr;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *namestr = _nameArray[indexPath.row];
    
//    if([namestr isEqualToString:@"Protect Parameters"]){
    if([_deviceType isEqualToString:@"1"]){
        
        if([namestr isEqualToString:@"Electrovalence Setting"]){
            
            WePeakSetVC *peakVC = [[WePeakSetVC alloc]init];
            peakVC.devSN = _devSN;
            [self.navigationController pushViewController:peakVC animated:YES];
            
            return;
        }
    
            if([namestr isEqualToString:@"System time"]){
                NSString *valustr = [NSString stringWithFormat:@"%@",_ValueDic[@"systemTime"]];

                
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
                    
//                    self.paramValue = selectValue;//[NSString stringWithFormat:@"%@:00",selectValue];
                    [self SystemTimeSetData:selectValue];
                    
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
    }
    WeAllDataSetVC *datasetvc = [[WeAllDataSetVC alloc]init];
    datasetvc.devSN = _devSN;
    datasetvc.titNameStr = namestr;
    datasetvc.deviceType = _deviceType;
    [self.navigationController pushViewController:datasetvc animated:YES];
//    }
}
- (void)deleteclick{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/delDeviceInfo" parameters:@{@"deviceSn":_devSN} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                [self showToastViewWithTitle:@"Delete Success"];

                BOOL isback = NO;
                
                for (UIViewController *onevc in self.navigationController.viewControllers) {
                    
                    if([onevc isKindOfClass:[WeDeviceListVC class]]){
                        isback = YES;
                        [self.navigationController popToViewController:onevc animated:YES];
                    }
                }
                if(!isback){
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}

- (void)SystemTimeSetData:(NSString *)valustr{
    
    [self showProgressView];
    
    NSString *urlstr = @"/v1/manager/setMgrnSystemTime";
    NSString *snstrKey = @"deviceSn";
    if([_deviceType isEqualToString:@"1"]){
        
        urlstr = @"/v1/manager/setPcsSystemTime";
        snstrKey = @"deviceSn";
    }
    
    [RedxBaseRequest myHttpPost:urlstr parameters:@{snstrKey:_devSN,@"paramName":@"syncTime",@"paramValue":valustr} Method:HEAD_URL success:^(id responseObject) {
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
