//
//  BlueToolsOpenSetTipsVC.m
//  LocalDebug
//
//  Created by CBQ on 2022/8/29.
//

#import "BlueToolsOpenSetTipsVC.h"

@interface BlueToolsOpenSetTipsVC ()

@end

@implementation BlueToolsOpenSetTipsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    
    UIScrollView *buscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:buscroll];
    
    NSString *firstr = blueFirst;
    CGSize firTS = [self getStringSize:17*HEIGHT_SIZE Wsize:kScreenWidth-40*NOW_SIZE-120*NOW_SIZE Hsize:30*HEIGHT_SIZE stringName:firstr];
    UILabel *firstLB = [self goToInitLable:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, firTS.width+5*NOW_SIZE, 30*HEIGHT_SIZE) textName:firstr textColor:colorBlack fontFloat:17*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [firstLB setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17*HEIGHT_SIZE]];
    [buscroll addSubview:firstLB];
    
    UIButton *gotoBtn = [self goToInitButton:CGRectMake(CGRectGetMaxX(firstLB.frame)+5*NOW_SIZE, 10*HEIGHT_SIZE, 80*NOW_SIZE, 30*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:[NSString stringWithFormat:@"%@>>",NewLocat_gotoSetWifi] selImgString:@"" norImgString:@""];
    [gotoBtn setTitleColor:buttonColor forState:UIControlStateNormal];
    [gotoBtn addTarget:self action:@selector(gotoSetBlue) forControlEvents:UIControlEventTouchUpInside];
    [buscroll addSubview:gotoBtn];
    
    UILabel *linklb = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(firstLB.frame)+3*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE) textName:BlueTipsOpenWay2 textColor:colorblack_51 fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    linklb.numberOfLines = 0;
    [buscroll addSubview:linklb];
    
    NSString *imgstr = @"blueopenEN";
    if ([[self getTheLaugrage] isEqualToString:@"0"]) {
        imgstr = @"blueopenCN";
    }
    CGSize imgsize = IMAGE(imgstr).size;
    CGFloat imgheig = imgsize.height*(kScreenWidth-20*NOW_SIZE)/imgsize.width;
    UIImageView *imgv = [self goToInitImageView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(linklb.frame)+2*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, imgheig) imageString:imgstr];
    [buscroll addSubview:imgv];
    
    //
    
    UILabel *twoLB = [self goToInitLable:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(imgv.frame)+10*HEIGHT_SIZE, kScreenWidth-100*NOW_SIZE, 30*HEIGHT_SIZE) textName:blueTwo textColor:colorBlack fontFloat:17*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [twoLB setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17*HEIGHT_SIZE]];

    [buscroll addSubview:twoLB];

    
    UILabel *linklb2 = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(twoLB.frame)+3*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE) textName:BlueTipsOpenWay1 textColor:colorblack_51 fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    linklb2.numberOfLines = 0;
    [buscroll addSubview:linklb2];
    
    CGSize imgsize2 = IMAGE(@"openBluetips4").size;
    CGFloat imgheig2 = imgsize2.height*(kScreenWidth-20*NOW_SIZE)/imgsize2.width;
    UIImageView *imgv2 = [self goToInitImageView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(linklb2.frame)+2*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, imgheig2) imageString:@"openBluetips4"];
    [buscroll addSubview:imgv2];
    
    buscroll.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(imgv2.frame)+kNavBarHeight);
}

- (void)gotoSetBlue{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

}
@end
