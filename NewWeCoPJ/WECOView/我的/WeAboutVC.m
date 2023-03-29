//
//  WeMeSetting.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/8.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeAboutVC.h"
#import "WeSettingCell.h"
#import "OssLanguageVC.h"
#import "WeSecurVC.h"
#import "FGCamProtocolVC.h"

@interface WeAboutVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *devTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *ImgArr;

@end

@implementation WeAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Me_SetName2;
    [self createTable];
    [self createHeaderView];
    // Do any additional setup after loading the view.
}

- (void)createHeaderView{
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *versionstr = [appInfo objectForKey:@"CFBundleShortVersionString"];
    
    // 头部
    float viewH = 180*HEIGHT_SIZE;
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
    
    _ImgArr = @[@"weSuggest",@"WeUserIcon"];//@"WeUpdate",@"Welanguage",
    _dataSource = [NSMutableArray arrayWithArray:@[
                                                   @"Privacy",
                                                   @"User Agreement"
//                                                   Me_SetTing4
                                                 ]];//@"Security Notice"  Me_SetTing1,Me_SetTing3,
    self.devTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStylePlain];
    self.devTableView.delegate = self;
    self.devTableView.dataSource = self;
    [self.view addSubview:self.devTableView];
    self.devTableView.backgroundColor = WhiteColor;
    self.devTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.devTableView registerClass:[WeSettingCell class] forCellReuseIdentifier:@"supportCellID"];
    
    
    
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
    
    WeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"supportCellID" forIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:@"supportCellID"];
    if (!cell) {
        cell = [[WeSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"supportCellID"];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.logoImgv.image = IMAGE(_ImgArr[indexPath.row]);
    cell.titleLB.text = _dataSource[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
//    if(indexPath.row == 0){
//        WeSecurVC *langvc = [[WeSecurVC alloc]init];
//        [self.navigationController pushViewController:langvc animated:YES];
//    }
//    if(indexPath.row == 1){
//        OssLanguageVC *langvc = [[OssLanguageVC alloc]init];
//        [self.navigationController pushViewController:langvc animated:YES];
//    }
    
    if (indexPath.row == 0) {
        FGCamProtocolVC *protovc = [[FGCamProtocolVC alloc]init];
        protovc.typeStr = @"1";
        [self.navigationController pushViewController:protovc animated:YES];
    }else{
        
        FGCamProtocolVC *protovc = [[FGCamProtocolVC alloc]init];
        protovc.typeStr = @"0";

        [self.navigationController pushViewController:protovc animated:YES];
    }
    

}

@end
