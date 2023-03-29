//
//  WeMeSetting.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/8.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeMeSetting.h"
#import "WeSettingCell.h"
#import "OssLanguageVC.h"
#import "WeSecurVC.h"
#import "WeAboutVC.h"

@interface WeMeSetting ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *devTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *ImgArr;

@end

@implementation WeMeSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Me_SetName2;
    [self createTable];
//    [self createHeaderView];
    // Do any additional setup after loading the view.
}

- (void)createHeaderView{
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *versionstr = [appInfo objectForKey:@"CFBundleShortVersionString"];
    
    // 头部
    float viewH = 140*HEIGHT_SIZE;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,viewH)];
    UIColor *color=backgroundNewColor;
    [headerView setBackgroundColor:color];
    // 图标logo
    double imageSize=70*HEIGHT_SIZE;
    UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-imageSize)/2, (viewH-imageSize)/2, imageSize, imageSize)];
    [userImage setImage:[UIImage imageNamed:@"IconLaunc"]];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/4.0;
    // 版本号
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(userImage.frame)+5*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE,20*HEIGHT_SIZE)];
    version.font=[UIFont systemFontOfSize:12*HEIGHT_SIZE];
    version.textAlignment = NSTextAlignmentCenter;
//    NSString *version1=root_WO_banbenhao;
    NSString *version2=versionstr;
    NSString *version3=[NSString stringWithFormat:@"%@:%@",Me_SetVersion,version2];
    version.text=version3;
    version.textColor = [UIColor blackColor];
    [headerView addSubview:version];
    
    _devTableView.tableHeaderView = headerView;
    [headerView addSubview:userImage];
    
}

- (void)createTable{
    
    _ImgArr = @[@"clearIcon",@"WeUpdate",@"WeDeleAccount",@"Welanguage",@"Weabout"];//,,
    _dataSource = [NSMutableArray arrayWithArray:@[
        @"Clear",
        @"Update",
        Me_SetTing2,
        @"Language",
        @"About"
//                                                   Me_SetTing4
    ]];//@"Security Notice"  Me_SetTing1,Me_SetTing3,
    
    self.devTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStylePlain];
    self.devTableView.delegate = self;
    self.devTableView.dataSource = self;
    [self.view addSubview:self.devTableView];
    self.devTableView.backgroundColor = WhiteColor;
    self.devTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self.devTableView registerClass:[WeSettingCell class] forCellReuseIdentifier:@"supportCellID"];
    
    
    
}
//tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
 
    return _dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *cellID = [NSString stringWithFormat:@"supportCellID%d",indexPath.row];
    static NSString *cellid = @"aboutID";

    WeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[WeSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
//    else{
//
//        while (cell.contentView.subviews.lastObject != nil) {
//            [(UIView *)cell.contentView.subviews.lastObject removeFromSuperview];
//        }
//    }
    
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.logoImgv.image = IMAGE(_ImgArr[indexPath.row]);
    cell.titleLB.text = _dataSource[indexPath.row];
    cell.contenLB.text = @"";

    if (indexPath.row == 0) {
        NSInteger caseNumb = [[SDImageCache sharedImageCache] getSize];
        cell.contenLB.text = [NSString stringWithFormat:@"%.1fM",caseNumb/1024.0];

    }
    if (indexPath.row == 1) {
        NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];

        NSString *versionstr = [appInfo objectForKey:@"CFBundleShortVersionString"];
        cell.contenLB.text = versionstr;

        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    if(indexPath.row == 0){
        [[SDImageCache sharedImageCache] clearMemory];
        [self showProgressView];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showToastViewWithTitle:Home_clearSuccess];
                [self hideProgressView];
                [self.devTableView reloadData];
            });
        }];
    }
    if (indexPath.row == 1) {
        
        [self getversion];
    }
    if(indexPath.row == 2){
        WeSecurVC *langvc = [[WeSecurVC alloc]init];
        [self.navigationController pushViewController:langvc animated:YES];
    }
    if(indexPath.row == 3){
        OssLanguageVC *langvc = [[OssLanguageVC alloc]init];
        [self.navigationController pushViewController:langvc animated:YES];
    }
    if(indexPath.row == 4){
        WeAboutVC *langvc = [[WeAboutVC alloc]init];
        [self.navigationController pushViewController:langvc animated:YES];
    }

}
- (void)getversion{
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *versionstr = [appInfo objectForKey:@"CFBundleShortVersionString"];
    NSString *urlstr = [NSString stringWithFormat:@"/v1/user/checkAppVersion"];
    [self showProgressView];
    [RedxBaseRequest myHttpPost:urlstr parameters:@{@"phoneOS":@"2",@"phoneVersion":versionstr} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"首页:%@",datadic);
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            if ([result isEqualToString:@"0"]) {
                NSDictionary *objArr = datadic[@"obj"];
                if (objArr) {
                    
                    NSString *phoneOS = [NSString stringWithFormat:@"%@",objArr[@"phoneOS"]];
                    NSString *needUpgrade = [NSString stringWithFormat:@"%@",objArr[@"needUpgrade"]];

                    
                    if ([phoneOS isEqualToString:@"2"]) {
                        
                            [self versionClick:objArr];
                    }
                    
                    
//                    [self versionClick:objArr];
                }
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
- (void)versionClick:(NSDictionary *)objdic{
    NSString *needUpgrade = [NSString stringWithFormat:@"%@",objdic[@"needUpgrade"]];
    if (![needUpgrade isEqualToString:@"1"]) {
        [self showToastViewWithTitle:Home_VersionUpdateNew];
        return;
    }
//    NSString *forcedUpgrade = [NSString stringWithFormat:@"%@",objdic[@"forcedUpgrade"]];
//    NSString *nowVersionIsBeta = [NSString stringWithFormat:@"%@",objdic[@"nowVersionIsBeta"]];
//    NSString *lastVersion = [NSString stringWithFormat:@"%@",objdic[@"lastVersion"]];
//    NSString *lastVersionUpgradeUrl = [NSString stringWithFormat:@"%@",objdic[@"lastVersionUpgradeUrl"]];
//    NSString *lastVersionIsBeta = [NSString stringWithFormat:@"%@",objdic[@"lastVersionIsBeta"]];
//    NSString *lastVersionUpgradeDescription = [NSString stringWithFormat:@"%@",objdic[@"lastVersionUpgradeDescription"]];
//    FGCamMsgShowView *msgs1 = [[FGCamMsgShowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    msgs1.typeStr = @"4";
//    msgs1.neVersion = lastVersion;
//    msgs1.isMustUpload1 = [forcedUpgrade isEqualToString:@"1"]?YES:NO;
//    msgs1.showMSG = lastVersionUpgradeDescription;
//    msgs1.nowVersionIsBeta = nowVersionIsBeta;
//    msgs1.lastVersionUpgradeUrl = lastVersionUpgradeUrl;
//    msgs1.lastVersionIsBeta = lastVersionIsBeta;
//    [msgs1 reloadViewMsg];
//    [KEYWINDOW addSubview:msgs1];
//    msgs1.gotoSetBlock = ^{
//    };
//    msgs1.nextsBlock = ^{
//    };
}
@end
