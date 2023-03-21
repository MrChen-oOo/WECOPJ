//
//  WeDeviceSetVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/31.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WePlantSettingVC.h"
#import "USSet1Cell.h"
#import "WeDeviceListVC.h"
#import "WeAllDataSetVC.h"
#import "WePeakSetVC.h"
#import "WePlanModeVC.h"

@interface WePlantSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *conTable;
@property (nonatomic, strong)NSArray *nameArray;
@property (nonatomic, strong)NSDictionary *valueDic;

@end

@implementation WePlantSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Plant Setting";
    [self createSetUI];
    [self GetDevSetData];
    // Do any additional setup after loading the view.
}

- (void)createSetUI{
    
    _nameArray=[NSMutableArray arrayWithArray:@[
        @"Load First",
        @"Planning Model",
     
    ]];
        

    
    _conTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 15*HEIGHT_SIZE, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStylePlain];
    _conTable.delegate = self;
    _conTable.dataSource = self;
    _conTable.bounces = NO;
    _conTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_conTable];
    
    [_conTable registerClass:[USSet1Cell class] forCellReuseIdentifier:@"USSETCELL"];
    
    
    
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    USSet1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"USSETCELL" forIndexPath:indexPath];
    if (!cell) {
        cell = [[USSet1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"USSETCELL"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *namestr = _nameArray[indexPath.row];
    cell.titleLB.text = namestr;

    if(indexPath.row == 0){
//        NSString *onoffstr = [NSString stringWithFormat:@"%@",self.valueDic[@"sysOperaPolicyMode"]];

//        cell.titleLB.textColor = colorblack_154;
//        [self set_DesignatedTextForLabel:cell.titleLB text:@"Load First" color:colorBlack];
        cell.titleLB.xmg_height = 30*HEIGHT_SIZE;
        cell.detailLB.xmg_y = CGRectGetMaxY(cell.titleLB.frame);
        cell.detailLB.hidden = NO;
        cell.detailLB.text = @"Energy priority order:PV>BAT>GRID";
        
        
        cell.onoffBtn.hidden = NO;
        cell.rightIMG.hidden = YES;
        cell.valueLB.hidden = YES;
        cell.onoffBtn.selected = _plantModel==0?YES:NO;
        [cell.onoffBtn addTarget:self action:@selector(onoffClick:) forControlEvents:    UIControlEventTouchUpInside];
    }else{
        cell.onoffBtn.hidden = YES;
        cell.rightIMG.hidden = NO;
        cell.valueLB.hidden = YES;
        cell.detailLB.hidden = YES;

    }
    
 
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *namestr = _nameArray[indexPath.row];
    if(indexPath.row == 1){
        if(_plantModel != 0){
            
            WePlanModeVC *planmodelVC = [[WePlanModeVC alloc]init];
            planmodelVC.devSN = _devSN;
            planmodelVC.maindevType = _maindevType;
            [self.navigationController pushViewController:planmodelVC animated:YES];
            
        }
        
    }
    

}

- (void)onoffClick:(UIButton *)onoffBtn{
    
    if (kStringIsEmpty(_devSN)) {
        [self showToastViewWithTitle:HEM_meiyoushebei];
        return;
    }
    
    onoffBtn.selected = !onoffBtn.selected;
    
    NSString *valustr = onoffBtn.selected?@"0":@"1";
    
//    [self onoffSetClick:valustr];
    NSString *urlstr = @"/v1/manager/setHmiInfo";
    NSString *snstrKey = @"deviceSn";
    if ([_maindevType isEqualToString:@"1"]) {
        urlstr = @"/v1/manager/setMgrnInfo";
    }
   
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:urlstr
                     parameters:@{snstrKey:_devSN,@"paramName":@"sysOperaPolicyMode",@"paramValue":valustr} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {

//                [self GetDevSetData];
                _plantModel = [valustr intValue];
                
            }else{
                
                onoffBtn.selected = !onoffBtn.selected;
            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
    
}

- (void)GetDevSetData{
    
    NSString *urlstr = @"/v1/manager/getPcsSetInfo";
    NSString *snstrKey = @"pcsID";
    if ([_maindevType isEqualToString:@"1"]) {
        urlstr = @"/v1/manager/getMgrnSetInfo";
    }
  
    if(kStringIsEmpty(_devSN)){
        
        return;
    }
    [self showProgressView];

    [RedxBaseRequest myHttpPost:urlstr parameters:@{snstrKey:_devSN} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {

                id obj = datadic[@"obj"];
                if([obj isKindOfClass:[NSDictionary class]]){
                    
                    self.valueDic = (NSDictionary *)obj;
//                    NSString *onoffstr = [NSString stringWithFormat:@"%@",self.valueDic[@"sysOperaPolicyMode"]];
                  
                    
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
