//
//  WePlantListVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/2.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WePlantListVC.h"
#import "WePlantListCell.h"
#import "WeStationSetVC.h"

@interface WePlantListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UIView *searchButtonView;

@property (nonatomic, strong) UITableView *PlanTablev;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) int plantStatueNum;
@property (nonatomic, strong) NSArray *Namearr;
@property (nonatomic, strong) NSString *plantName;
@property (nonatomic, strong) UIView *clickbgview;
@property (nonatomic, strong) UITextField *inputTF;
@property (nonatomic, strong) UIImageView *nodataImgv;


@end

@implementation WePlantListVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.plantName = @"";
    [self getdataSet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = home_CirclePL;
    [self createUI];
    [self createTbv];
//    [self getdataSet];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:root_Add_Plant style:UIBarButtonItemStylePlain target:self action:@selector(addPlantclick)];
    
    
//    UIButton *changBtn = [self goToInitButton:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE) TypeNum:2 fontSize:13 titleString:@"" selImgString:@"OSS_list" norImgString:@"OSS_list"];
//    [changBtn addTarget:self action:@selector(changbtnclick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:changBtn];
    
//    if (_searchButtonView) {
//        [_searchButtonView removeFromSuperview];
//        _searchButtonView=nil;
//    }
//    _searchButtonView= [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth - 10*NOW_SIZE-10*NOW_SIZE,40*HEIGHT_SIZE)];
//    _searchButtonView.backgroundColor = [UIColor whiteColor];
//    [_searchButtonView.layer setMasksToBounds:YES];
//    _searchButtonView.userInteractionEnabled=YES;
//    [_searchButtonView.layer setCornerRadius:8*HEIGHT_SIZE];
//    _searchButtonView.layer.borderWidth = 0.5*HEIGHT_SIZE;
//    _searchButtonView.layer.borderColor = colorblack_102.CGColor;
//
//    UITapGestureRecognizer *labelTap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToSearch)];
//    [_searchButtonView addGestureRecognizer:labelTap3];
//    [self.view addSubview:_searchButtonView];
    float imageH2=20*HEIGHT_SIZE;
    float imageW2=imageH2*(34/36.0);
//    float W22=(_searchButtonView.frame.size.width-imageW2)/2.0;
    
    
    
//    UILabel *shousuoLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(image3.frame)+10*NOW_SIZE, 0, _searchButtonView.xmg_width - CGRectGetMaxX(image3.frame)-30*NOW_SIZE, 40*HEIGHT_SIZE) textName:root_sousuo textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    [_searchButtonView addSubview:shousuoLB];
    
    UITextField *seachTF = [[UITextField alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE)];
    seachTF.backgroundColor = [UIColor whiteColor];
    [seachTF.layer setMasksToBounds:YES];
    seachTF.userInteractionEnabled=YES;
    [seachTF.layer setCornerRadius:8*HEIGHT_SIZE];
    seachTF.layer.borderWidth = 0.5*HEIGHT_SIZE;
    seachTF.layer.borderColor = colorblack_102.CGColor;
    seachTF.placeholder = root_stationname;
    seachTF.returnKeyType = UIReturnKeySearch;
    seachTF.delegate = self;
    seachTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:seachTF];
    _inputTF = seachTF;
    
    UIView *leftvie = [self goToInitView:CGRectMake(0, 0,imageW2 + 20*HEIGHT_SIZE, 40*HEIGHT_SIZE) backgroundColor:WhiteColor];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(10*HEIGHT_SIZE, (40*HEIGHT_SIZE-imageH2)/2, imageW2,imageH2 )];
    image3.userInteractionEnabled=YES;
    image3.image=IMAGE(@"oss_search");
    [leftvie addSubview:image3];
    seachTF.leftView = leftvie;
    seachTF.leftViewMode = UITextFieldViewModeAlways;
    
//    UIView *rightvie = [self goToInitView:CGRectMake(0, 0,30*HEIGHT_SIZE, 40*HEIGHT_SIZE) backgroundColor:WhiteColor];
//    UIButton *closebtn = [self goToInitButton:CGRectMake(0, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) TypeNum:1 fontSize:14 titleString:@"X" selImgString:@"" norImgString:@""];
//    [closebtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
//    [closebtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
//    [rightvie addSubview:closebtn];
//
//    seachTF.rightView = rightvie;
//    seachTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    NSArray *staArr = @[home_Statu1,
                        home_Statu2,
                        home_Statu3,
                        home_Statu4,
    ];
    _Namearr = staArr;
    float plantTypeButViewH=50*HEIGHT_SIZE;
    float X0=(10/375.0)*ScreenWidth;
    float K1=(5/375.0)*ScreenWidth;
    float typeButUnitW=(ScreenWidth-2*X0-(staArr.count-1)*K1)/staArr.count;
    for (int i = 0; i < staArr.count; i++) {
        UIButton* buttonV=[self goToInitButton:CGRectMake(X0+(typeButUnitW+K1)*i,CGRectGetMaxY(seachTF.frame)+10*HEIGHT_SIZE, typeButUnitW, plantTypeButViewH) TypeNum:1 fontSize:16.f titleString:staArr[i] selImgString:@"" norImgString:@""];
        buttonV.titleLabel.numberOfLines=0;
        buttonV.titleLabel.adjustsFontSizeToFitWidth=YES;
        [buttonV setTitleColor:MainColor forState:UIControlStateSelected];
        [buttonV setTitleColor:colorblack_51 forState:UIControlStateNormal];
        buttonV.tag=8800+i;
        [buttonV addTarget:self action:@selector(choicePlantStatueType:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonV];
        
        if (i==0) {
            _plantStatueNum = 0;
            buttonV.selected=YES;
            float lineW=45*NOW_SIZE;
            _lineView=[self goToInitView:CGRectMake(X0+(typeButUnitW+K1)*i+(typeButUnitW-lineW)*0.5, CGRectGetMaxY(seachTF.frame)+10*HEIGHT_SIZE+plantTypeButViewH-4*HEIGHT_SIZE, lineW, 2*HEIGHT_SIZE) backgroundColor:MainColor];
            [self.view addSubview:_lineView];
            if ([UIFont fontWithName:@"Helvetica-Bold" size:17.f]) {
                buttonV.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
            }
        }else{
            buttonV.selected=NO;
        }
        
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if(_clickbgview){
        
        [_clickbgview removeFromSuperview];
        _clickbgview = nil;
    }
    UIView *tfbgv = [self goToInitView:CGRectMake(0, 50*HEIGHT_SIZE, kScreenWidth, kScreenHeight-50*HEIGHT_SIZE) backgroundColor:COLOR(0, 0, 0, 0.4)];
    UITapGestureRecognizer *bgclick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgclickTap)];
    [tfbgv addGestureRecognizer:bgclick];
    [self.view addSubview:tfbgv];
    _clickbgview = tfbgv;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.view endEditing:YES];
    [_clickbgview removeFromSuperview];

    _plantName = textField.text;
    [self getdataSet];
}
- (void)bgclickTap{
    
    [self.view endEditing:YES];
    [_clickbgview removeFromSuperview];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    [_clickbgview removeFromSuperview];

    _plantName = textField.text;
    [self getdataSet];
    
    return YES;
}

- (void)changbtnclick:(UIButton *)changBtn{
    
    changBtn.selected = !changBtn.selected;
}


-(void)choicePlantStatueType:(UIButton*)button{
    NSArray *staArr = @[home_Statu1,
                        home_Statu2,
                        home_Statu3,
                        home_Statu4,
    ];

    for (int i=0; i<staArr.count; i++) {
        if (button.tag==(8800+i)) {
            button.selected=YES;
            _plantStatueNum=i;
            _lineView.frame=CGRectMake(button.frame.origin.x+(button.frame.size.width-_lineView.frame.size.width)*0.5, _lineView.frame.origin.y, _lineView.frame.size.width, _lineView.frame.size.height) ;
            if ([UIFont fontWithName:@"Helvetica-Bold" size:17.f]) {
                button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
            }
            NSArray *datarr = [[NSArray alloc]init];
            if(i < _datasource.count){
                
                datarr = _datasource[i];
                if(i == 0){
                    [button setTitle:[NSString stringWithFormat:@"%@",staArr[i]] forState:UIControlStateNormal];

                }else{
                    [button setTitle:[NSString stringWithFormat:@"%@(%d)",staArr[i],datarr.count] forState:UIControlStateNormal];

                }
            }
        }else{
            UIButton *button2=[self.view viewWithTag:8800+i];
            button2.selected=NO;
            button2.titleLabel.font = [UIFont systemFontOfSize:16.f];
        }
    }
    [self.PlanTablev reloadData];
    
    if(_plantStatueNum < _datasource.count){
        NSArray *arr = _datasource[_plantStatueNum];
        if (arr.count > 0) {
            _PlanTablev.hidden = NO;
            _nodataImgv.hidden = YES;
            
        }else{
            _PlanTablev.hidden = YES;
            _nodataImgv.hidden = NO;
            
        }
    }
}

- (void)createTbv{
    
    UIImageView *nodataIMG = [self goToInitImageView:CGRectMake(kScreenWidth/2-50*HEIGHT_SIZE,CGRectGetMaxY(_lineView.frame)+ (kScreenHeight-kNavBarHeight-(CGRectGetMaxY(_lineView.frame)))/2-100*HEIGHT_SIZE, 100*HEIGHT_SIZE, 100*HEIGHT_SIZE) imageString:@"WENoData"];
    [self.view addSubview:nodataIMG];
    _nodataImgv = nodataIMG;
    
    UITableView *tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineView.frame), kScreenWidth, kScreenHeight-kNavBarHeight-(CGRectGetMaxY(_lineView.frame))) style:UITableViewStylePlain];
    tabv.delegate = self;
    tabv.dataSource = self;
    tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabv];
    _PlanTablev = tabv;
    
    
    [tabv registerClass:[WePlantListCell class] forCellReuseIdentifier:@"PlantListCellID"];
    
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

  
        [self getdataSet];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.PlanTablev.mj_header endRefreshing];
        });
    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间

    header2.stateLabel.hidden = YES;
    self.PlanTablev.mj_header = header2;
    
    
    
    
//    UIButton *addbtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, kScreenHeight-20*HEIGHT_SIZE-40*HEIGHT_SIZE-kNavBarHeight, kScreenWidth-40*NOW_SIZE, 40*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"Add Plant" selImgString:@"" norImgString:@""];
//    addbtn.backgroundColor = mainColor;
//    [addbtn addTarget:self action:@selector(addPlantclick) forControlEvents:UIControlEventTouchUpInside];
//    addbtn.layer.cornerRadius = 10*HEIGHT_SIZE;
//    addbtn.layer.masksToBounds = YES;
//    [self.view addSubview:addbtn];
}

//添加电站
- (void)addPlantclick{
    WeStationSetVC *setVC = [[WeStationSetVC alloc]init];
    setVC.EditType = @"0";
    [self.navigationController pushViewController:setVC animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_plantStatueNum < _datasource.count){
        NSArray *arr = _datasource[_plantStatueNum];
        return arr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (30+25*4)*HEIGHT_SIZE+10*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WePlantListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlantListCellID" forIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:@"supportCellID"];
    if (!cell) {
        cell = [[WePlantListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlantListCellID"];
    }
    NSArray *arr = [[NSArray alloc]init];

    if(_plantStatueNum < _datasource.count){
        arr = _datasource[_plantStatueNum];
    }
    NSDictionary *onedic = arr[indexPath.row];

    cell.StaNameLB.text = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];
    cell.currPowerValuLB.text = [NSString stringWithFormat:@"%@",onedic[@"loadPower"]];
    cell.DateValueLB.text = [NSString stringWithFormat:@"%@",onedic[@"installationData"]];
    cell.PVcapaValueLB.text = [NSString stringWithFormat:@"%@",onedic[@"pvCapacity"]];
    cell.TodayTPValueLB.text = [NSString stringWithFormat:@"%@/%@",onedic[@"todayCharge"],onedic[@"totalCharge"]];
    cell.localLB.text = [NSString stringWithFormat:@"%@",onedic[@"address"]];

    NSString *Imgurl = [NSString stringWithFormat:@"%@",onedic[@"plantPicturePathText"]];
    [cell.headIMGV sd_setImageWithURL:[NSURL URLWithString:Imgurl] placeholderImage:IMAGE(@"WedefaultPlantIMG")];
    
    cell.EditClickBlock = ^{
        WeStationSetVC *setVC = [[WeStationSetVC alloc]init];
        setVC.EditType = @"1";
        setVC.plantID = [NSString stringWithFormat:@"%@",onedic[@"id"]];
        [self.navigationController pushViewController:setVC animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [[NSArray alloc]init];

    if(_plantStatueNum < _datasource.count){
        arr = _datasource[_plantStatueNum];
    }
    NSDictionary *onedic = arr[indexPath.row];
    NSString *planid = [NSString stringWithFormat:@"%@",onedic[@"id"]];
    NSString *plantName = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];

    self.seleClick(planid,plantName);
    [self.navigationController popViewControllerAnimated:YES];
    
}

//获取数据

- (void)getdataSet{
    
    [self showProgressView];//_deviceNetDic
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/getPlantList" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email,@"plantName":_plantName} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self.PlanTablev.mj_header endRefreshing];

        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"/v1/plant/getPlantList:%@",datadic);
//        datadic = @{
//            @"result": @0,
//            @"msg": @"Submit successful.",
//            @"obj": @[
//                @{
//                    @"id": @1,
//                    @"plantName": @"plant1",
//                    @"plantType": @0,
//                    @"installationData": @"2022-11-19",
//                    @"country": @"Canada",
//                    @"city": @"Iqaluit",
//                    @"address": @"cateds",
//                    @"incomeUnit": @"DOLLAR",
//                    @"plantPicturePath": @"user/plant/2671236324@qq.com/1668861794904171.jpg",
//                    @"currencyPower": @0,
//                    @"pvCapacity": @0,
//                    @"totalCharge": @0,
//                    @"todayCharge": @0
//              },
//                @{
//                    @"id": @2,
//                    @"plantName": @"plant2",
//                    @"plantType": @0,
//                    @"installationData": @"2022-11-19",
//                    @"country": @"Canada",
//                    @"city": @"oudsa",
//                    @"address": @"cateds",
//                    @"incomeUnit": @"DOLLAR",
//                    @"plantPicturePath": @"user/plant/2671236324@qq.com/16693461290889308.jpg",
//                    @"currencyPower": @0,
//                    @"pvCapacity": @0,
//                    @"totalCharge": @0,
//                    @"todayCharge": @0
//              }
//            ]
//        };
        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSArray class]]){
                    
                    NSArray *dataarr = [NSArray arrayWithArray:objarr];
                    if(dataarr.count > 0){
                        NSMutableArray *AllArr = [[NSMutableArray alloc]init];
                        NSMutableArray *OnlineArr = [[NSMutableArray alloc]init];
                        NSMutableArray *OffLineArr = [[NSMutableArray alloc]init];
                        NSMutableArray *FaultArr = [[NSMutableArray alloc]init];

                        for (int i = 0; i < dataarr.count; i++) {
                            
                            NSDictionary *onedic = dataarr[i];
                            [AllArr addObject:onedic];
                            NSString *plantStatus = [NSString stringWithFormat:@"%@",onedic[@"plantStatus"]];
                            if([plantStatus isEqualToString:@"0"]){//离线
                                [OffLineArr addObject:onedic];
                                
                            }
                            if([plantStatus isEqualToString:@"1"]){//在离线
                                [OnlineArr addObject:onedic];
                                
                            }
                            if([plantStatus isEqualToString:@"2"]){//故障
                                [FaultArr addObject:onedic];
                                
                            }
                        }
                        
                        _datasource = [NSMutableArray arrayWithArray:@[AllArr,OnlineArr,OffLineArr,FaultArr]];
                        
                        for (int i = 1; i < _Namearr.count; i++) {
                            NSArray *oneArr = _datasource[i];
                            UIButton *onebtn = [self.view viewWithTag:8800+i];
                            
                            [onebtn setTitle:[NSString stringWithFormat:@"%@(%d)",_Namearr[i],oneArr.count] forState:UIControlStateNormal];

                        }
                        self.PlanTablev.hidden = NO;
                        [self.PlanTablev reloadData];
                        if (AllArr.count > 0) {
                            self.PlanTablev.hidden = NO;
                            self.nodataImgv.hidden = YES;
                        }else{
                            self.PlanTablev.hidden = YES;
                            self.nodataImgv.hidden = NO;

                        }

                    }else{
                        
                      
                        [self showToastViewWithTitle:root_oss_993];
                        self.PlanTablev.hidden = YES;

                        [self.PlanTablev reloadData];
                        self.nodataImgv.hidden = NO;

                    }
                }else{
                    
                    _datasource = [NSMutableArray arrayWithArray:@[@[],@[],@[],@[]]];
                    for (int i = 1; i < _Namearr.count; i++) {
                        NSArray *oneArr = _datasource[i];
                        UIButton *onebtn = [self.view viewWithTag:8800+i];
                        
                        [onebtn setTitle:[NSString stringWithFormat:@"%@(%d)",_Namearr[i],oneArr.count] forState:UIControlStateNormal];

                    }
                    self.PlanTablev.hidden = NO;
                    [self.PlanTablev reloadData];
                    self.PlanTablev.hidden = YES;
                    self.nodataImgv.hidden = NO;
                }

            }else{
                _datasource = [NSMutableArray arrayWithArray:@[@[],@[],@[],@[]]];
                for (int i = 1; i < _Namearr.count; i++) {
                    NSArray *oneArr = _datasource[i];
                    UIButton *onebtn = [self.view viewWithTag:8800+i];
                    
                    [onebtn setTitle:[NSString stringWithFormat:@"%@(%d)",_Namearr[i],oneArr.count] forState:UIControlStateNormal];

                }
                self.PlanTablev.hidden = NO;
                [self.PlanTablev reloadData];
                self.PlanTablev.hidden = YES;
                self.nodataImgv.hidden = NO;

                
            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self.PlanTablev.mj_header endRefreshing];
        if (error) {
            [self showToastViewWithTitle:linkTimeOut1];

        }
    }];
}
@end
