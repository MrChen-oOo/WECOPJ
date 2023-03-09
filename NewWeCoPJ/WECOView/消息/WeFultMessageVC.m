//
//  WeDeviceListVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/28.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeFultMessageVC.h"
#import "RedxDTKDropdownMenuView.h"
#import "RedxKTDropdownMenuView.h"
#import "FaultTbvCell.h"
#import "WeFaultDetailVC.h"

@interface WeFultMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RedxDTKDropdownMenuView *titleMenuView;
@property (nonatomic, strong) RedxKTDropdownMenuView *menuView;

@property (nonatomic, strong) UITableView *devTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *allPlantArr;
@property (nonatomic, strong) NSMutableArray *plantNameArr;
@property (nonatomic, strong) NSMutableArray *plantIdArr;


@property(nonatomic,strong)NSMutableArray *array;//数据源

@property (nonatomic,strong)NSMutableArray *selectorPatnArray;//存放选中数据
@property (nonatomic, strong) UIView *editBtnView;
@property (nonatomic, assign) BOOL isNowEditting;
@property (nonatomic, assign) BOOL isSeleAll;
@property (nonatomic, assign) int pageNow;
@property (nonatomic, assign) int pageTotal;

@property (nonatomic, strong) UIImageView *nodataImgv;

@end

@implementation WeFultMessageVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self createDownList];
    _pageNow = 1;
    [self getAllPlantdata];
//    [self getAllDevicedata];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:home_AllRead style:UIBarButtonItemStylePlain target:self action:@selector(LogClick)];
    
    
    _array = [[NSMutableArray alloc]init];
    _dataSource = [[NSMutableArray alloc]init];
    _selectorPatnArray = [[NSMutableArray alloc]init];
    _isNowEditting = NO;
    _pageTotal = 1;
    [self createTable];
    
    // Do any additional setup after loading the view.
}
- (void)createDownList{
    
    if (deviceSystemVersion>=11.0) {
        if (_menuView) {
            [_menuView removeFromSuperview];
            _menuView=nil;
        }
        
        if(self.allPlantArr.count == 0){
            
            self.title = @"";
        }else{
            self.title = @"";
            
            _plantNameArr = [[NSMutableArray alloc]init];
            _plantIdArr = [[NSMutableArray alloc]init];

            int seleNumb = 0;
            for (int i = 0; i < _allPlantArr.count; i++) {
                
                NSDictionary *onedic = _allPlantArr[i];
                NSString *planname = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];
                NSString *planId = [NSString stringWithFormat:@"%@",onedic[@"id"]];

                [_plantNameArr addObject:planname];
                [_plantIdArr addObject:planId];
                if([planId isEqualToString:_PlantID]){
                    seleNumb = i;
                    
                }

            }
            
            
            
            _menuView = [[RedxKTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,200, 44) titles:_plantNameArr];
            
            __weak typeof(self) weakSelf = self;
            _menuView.selectedAtIndex = ^(int index)
            {
                if(index < weakSelf.plantIdArr.count){
                    
                    weakSelf.PlantID = weakSelf.plantIdArr[index];
//                    [weakSelf getOverdata];
                    [weakSelf.selectorPatnArray removeAllObjects];
                    weakSelf.isNowEditting = NO;
                    [weakSelf getAllDevicedata];
                }
                
            };
            _menuView.width = 150.f;
            _menuView.cellSeparatorColor =COLOR(231, 231, 231, 1);
            _menuView.cellColor=colorblack_102;
            _menuView.textColor =colorblack_51;
            _menuView.textFont = [UIFont systemFontOfSize:17.f];
            _menuView.cellHeight=40*HEIGHT_SIZE;
            _menuView.animationDuration = 0.2f;
            _menuView.selectedIndex = seleNumb;
            self.navigationItem.titleView = _menuView;
            
        }
        
        
        
        
    }else{
        if (_titleMenuView) {
            [_titleMenuView removeFromSuperview];
            _titleMenuView=nil;
        }
        
        if(_allPlantArr.count == 0){
            
            self.title = @"";
        }else{
            
            _plantNameArr = [[NSMutableArray alloc]init];
            _plantIdArr = [[NSMutableArray alloc]init];

            int seleNumb = 0;
            for (int i = 0; i < _allPlantArr.count; i++) {
                
                NSDictionary *onedic = _allPlantArr[i];
                NSString *planname = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];
                NSString *planId = [NSString stringWithFormat:@"%@",onedic[@"id"]];

                [_plantNameArr addObject:planname];
                [_plantIdArr addObject:planId];
                if([planId isEqualToString:_PlantID]){
                    seleNumb = i;
                    
                }

            }
            
            _titleMenuView = [RedxDTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200*NOW_SIZE, UI_NAVIGATION_BAR_HEIGHT) dropdownItems:_plantNameArr];
            //  menuView.intrinsicContentSize=CGSizeMake(200*HEIGHT_SIZE, 44*HEIGHT_SIZE);
            //menuView.translatesAutoresizingMaskIntoConstraints=true;
            _titleMenuView.currentNav = self.navigationController;
            _titleMenuView.dropWidth = 150.f;
            _titleMenuView.titleColor=colorblack_51;
            _titleMenuView.titleFont = [UIFont systemFontOfSize:17.f];
            _titleMenuView.textColor =colorblack_102;
            _titleMenuView.textFont = [UIFont systemFontOfSize:13.f];
            _titleMenuView.cellSeparatorColor =COLOR(231, 231, 231, 1);
            _titleMenuView.textFont = [UIFont systemFontOfSize:14.f];
            _titleMenuView.animationDuration = 0.2f;
            _titleMenuView.selectedIndex = seleNumb;
            self.navigationItem.titleView = _titleMenuView;
        }
    }

}
- (void)Editclick{
    
  
    //移除之前选中的内容
    if (self.selectorPatnArray.count > 0) {
        [self.selectorPatnArray removeAllObjects];
    }
//    [self.devTableView setEditing:YES animated:YES];
    _isSeleAll = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Select all" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllEdit)];
    self.isNowEditting = YES;

    [self creaEditDeleteBtn];
    
    [self.devTableView reloadData];
//    if ([button.titleLabel.text isEqualToString:@"选择"]) {
//
//        [button setTitle:@"确认" forState:(UIControlStateNormal)];
//        //进入编辑状态
//    }else{
//
//        [button setTitle:@"选择" forState:(UIControlStateNormal)];
//　　　　　//对选中内容进行操作
//        NSLog(@"选中个数是 : %lu   内容为 : %@",(unsigned long)self.selectorPatnArray.count,self.selectorPatnArray);
//        //取消编辑状态
//        [self.tableView setEditing:NO animated:YES];
//
//    }
}

- (void)creaEditDeleteBtn{
    
    if(_editBtnView){
        
        [_editBtnView removeFromSuperview];
        _editBtnView = nil;
    }
    
    UIView *editbgv = [self goToInitView:CGRectMake(0, kScreenHeight-kNavBarHeight-30*HEIGHT_SIZE-40*HEIGHT_SIZE-10*HEIGHT_SIZE-40*HEIGHT_SIZE-10*HEIGHT_SIZE, kScreenWidth, 30*HEIGHT_SIZE+40*HEIGHT_SIZE+10*HEIGHT_SIZE+40*HEIGHT_SIZE+10*HEIGHT_SIZE) backgroundColor:WhiteColor];
    [self.view addSubview:editbgv];
    _editBtnView = editbgv;
    
    UIButton *delebtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 40*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:home_Delete selImgString:@"" norImgString:@""];
    [delebtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    delebtn.backgroundColor = buttonColor;
    delebtn.layer.cornerRadius = 10*HEIGHT_SIZE;
    delebtn.layer.masksToBounds = YES;
    [delebtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [editbgv addSubview:delebtn];
    
    UIButton *Okbtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(delebtn.frame)+10*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 40*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:HEM_ExitEdit selImgString:@"" norImgString:@""];
    [Okbtn setTitleColor:buttonColor forState:UIControlStateNormal];
    Okbtn.backgroundColor = WhiteColor;
    Okbtn.layer.cornerRadius = 10*HEIGHT_SIZE;
    Okbtn.layer.masksToBounds = YES;
    Okbtn.layer.borderWidth = 1*HEIGHT_SIZE;
    Okbtn.layer.borderColor = buttonColor.CGColor;
    [Okbtn addTarget:self action:@selector(OkbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [editbgv addSubview:Okbtn];
    Okbtn.hidden = YES;
    
}

- (void)deleteClick{
    
    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_isDelete message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
    [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        [self DeleteSet];

    }]];
    [self presentViewController:alvc animated:YES completion:nil];
    
    

}
- (void)OkbtnClick{
    
    if(_editBtnView){
        
        [_editBtnView removeFromSuperview];
        _editBtnView = nil;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:home_AllRead style:UIBarButtonItemStylePlain target:self action:@selector(LogClick)];

    _isNowEditting = NO;
    [self.devTableView reloadData];
//    [self.devTableView setEditing:NO animated:YES];
    
}
- (void)selectAllEdit{
    
    _isSeleAll = !_isSeleAll;
    if(_isSeleAll){
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:home_Deselect style:UIBarButtonItemStylePlain target:self action:@selector(selectAllEdit)];
        [self.selectorPatnArray removeAllObjects];
        for (int i = 0; i < self.array.count; i++) {
            [self.selectorPatnArray addObject:self.array[i]];//添加到选中列表

        }

    }else{
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:home_Select style:UIBarButtonItemStylePlain target:self action:@selector(selectAllEdit)];
        
        [self.selectorPatnArray removeAllObjects];
       
    }
    
    
    
    [self.devTableView reloadData];
}



- (void)createTable{
    UIImageView *nodataIMG = [self goToInitImageView:CGRectMake(kScreenWidth/2-50*HEIGHT_SIZE,10*HEIGHT_SIZE+(kScreenHeight-kNavBarHeight)/2-100*HEIGHT_SIZE, 100*HEIGHT_SIZE, 100*HEIGHT_SIZE) imageString:@"WENoData"];
    [self.view addSubview:nodataIMG];
    _nodataImgv = nodataIMG;
    
    self.devTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,10*HEIGHT_SIZE, kScreenWidth, kScreenHeight - kNavBarHeight-10*HEIGHT_SIZE) style:UITableViewStylePlain];
    self.devTableView.delegate = self;
    self.devTableView.dataSource = self;
    [self.view addSubview:self.devTableView];
    self.devTableView.backgroundColor = WhiteColor;
    self.devTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.devTableView registerClass:[FaultTbvCell class] forCellReuseIdentifier:@"faultCellID"];
    
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        self.pageNow = 1;
        [self getAllDevicedata];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.devTableView.mj_header endRefreshing];
        });
    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    header2.stateLabel.hidden = YES;

    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        self.pageNow ++;
        if (self.pageNow > self.pageTotal) {
            [self.devTableView.mj_footer endRefreshing];
            [self showToastViewWithTitle:@"No Data"];
            return;
        }
        [self getAllDevicedata];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.devTableView.mj_footer endRefreshing];
        });
    }];
    footer.stateLabel.hidden = YES;
    

    self.devTableView.mj_header = header2;
    self.devTableView.mj_footer = footer;

}
//tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
 
    return _array.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *cellID = [NSString stringWithFormat:@"supportCellID%d",indexPath.row];
    
    FaultTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"faultCellID" forIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:@"supportCellID"];
    if (!cell) {
        cell = [[FaultTbvCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"faultCellID"];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILongPressGestureRecognizer *longclick = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(Editclick)];
    [cell addGestureRecognizer:longclick];
    
    if(_isNowEditting){
        
        [cell createEditUI];
        
        NSString *oneFuID = _array[indexPath.row];
        if([self.selectorPatnArray containsObject:oneFuID]){
            
            cell.seleBtn.selected = YES;
        }else{
            
            cell.seleBtn.selected = NO;

        }
    }else{
        
        [cell createUnEditUI];
    }
    

    NSDictionary *oneDic = _dataSource[indexPath.row];
    NSString *faultDescription = [NSString stringWithFormat:@"%@",oneDic[@"faultDescription"]];
    NSString *readStatus = [NSString stringWithFormat:@"%@",oneDic[@"readStatus"]];
    NSString *faultTime = [NSString stringWithFormat:@"%@",oneDic[@"faultTime"]];

    cell.timeLB.text = faultTime;
    cell.contenLB.text = faultDescription;
    
    if([readStatus isEqualToString:@"0"]){//0未读，1已读
        cell.noReadVie.backgroundColor = [UIColor redColor];
        
    }else{
        
        cell.noReadVie.backgroundColor = WhiteColor;

    }
    
    __weak typeof(self) weakSelf = self;
    cell.BtnClickBlock = ^(BOOL isSelect) {
        
        if(isSelect){
            
            [weakSelf.selectorPatnArray addObject:weakSelf.array[indexPath.row]];
        }else{
            
            //从选中中取消
            if (self.selectorPatnArray.count > 0) {
                
                [self.selectorPatnArray removeObject:self.array[indexPath.row]];
            }
        }
        
    };
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(!_isNowEditting){
        NSDictionary *oneDic = _dataSource[indexPath.row];
        NSString *faultId = [NSString stringWithFormat:@"%@",oneDic[@"faultId"]];

        WeFaultDetailVC *fudetailvc = [[WeFaultDetailVC alloc]init];
        fudetailvc.faultId = faultId;
        fudetailvc.PlantID = _PlantID;
        [self.navigationController pushViewController:fudetailvc animated:YES];
        
    }
    

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(indexPath.section==0)
        {
        }
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_isNowEditting){
        
        return NO;
    }else{
        return YES;
    }
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:home_Delete handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了编辑");
            
            [self.selectorPatnArray addObject:self.array[indexPath.row]];
            [self deleteClick];

        }];
        deleteAction.backgroundColor = [UIColor redColor];
        
        return @[deleteAction];
}



//log
- (void)LogClick{
    
    [self AllreadSet];
}


//获取消息列表
- (void)getAllDevicedata{
    
    
    NSString *urlstr = [NSString stringWithFormat:@"/v1/plant/getHmiDataFaultList/%d",_pageNow];

    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:urlstr parameters:@{@"plantId":_PlantID} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self.devTableView.mj_header endRefreshing];
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSDictionary class]]){
                    NSDictionary *objdic = (NSDictionary *)objarr;
                    
                    NSArray *dataarr = [NSArray arrayWithArray:objdic[@"dataList"]];
                    NSString *pageNowstr = [NSString stringWithFormat:@"%@",objdic[@"pageNow"]];
                    NSString *pageTotalstr = [NSString stringWithFormat:@"%@",objdic[@"pageTotal"]];

                    _pageNow = [pageNowstr intValue];
                    _pageTotal = [pageTotalstr intValue];
                    if(_pageNow == 1){
                        [_dataSource removeAllObjects];
                        [_array removeAllObjects];
                        if (objdic.count == 0) {
                            _nodataImgv.hidden = NO;
                            _devTableView.hidden = YES;
                        }else{
                            _nodataImgv.hidden = YES;
                            _devTableView.hidden = NO;
                        }
                        
                    }
                        
                    [_dataSource addObjectsFromArray:dataarr];
                    for (int i = 0; i < dataarr.count; i++) {
                        NSDictionary *onedic = dataarr[i];
                        NSString *faultId = [NSString stringWithFormat:@"%@",onedic[@"faultId"]];
                        [_array addObject:faultId];
                    }
                    
                    
                    

                    [self.devTableView reloadData];

                }else{
                    _nodataImgv.hidden = NO;
                    _devTableView.hidden = YES;
                }

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self.devTableView.mj_header endRefreshing];
        
        if (error) {
            [self showToastViewWithTitle:linkTimeOut1];

        }
    }];
}


//获取全部电站
- (void)getAllPlantdata{
    
    [self showProgressView];//_deviceNetDic
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/getPlantList" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSArray class]]){
                    
                    NSArray *dataarr = [NSArray arrayWithArray:objarr];
                        
                    _allPlantArr = [NSMutableArray arrayWithArray:dataarr];

                    [self getAllDevicedata];

                }

            }
//
        }
        [self createDownList];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self createDownList];
    }];
}

//全部已读
- (void)AllreadSet{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/updateFaultReadStatus" parameters:@{@"plantId":_PlantID} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                [self getAllDevicedata];

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
//删除
- (void)DeleteSet{
    
    NSString *Allfault = @"";
    if(_selectorPatnArray.count == 1){
        Allfault = _selectorPatnArray[0];
    }

    if(_selectorPatnArray.count > 1){
        Allfault = [_selectorPatnArray componentsJoinedByString:@"-"];

    }
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/delFaultData" parameters:@{@"faultIds":Allfault} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                [self.selectorPatnArray removeAllObjects];
                self.isNowEditting = NO;
                [self getAllDevicedata];

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        if (error) {
            [self showToastViewWithTitle:linkTimeOut1];

        }
    }];
}
@end
