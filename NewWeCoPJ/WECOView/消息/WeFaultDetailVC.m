//
//  WeFaultDetailVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/8.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeFaultDetailVC.h"

@interface WeFaultDetailVC ()

@end

@implementation WeFaultDetailVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getAllDevicedata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = home_detail;
    [self createUI];
    
//    [self getAllDevicedata];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    
    UILabel *timlb = [self goToInitLable:CGRectMake(20*NOW_SIZE, 15*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"" textColor:colorblack_154 fontFloat:13*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [self.view addSubview:timlb];
    
    UIView *bgview = [self goToInitView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(timlb.frame), kScreenWidth-20*NOW_SIZE, 120*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    bgview.layer.cornerRadius = 10*HEIGHT_SIZE;
    bgview.layer.masksToBounds = YES;
    [self.view addSubview:bgview];
    
    NSArray *namarr = @[ home_DeviceName,home_DeviceSN,home_PlantName,home_ErrorCode];
    NSArray *Valuearr = @[@"",@"",@"",@""];

    for (int i = 0; i < namarr.count; i++) {
        UILabel *namlb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 30*HEIGHT_SIZE*i, 90*NOW_SIZE, 30*HEIGHT_SIZE) textName:namarr[i] textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        [bgview addSubview:namlb];
        
        UILabel *valuelb = [self goToInitLable:CGRectMake(CGRectGetMaxX(namlb.frame), 30*HEIGHT_SIZE*i, bgview.xmg_width-CGRectGetMaxX(namlb.frame)-10*NOW_SIZE, 30*HEIGHT_SIZE) textName:Valuearr[i] textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
        valuelb.tag = 100+i;
        [bgview addSubview:valuelb];
    }
    
    UIView *bgview2 = [self goToInitView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(bgview.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 100*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    bgview2.layer.cornerRadius = 10*HEIGHT_SIZE;
    bgview2.layer.masksToBounds = YES;
    [self.view addSubview:bgview2];
    
    UIImageView *quesIMGV = [self goToInitImageView:CGRectMake(10*HEIGHT_SIZE, 5*HEIGHT_SIZE+(30*HEIGHT_SIZE-16*HEIGHT_SIZE)/2, 16*HEIGHT_SIZE, 16*HEIGHT_SIZE) imageString:@"WeFaultQuIcon"];
    [bgview2 addSubview:quesIMGV];
    
    UILabel *titlb = [self goToInitLable:CGRectMake(CGRectGetMaxX(quesIMGV.frame)+5*NOW_SIZE, 0, bgview2.xmg_width-CGRectGetMaxX(quesIMGV.frame)-15*NOW_SIZE, 40*HEIGHT_SIZE) textName:@"Accident Details:" textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [bgview2 addSubview:titlb];
    
    UILabel *titlb2 = [self goToInitLable:CGRectMake(CGRectGetMaxX(quesIMGV.frame), CGRectGetMaxY(titlb.frame), bgview2.xmg_width-CGRectGetMaxX(quesIMGV.frame)-10*NOW_SIZE, 60*HEIGHT_SIZE) textName:@"" textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    titlb2.numberOfLines = 0;
    [bgview2 addSubview:titlb2];
    titlb2.tag = 500;
    
    
    //
    
    UIView *bgview3 = [self goToInitView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(bgview2.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 80*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    bgview3.layer.cornerRadius = 10*HEIGHT_SIZE;
    bgview3.layer.masksToBounds = YES;
    [self.view addSubview:bgview3];
    
    UIImageView *quesIMGV3 = [self goToInitImageView:CGRectMake(10*HEIGHT_SIZE,5*HEIGHT_SIZE+(30*HEIGHT_SIZE-16*HEIGHT_SIZE)/2, 16*HEIGHT_SIZE, 16*HEIGHT_SIZE) imageString:@"WeFaultLocalIcon"];
    [bgview3 addSubview:quesIMGV3];
    
    UILabel *titlb3 = [self goToInitLable:CGRectMake(CGRectGetMaxX(quesIMGV3.frame)+5*NOW_SIZE, 0, bgview3.xmg_width-CGRectGetMaxX(quesIMGV3.frame)-15*NOW_SIZE, 80*HEIGHT_SIZE) textName:home_Accident textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [bgview3 addSubview:titlb3];
    titlb3.tag = 501;

    
    
}
//获取设备列表
- (void)getAllDevicedata{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/getHmiDataFaultDetails" parameters:@{@"plantId":_PlantID,@"faultId":_faultId} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSDictionary class]]){
                    
                    NSDictionary *objdataDic = (NSDictionary *)objarr;
                    UILabel *devNameLB = [self.view viewWithTag:100];
                    UILabel *devSNLB = [self.view viewWithTag:101];
                    UILabel *PlantNameLB = [self.view viewWithTag:102];
                    UILabel *codeLB = [self.view viewWithTag:103];
                    UILabel *detailLB = [self.view viewWithTag:500];
                    UILabel *localLB = [self.view viewWithTag:501];
                    
                    NSString *devNamstr = [NSString stringWithFormat:@"%@",objdataDic[@"deviceName"]];
                    NSString *devSNstr = [NSString stringWithFormat:@"%@",objdataDic[@"deviceSn"]];
                    NSString *PlantNamestr = [NSString stringWithFormat:@"%@",objdataDic[@"plantName"]];
                    NSString *codestr = [NSString stringWithFormat:@"%@",objdataDic[@"faultCode"]];
                    NSString *detaistr = [NSString stringWithFormat:@"%@",objdataDic[@"faultDescription"]];
                    NSString *locastr = [NSString stringWithFormat:@"%@",objdataDic[@"address"]];

                    devNameLB.text = devNamstr;
                    devSNLB.text = devSNstr;
                    PlantNameLB.text = PlantNamestr;
                    codeLB.text = codestr;
                    detailLB.text = detaistr;
                    localLB.text = locastr;


                }

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];

    }];
}
@end
