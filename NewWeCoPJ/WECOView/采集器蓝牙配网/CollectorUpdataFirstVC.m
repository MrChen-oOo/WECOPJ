//
//  CollectorUpdataFirstVC.m
//  ShinePhone
//
//  Created by 清清 on 2022/3/7.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "CollectorUpdataFirstVC.h"
//#import "CollectorTCPUpDataVC.h"
#import "BluetoolsUpadtaDevVC.h"

@interface CollectorUpdataFirstVC ()

@end

@implementation CollectorUpdataFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NewAPSet_CJQUpLoad;
    [self createFirstUI];
    // Do any additional setup after loading the view.
}

- (void)createFirstUI{
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 70*HEIGHT_SIZE ,40*HEIGHT_SIZE, 140*HEIGHT_SIZE, 140*HEIGHT_SIZE)];
    imgv.image = IMAGE(@"shengjizhong");
    [self.view addSubview:imgv];
    
    UILabel *tipslb = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(imgv.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE) textName:collect_lowTips textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    tipslb.numberOfLines = 0;
    [self.view addSubview:tipslb];
    
    UILabel *tipslb2 = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(tipslb.frame)+5*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE) textName:collect_CheckLow textColor:colorblack_186 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    tipslb2.numberOfLines = 0;
    [self.view addSubview:tipslb2];
    
    UIButton *canbtn = [self goToInitButton:CGRectMake(kScreenWidth/2-10*NOW_SIZE-90*NOW_SIZE, CGRectGetMaxY(tipslb2.frame)+40*HEIGHT_SIZE, 90*NOW_SIZE, 30*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:root_cancel selImgString:@"" norImgString:@""];
    [self.view addSubview:canbtn];
    [canbtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
    canbtn.layer.cornerRadius = 15*HEIGHT_SIZE;
    canbtn.layer.masksToBounds = YES;
    canbtn.layer.borderWidth = 0.6*NOW_SIZE;
    canbtn.layer.borderColor = colorblack_102.CGColor;
    [canbtn addTarget:self action:@selector(canbtnclick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *okbtn = [self goToInitButton:CGRectMake(CGRectGetMaxX(canbtn.frame)+10*NOW_SIZE, CGRectGetMaxY(tipslb2.frame)+40*HEIGHT_SIZE, 90*NOW_SIZE, 30*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:root_OK selImgString:@"" norImgString:@""];
    [self.view addSubview:okbtn];
    okbtn.backgroundColor = colorblack_102;
    [okbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    okbtn.layer.cornerRadius = 15*HEIGHT_SIZE;
    okbtn.layer.masksToBounds = YES;
    okbtn.layer.borderWidth = 0.6*NOW_SIZE;
    okbtn.layer.borderColor = colorblack_102.CGColor;
    [okbtn addTarget:self action:@selector(okbtnclick) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)canbtnclick{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.NextBlock();
}
- (void)okbtnclick{
    
//    if ([_isBlueIN isEqualToString:@"1"]) {
        BluetoolsUpadtaDevVC *updata = [[BluetoolsUpadtaDevVC alloc]init];
        updata.isWifiXOrS = _isWifiXOrS;
        updata.SNStr = _SNStr;
        [self.navigationController pushViewController:updata animated:YES];

//    }else{
//        CollectorTCPUpDataVC *updata = [[CollectorTCPUpDataVC alloc]init];
//        updata.isWifiXOrS = _isWifiXOrS;
//        updata.SNStr = _SNStr;
//        [self.navigationController pushViewController:updata animated:YES];
//    }
    
}
@end
