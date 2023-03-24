//
//  INVSettingViewController.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/15.
//

#import "INVSettingViewController.h"
#import "BasicTableViewCell.h"
#import "CabinetAdvancedTableViewCell.h"
#import "GridStandardView.h"
#import "BasicWarningView.h"
#import "InpuPopView.h"
#import "BRPickerView.h"
#import "PlantSettingViewController.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface INVSettingViewController ()<UITableViewDelegate,UITableViewDataSource,BasicSettingDelegate,UIScrollViewDelegate,CabineBasicSettingDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *setScrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (nonatomic, strong) UITableView *basicTableView;
@property (nonatomic, strong) UITableView *advancedTableView;

@property (nonatomic, strong) GridStandardView *gridStandardView;
@property (nonatomic, strong) BasicWarningView *warningView;
@property (nonatomic, strong) InpuPopView *inputView;
@property (nonatomic, strong) BRDatePickerView *datePickerView;

@property (nonatomic, strong) UIPageControl *basicPageC;
@property (nonatomic, strong) UIPageControl *advancePageC;

@end
@implementation INVSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Basic Setting";
    [self.basicTableView registerNib:[UINib nibWithNibName:@"BasicTableViewCell" bundle:nil] forCellReuseIdentifier:@"basicCell"];
    [self.advancedTableView registerNib:[UINib nibWithNibName:@"BasicTableViewCell" bundle:nil] forCellReuseIdentifier:@"basicCell"];
    [self.advancedTableView registerNib:[UINib nibWithNibName:@"CabinetAdvancedTableViewCell" bundle:nil] forCellReuseIdentifier:@"CabinetAdvanced"];
    
    self.basicTableView.estimatedRowHeight = 0;
    self.basicTableView.estimatedSectionHeaderHeight = 0;
    self.basicTableView.estimatedSectionFooterHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        self.basicTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.scrollContentView addSubview:self.basicTableView];
    [self.scrollContentView addSubview:self.advancedTableView];
    self.setScrollView.delegate = self;
    [self.view addSubview:self.datePickerView];
    [self setTableViewFoot];
}

- (void)setTableViewFoot{
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [oneView addSubview:self.basicPageC];
    self.basicTableView.tableFooterView  = oneView;
    
    UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [twoView addSubview:self.advancePageC];
    self.advancedTableView.tableFooterView  = twoView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.settingVM.deviceType == 1) {
        [self getSettingMessageHttp];
    } else {
        [self getHMISettingMessageHttp];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

}
#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.settingVM.deviceType == 1) {
        return tableView == self.basicTableView ? self.settingVM.optionModel.basicSettingOptionSectionArray.count : self.settingVM.optionModel.advancedSettingOptionSectionArray.count;
    } else {
        return tableView == self.basicTableView ? self.settingVM.optionModel.cabinetBasicSettingOptionSectionArray.count : 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.settingVM.deviceType == 1) {
        return tableView == self.basicTableView ? self.settingVM.optionModel.basicSettingOptionKeyArray[section].count : self.settingVM.optionModel.advancedSettingOptionKeyArray[section].count;
    } else {
        return tableView == self.basicTableView ? self.settingVM.optionModel.cabinetBasicSettingOptionKeyArray[section].count : 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.basicTableView) {
        if (self.settingVM.deviceType == 1) {
            return indexPath.row == 0 || indexPath.row == self.settingVM.optionModel.basicSettingOptionKeyArray[indexPath.section].count - 1 ? 60 : 40;
        } else {
            NSArray *array = self.settingVM.optionModel.cabinetBasicSettingOptionKeyArray[indexPath.section];
            return array.count == 1 ? 90 : indexPath.row == 0 || indexPath.row == array.count - 1 ? 60 : 40;
        }
    } else {
        if (self.settingVM.deviceType == 0) {
            return 190;
        }
        if (indexPath.row == self.settingVM.optionModel.advancedSettingOptionKeyArray[indexPath.section].count - 1) {
            return 100;
        }
        return indexPath.row == 0 ? 60 : 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return tableView == self.basicTableView ? 40 : 20;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *sectionName = [[UILabel alloc]initWithFrame:CGRectMake(26, 10, kScreenWidth - 40, 29)];
    sectionName.textAlignment = NSTextAlignmentLeft;
    [sectionName setTextColor:[UIColor lightGrayColor]];
    [sectionName setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:16]];
    [sectionName setTextColor:HexRGB(0x999999)];
    sectionName.text = tableView == self.basicTableView
                                ? self.settingVM.deviceType == 1
                                ? self.settingVM.optionModel.basicSettingOptionSectionArray[section]
                                : self.settingVM.optionModel.cabinetBasicSettingOptionSectionArray[section]
                                : @"";
    [view addSubview:sectionName];
    return view;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 针对特殊cell进行处理
    if (self.settingVM.deviceType == 0 && tableView == self.advancedTableView) {
        CabinetAdvancedTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[CabinetAdvancedTableViewCell alloc] initWithReuseIdentifier:@"CabinetAdvanced" andIndexPath:indexPath];
        }
        cell.delegate = self;
        return cell;
    }
    
    // 常规cell的展示以及不同设备的赋值操作
    BasicTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[BasicTableViewCell alloc] initWithReuseIdentifier:@"basicCell" andIndexPath:indexPath deviceType:self.settingVM.deviceType];
    }
    cell.delegate = self;
    
    if (self.settingVM.deviceType == 1) {
        [cell setMessageWithValueArray:tableView == self.basicTableView
                                                    ? self.settingVM.optionModel.basicSettingOptionValueArray[indexPath.section]
                                                    : self.settingVM.optionModel.advancedSettingOptionValueArray[indexPath.section]
                               keyArray:tableView == self.basicTableView
                                                    ? self.settingVM.optionModel.basicSettingOptionKeyArray[indexPath.section]
                                                    : self.settingVM.optionModel.advancedSettingOptionKeyArray[indexPath.section]
                             unitArray:tableView == self.basicTableView
                                                    ? self.settingVM.optionModel.basicSettingUnitArray[indexPath.section]
                                                    : self.settingVM.optionModel.advancedSettingUnitArray[indexPath.section]
                                    row:indexPath.row];
        [cell setUIWithUIArray:tableView == self.basicTableView ? self.settingVM.optionModel.basicSettingUIArray[indexPath.section] : self.settingVM.optionModel.advancedSettingUIArray[indexPath.section] deviceStr:self.settingVM.deviceSnStr];
    } else {
        [cell setMessageWithValueArray:self.settingVM.optionModel.cabinetBasicSettingOptionValueArray[indexPath.section]
                              keyArray:self.settingVM.optionModel.cabinetBasicSettingOptionKeyArray[indexPath.section]
                             unitArray:self.settingVM.optionModel.cabinetBasicSettingUnitArray[indexPath.section]
                                   row:indexPath.row];
        [cell setUIWithUIArray:self.settingVM.optionModel.cabinetBasicSettingUIArray[indexPath.section] deviceStr:self.settingVM.deviceSnStr];
    }
   
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *basicArray = [NSArray arrayWithArray:self.settingVM.optionModel.basicSettingSelectArray[indexPath.section]];
    NSArray *advancedArray = [NSArray arrayWithArray:self.settingVM.optionModel.advancedSettingSelectArray[indexPath.section]];
    NSArray *cabinetBasicArray = [NSArray arrayWithArray:self.settingVM.optionModel.cabinetBasicSettingSelectArray[indexPath.section]];

    NSArray *basicValueArray = [NSArray arrayWithArray:self.settingVM.optionModel.basicSettingOptionValueArray[indexPath.section]];
    NSArray *advancedValueArray = [NSArray arrayWithArray:self.settingVM.optionModel.advancedSettingOptionValueArray[indexPath.section]];
    NSArray *cabineValueArray = [NSArray arrayWithArray:self.settingVM.optionModel.cabinetBasicSettingOptionValueArray[indexPath.section]];

    NSArray *basicParamsArray = [NSArray arrayWithArray:self.settingVM.optionModel.basicSettingParamArray[indexPath.section]];
    NSArray *advancedParamsArray = [NSArray arrayWithArray:self.settingVM.optionModel.advancedSettingParamArray[indexPath.section]];
    NSArray *cabineParmsArray = [NSArray arrayWithArray:self.settingVM.optionModel.cabinetBasicSettingParamArray[indexPath.section]];
    
    NSArray *basicKeyArray = [NSArray arrayWithArray:self.settingVM.optionModel.basicSettingOptionKeyArray[indexPath.section]];
    NSArray *advancedKeyArray = [NSArray arrayWithArray:self.settingVM.optionModel.advancedSettingOptionKeyArray[indexPath.section]];
    NSArray *cabineKeyArray = [NSArray arrayWithArray:self.settingVM.optionModel.cabinetBasicSettingOptionKeyArray[indexPath.section]];

    NSInteger selectNum = tableView == self.basicTableView ? self.settingVM.deviceType == 0 ? [cabinetBasicArray[indexPath.row] intValue] : [basicArray[indexPath.row] intValue] : [advancedArray[indexPath.row] intValue];

    //  0:无操作 1:跳转输入框（百分比） 2:跳转输入框 3:时间弹窗 4:选项页面 5:跳转电价设置
    switch (selectNum) {
        case 1:
            self.inputView.hidden = NO;
            [self.inputView isHaveUnitWith:YES
                                    numStr:tableView == self.basicTableView ? self.settingVM.deviceType == 1 ? basicValueArray[indexPath.row] : cabineValueArray[indexPath.row] : advancedValueArray[indexPath.row]
                                 paramsStr:tableView == self.basicTableView ? self.settingVM.deviceType == 1 ? basicParamsArray[indexPath.row] : cabineParmsArray[indexPath.row] : advancedParamsArray[indexPath.row]
                                     title:tableView == self.basicTableView ? self.settingVM.deviceType == 1 ? basicKeyArray[indexPath.row] : cabineKeyArray[indexPath.row] : advancedKeyArray[indexPath.row]
                                     index:indexPath
                                deviceType:self.settingVM.deviceType];
            break;
        case 2:
            self.inputView.hidden = NO;
            [self.inputView isHaveUnitWith:NO
                                    numStr:tableView == self.basicTableView ? self.settingVM.deviceType == 1 ? basicValueArray[indexPath.row] : cabineValueArray[indexPath.row] : advancedValueArray[indexPath.row]
                                 paramsStr:tableView == self.basicTableView ? self.settingVM.deviceType == 1 ? basicParamsArray[indexPath.row] : cabineParmsArray[indexPath.row] : advancedParamsArray[indexPath.row]
                                     title:tableView == self.basicTableView ? self.settingVM.deviceType == 1 ? basicKeyArray[indexPath.row] : cabineKeyArray[indexPath.row] : advancedKeyArray[indexPath.row]
                                     index:indexPath
                                deviceType:self.settingVM.deviceType];
            break;
        case 3:
            [self.datePickerView show];
            self.datePickerView.pickerMode = indexPath.row == 0 ? BRDatePickerModeYMD : BRDatePickerModeHMS;
            break;
        case 4:
            [self.gridStandardView selectCellActionWith:tableView == self.basicTableView ? [basicValueArray[indexPath.row] intValue] : [advancedValueArray[indexPath.row]intValue]
                                                   type:tableView == self.basicTableView ? basicParamsArray[indexPath.row] : advancedParamsArray[indexPath.row]
                                                  title:tableView == self.basicTableView ? basicKeyArray[indexPath.row] : advancedKeyArray[indexPath.row]];
            self.gridStandardView.hidden = NO;
            break;
        case 5:
            [self didClickPlanSettingWithIsTimePlanSetting:NO];
            break;
        default:
            break;
    }
    
}
 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.setScrollView) {
        CGPoint point = scrollView.contentOffset;
//        point.y = 0;
        scrollView.contentOffset = point;
        if (point.x > kScreenWidth / 2) {
            self.title = @"Advanced Setting";
        } else {
            self.title = @"Basic Setting";

        }
    }

}

#pragma mark 点击方法/代理点击方法

// swich点击方法
-(void)didClickSwichActionWith:(NSDictionary *)param swich:(UISwitch *)swich {
    if (self.settingVM.deviceType == 1) {
        [self sendSettingHttpWith:param];
    } else {
        [self sendSettingHMIHttpWith:param];
    }
}

// 跳转计划时间
-(void)didClickPlanSettingWithIsTimePlanSetting:(BOOL)isTime {
    PlantSettingViewController *planVC = [[PlantSettingViewController alloc]init];
    planVC.deviceSnStr = self.settingVM.deviceSnStr;
    planVC.isTimePlan = isTime;
    planVC.deviceType = self.settingVM.deviceType;
    [self.navigationController pushViewController:planVC animated:YES];
}

// 开关机按钮
-(void)didClickStartUpWithShutDown:(BOOL)isStart {
    //isStart yes开机  no关机
    if (isStart == NO) {
        self.warningView.hidden = NO;
        [self.warningView showAttentionWith:NO];
    } else {
        NSDictionary *dic = @{@"deviceSn":self.settingVM.deviceSnStr,@"code":@"SWITCH_MACHINE",@"value":@"1"} ;
        [self sendSettingHttpWith:dic];
    }
}

// 恢复出厂设置
-(void)didClickReloadAction {
    self.warningView.hidden = NO;
    [self.warningView showAttentionWith:YES];
}

// HMI 开关机设置
-(void)didClickStartUpWithStatus:(NSInteger)status {
    NSDictionary *dic = @{@"deviceSn":self.settingVM.deviceSnStr,@"code":@"systemUpOff",@"value":[NSString stringWithFormat:@"%ld",status]};
    [self sendSettingHMIHttpWith:dic];
}
#pragma mark 网络请求


// 获取逆变器数据网络请求
-(void)getSettingMessageHttp{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressView];
    });
    @WeakObj(self)
    [self.settingVM getSettingInverterParamMsgCompleteBlock:^(NSString *resultStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            [selfWeak.basicTableView reloadData];
            [selfWeak.advancedTableView reloadData];
        } else {
            [selfWeak showErrorViewWithResultStr:resultStr];
        }
    }];

}

// 获取HMI数据网络请求
-(void)getHMISettingMessageHttp{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressView];
    });
    @WeakObj(self)
    [self.settingVM getPcsParamMsgCompleteBlock:^(NSString *resultStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            [selfWeak.basicTableView reloadData];
            [selfWeak.advancedTableView reloadData];
        } else {
            [selfWeak showErrorViewWithResultStr:resultStr];
        }
    }];
}


// 设置逆变器数据网络请求
-(void)sendSettingHttpWith:(NSDictionary *)param {
    [self showProgressView];
    @WeakObj(self)
    [self.settingVM setUpInverterSingleParam:param completeBlock:^(NSString *resultStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfWeak showToastViewWithTitle:@"Setting succeeded"];
            });
        } else {
            [selfWeak showErrorViewWithResultStr:resultStr];
        }
        [selfWeak getSettingMessageHttp];
    }];
}

// 设置HMI参数
- (void)sendSettingHMIHttpWith:(NSDictionary *)param {
    [self showProgressView];
    @WeakObj(self)
    [self.settingVM setHMIParam:param completeBlock:^(NSString *resultStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfWeak showToastViewWithTitle:@"Setting succeeded"];
            });
        } else {
            [selfWeak showErrorViewWithResultStr:resultStr];
        }
        [selfWeak getHMISettingMessageHttp];
    }];
}


// 设置系统时间网络请求
-(void)setTimeHttpWith:(NSDictionary *)param {
    [self showProgressView];
    @WeakObj(self)
    
    if (self.settingVM.deviceType == 1) {
        // 逆变器
        [self.settingVM setInverterTimeParam:param completeBlock:^(NSString *resultStr) {
            [selfWeak hideProgressView];
            if (resultStr.length == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [selfWeak showToastViewWithTitle:@"Setting succeeded"];
                });
                [selfWeak getSettingMessageHttp];
            } else {
                [selfWeak showErrorViewWithResultStr:resultStr];
            }
        }];
    } else {
        // HMI
        [self.settingVM setPcsSystemTimeParm:param completeBlock:^(NSString *resultStr) {
            [selfWeak hideProgressView];
            if (resultStr.length == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [selfWeak showToastViewWithTitle:@"Setting succeeded"];
                });
                [selfWeak getHMISettingMessageHttp];
            } else {
                [selfWeak showErrorViewWithResultStr:resultStr];
            }
        }];
        
    }
}



// 提示错误信息
-(void)showErrorViewWithResultStr:(NSString *)resultStr {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showToastViewWithTitle:resultStr];
    });
}

#pragma mark 懒加载

- (UITableView *) basicTableView {
    if (!_basicTableView) {
        _basicTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
        _basicTableView.showsVerticalScrollIndicator = NO;
        _basicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _basicTableView.delegate = self;
        _basicTableView.dataSource = self;
        _basicTableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _basicTableView;
}

- (UITableView *) advancedTableView {
    if (!_advancedTableView) {
        _advancedTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
        _advancedTableView.showsVerticalScrollIndicator = NO;
        _advancedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _advancedTableView.delegate = self;
        _advancedTableView.dataSource = self;
        _advancedTableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _advancedTableView;
}

-(INVSettingViewModel *)settingVM {
    if (!_settingVM) {
        _settingVM = [[INVSettingViewModel alloc]initViewModel];
    }
    return _settingVM;
}

-(GridStandardView *)gridStandardView {
    if (!_gridStandardView) {
        _gridStandardView = [[GridStandardView alloc]initWithViewModel:self.settingVM];
        _gridStandardView.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight);
        _gridStandardView.hidden = YES;
        @WeakObj(self);
        _gridStandardView.selectCellBlock = ^(NSDictionary *dic) {
            // 修改GridStandard
            selfWeak.gridStandardView.hidden = YES;
            [selfWeak sendSettingHttpWith:dic];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_gridStandardView];
    }
    return _gridStandardView;
}

-(BasicWarningView *)warningView {
    if (!_warningView) {
        _warningView = [[BasicWarningView alloc]initWithViewModel:self.settingVM];
        _warningView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _warningView.hidden = YES;
        @WeakObj(self);
        _warningView.ShutDownBlock = ^(BOOL isShutDown) {
            if (isShutDown == YES) {
                // 关机
                NSDictionary *dic = @{@"deviceSn":selfWeak.settingVM.deviceSnStr,@"code":@"SWITCH_MACHINE",@"value":@"0"} ;
                [selfWeak sendSettingHttpWith:dic];
            } else {
                // 恢复出厂设置
                NSDictionary *dic = @{@"deviceSn":selfWeak.settingVM.deviceSnStr,@"code":@"RESTORE_FACTORY_SETTING",@"value":@"1"};
                [selfWeak sendSettingHttpWith:dic];
            }
        };
        
        [[UIApplication sharedApplication].keyWindow addSubview:_warningView];
    }
    return _warningView;
}

-(InpuPopView *)inputView {
    if (!_inputView) {
        _inputView = [[InpuPopView alloc]initWithViewModel:self.settingVM];
        _inputView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _inputView.hidden = YES;
        @WeakObj(self);
        _inputView.changeDataBlock = ^(NSDictionary * _Nonnull dic) {
            selfWeak.inputView.hidden = YES;
            if (selfWeak.settingVM.deviceType == 1) {
                [selfWeak sendSettingHttpWith:dic];
            } else {
                [selfWeak sendSettingHMIHttpWith:dic];
            }
        };

        [[UIApplication sharedApplication].keyWindow addSubview:_inputView];
    }
    return _inputView;
}

-(BRDatePickerView *)datePickerView {
    if (!_datePickerView) {
        // 1.创建日期选择器
        _datePickerView = [[BRDatePickerView alloc]init];
        // 2.设置属性
        _datePickerView.title = root_xuanzeshijian;
//        _datePickerView.selectValue = defValue;//@"2019-10-30";
    //    datePickerView.selectDate = [NSDate br_setYear:2019 month:10 day:30];
        _datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
        _datePickerView.isAutoSelect = NO;
        @WeakObj(self)
        _datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
            NSInteger length = selectValue.length;
            NSLog(@"选择的值：%@ 长度%ld", selectValue,length);
            NSString *parmStr = @"";
            if (length == 10) {
                parmStr = [NSString stringWithFormat:@"%@ %@",selectValue,self.settingVM.settingModel.time];
            } else {
                parmStr = [NSString stringWithFormat:@"%@ %@",self.settingVM.settingModel.date,selectValue];
                parmStr = [parmStr stringByReplacingOccurrencesOfString:@"." withString:@"-"];
            }
            NSDictionary *dic = @{@"deviceSn":selfWeak.settingVM.deviceSnStr,@"dateTime":parmStr};
            [selfWeak setTimeHttpWith:dic];
        };
        // 设置自定义样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.pickerColor = WhiteColor;//BR_RGB_HEX(0xd9dbdf, 1.0f);
        customStyle.pickerTextColor = colorBlack;//[UIColor redColor];
        customStyle.separatorColor = colorblack_186;//[UIColor redColor];
        _datePickerView.pickerStyle = customStyle;
    }
    return _datePickerView;
}


-(UIPageControl *)basicPageC {
    if(!_basicPageC) {
        _basicPageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _basicPageC.numberOfPages = 2;
        _basicPageC.backgroundColor = [UIColor whiteColor];
        _basicPageC.pageIndicatorTintColor = HexRGB(0xd8d8d8);
        _basicPageC.currentPageIndicatorTintColor = HexRGB(0x4776FF);
        _basicPageC.currentPage = 0;
        _basicPageC.userInteractionEnabled = NO;
    }
    return _basicPageC;
}

-(UIPageControl *)advancePageC {
    if(!_advancePageC) {
        _advancePageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _advancePageC.numberOfPages = 2;
        _advancePageC.backgroundColor = [UIColor whiteColor];
        _advancePageC.pageIndicatorTintColor = HexRGB(0xd8d8d8);
        _advancePageC.currentPageIndicatorTintColor = HexRGB(0x4776FF);
        _advancePageC.currentPage = 1;
        _advancePageC.userInteractionEnabled = NO;
    }
    return _advancePageC;
}


@end
