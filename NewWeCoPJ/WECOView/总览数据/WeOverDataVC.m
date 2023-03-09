//
//  WeOverDataVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/26.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeOverDataVC.h"
#import "AAChartKit.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "BRPickerView.h"

@interface WeOverDataVC (){
    
    AAChartView *aaChartView;
    AAChartModel *chartModel;
    
}
@property (nonatomic, strong) UIView * aachartbgview;
@property (nonatomic, strong) NSMutableArray * x_dataArr;
@property (nonatomic, strong) NSMutableArray * Y_dataArr;
@property (nonatomic, assign) int seleType;
@property (nonatomic, strong) NSString *unitstr;
@property (nonatomic, strong) UILabel *Unitlabel;
@property (nonatomic, assign) CGFloat AACY;
@property (nonatomic, strong) UIScrollView *bgscrollv;
@property (nonatomic, strong) NSString *charColorHex;
@property (nonatomic, assign) int dateType;//0 year,1 month,2 day,3hour
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) UILabel *leftUpName;
@property (nonatomic, strong) UILabel *leftUpValue;
@property (nonatomic, strong) NSArray *totalNameArr;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSArray *dateNameArr;
@property (nonatomic, strong) NSArray *dateKeyArr;
@property (nonatomic, strong) UIButton *titbtn;
@property (nonatomic, strong) NSMutableArray *powerMapArr;
@property (nonatomic, strong) NSString *isHaveData;


@end

@implementation WeOverDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(244, 244, 244, 1);
    
    self.dateType = 3;
    _dateNameArr = @[[NSString stringWithFormat:@" %@",home_dateName1],
                     [NSString stringWithFormat:@" %@",home_dateName2],
                     [NSString stringWithFormat:@" %@",home_dateName3],
                     [NSString stringWithFormat:@" %@",home_dateName4],
    ];//,@"Week"
    _dateKeyArr = @[@"Year",@"Month",@"Day",@"Hour"];//,@"Week"
    
    
    //    UIButton *rigbtn = [self goToInitButton:CGRectMake(0, 0, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) TypeNum:2 fontSize:14*HEIGHT_SIZE titleString:_dateNameArr[0] selImgString:@"WedateImg" norImgString:@"WedateImg"];
    //    [rigbtn setTitleColor:colorBlack forState:UIControlStateNormal];
    //    [rigbtn addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barbtn1 = [[UIBarButtonItem alloc]initWithCustomView:rigbtn];
    
    UIButton *rigbtn2 = [self goToInitButton:CGRectMake(0, 0, 80*HEIGHT_SIZE, 20*HEIGHT_SIZE) TypeNum:3 fontSize:14*HEIGHT_SIZE titleString:_dateNameArr[self.dateType] selImgString:@"WedateImg" norImgString:@"WedateImg"];
    [rigbtn2 setTitleColor:colorBlack forState:UIControlStateNormal];
    rigbtn2.titleLabel.adjustsFontSizeToFitWidth = YES;
    [rigbtn2 addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbtn2 = [[UIBarButtonItem alloc]initWithCustomView:rigbtn2];
    
    
    self.navigationItem.rightBarButtonItem = barbtn2;//@[barbtn2,barbtn1];
    [self createUI];
    
    UIView *titv = [self goToInitView:CGRectMake(0,(kNavBarHeight - 30*HEIGHT_SIZE)/2, 150*NOW_SIZE, 30*HEIGHT_SIZE) backgroundColor:WhiteColor];
    
    
    
    _dateString = [self getDateData];
    UIButton *titbtn = [self goToInitButton:CGRectMake(0,0,titv.xmg_width, titv.xmg_height) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:[self getDateString:_dateString type:_dateKeyArr[_dateType]] selImgString:@"" norImgString:@""];
    [titbtn addTarget:self action:@selector(titviwClick:) forControlEvents:UIControlEventTouchUpInside];
    [titbtn setTitleColor:colorBlack forState:UIControlStateNormal];
    //    titbtn.tag = 3000;
    [titv addSubview:titbtn];
    _titbtn = titbtn;
    self.navigationItem.titleView = titv;
    
    [self getAllDevicedata];
    
    // Do any additional setup after loading the view.
}

// 根据输入的时间，读取年，月，日
- (NSString *)getDateString:(NSString *)dateString type:(NSString *)type{
    
    NSArray *array = [dateString componentsSeparatedByString:@"-"];
    if ([type isEqualToString:@"Day"] || [type isEqualToString:@"Hour"]) {
        return [NSString stringWithFormat:@"%@-%@-%@", array[0],array[1],array[2]];
    } else if ([type isEqualToString:@"Month"]) {
        return [NSString stringWithFormat:@"%@-%@", array[0],array[1]];
    } else if ([type isEqualToString:@"Year"]) {
        return array[0];
    }
    return @"";
}

- (void)titviwClick:(UIButton *)titBtn{
    
    
    NSString *defValue = _dateString;
    // 1.创建日期选择器
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];

    if (_dateType == 0) {//年
        // 2.设置属性
        datePickerView.pickerMode = BRDatePickerModeY;

        defValue = [self getDateString:_dateString type:@"Year"];
    }
    if (_dateType == 1) {//月
        // 2.设置属性
        datePickerView.pickerMode = BRDatePickerModeYM;
        defValue = [self getDateString:_dateString type:@"Month"];

    }
    if (_dateType == 2) {//日
        // 2.设置属性
        datePickerView.pickerMode = BRDatePickerModeYMD;
        defValue = [self getDateString:_dateString type:@"Day"];

    }
    if (_dateType == 3) {//时
        // 2.设置属性
        datePickerView.pickerMode = BRDatePickerModeYMD;
        defValue = [self getDateString:_dateString type:@"Day"];

    }
    
    datePickerView.title = root_xuanzeshijian;
    datePickerView.selectValue = defValue;//@"2019-10-30";
//    datePickerView.selectDate = [NSDate br_setYear:2019 month:10 day:30];
    datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
    datePickerView.maxDate = [NSDate date];
    datePickerView.isAutoSelect = NO;
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        NSLog(@"选择的值：%@", selectValue);
        
        
        if (_dateType == 0) {//年
            NSMutableArray *datemuarr = [NSMutableArray arrayWithArray:[_dateString componentsSeparatedByString:@"-"]];
            [datemuarr replaceObjectAtIndex:0 withObject:selectValue];
            _dateString = [datemuarr componentsJoinedByString:@"-"];
        }
        if (_dateType == 1) {//月
            NSMutableArray *datemuarr = [NSMutableArray arrayWithArray:[_dateString componentsSeparatedByString:@"-"]];
            [datemuarr replaceObjectAtIndex:0 withObject:selectValue];
            _dateString = [selectValue stringByAppendingFormat:@"-%@",datemuarr.lastObject];

        }
        if (_dateType == 2) {//日
            _dateString = selectValue;

        }
        if (_dateType == 3) {//时
            _dateString = selectValue;


        }
        
        if(_dateType < _dateKeyArr.count){
            [titBtn setTitle:[self getDateString:selectValue type:_dateKeyArr[_dateType]] forState:UIControlStateNormal];
            [self getAllDevicedata];
        }
    };
    // 设置自定义样式
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.pickerColor = WhiteColor;//BR_RGB_HEX(0xd9dbdf, 1.0f);
    customStyle.pickerTextColor = colorBlack;//[UIColor redColor];
    customStyle.separatorColor = colorblack_186;//[UIColor redColor];
    datePickerView.pickerStyle = customStyle;

    // 3.显示
    [datePickerView show];
    
//    [CGXPickerView showDatePickerWithTitle:root_xuanzeshijian DateType:UIDatePickerModeDate DefaultSelValue:_dateString MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
//        self.dateString = selectValue;
//        if(_dateType < _dateKeyArr.count){
//            [titBtn setTitle:[self getDateString:selectValue type:_dateKeyArr[_dateType]] forState:UIControlStateNormal];
//            [self getAllDevicedata];
//        }
//
//    }];
    
}



- (NSString *)getDateData{
    
    NSDateFormatter *dataFormatter= [[NSDateFormatter alloc] init];
    dataFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [ dataFormatter  setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [dataFormatter stringFromDate:[NSDate date]];
    
    //    NSArray *timearr = [time componentsSeparatedByString:@"-"];
    return time;
}



- (void)createUI{
    //    WedateImg
    _bgscrollv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    [self.view addSubview:_bgscrollv];
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        [self getAllDevicedata];

    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    header2.stateLabel.hidden = YES;
    _bgscrollv.mj_header = header2;

    
    UIView *bg1view = [self goToInitView:CGRectMake(0, 0, kScreenWidth, 75*HEIGHT_SIZE) backgroundColor:WhiteColor];
    [_bgscrollv addSubview:bg1view];
    UILabel *loadULB = [self goToInitLable:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 80*NOW_SIZE, 25*HEIGHT_SIZE) textName:home_LoadUsage textColor:colorblack_154 fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [bg1view addSubview:loadULB];
    _leftUpName = loadULB;
    
    UILabel *loadDataLB = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(loadULB.frame), 80*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"0kWh" textColor:colorBlack fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:NO];
    loadDataLB.numberOfLines = 0;
    [bg1view addSubview:loadDataLB];
    _leftUpValue = loadDataLB;
    
    _totalNameArr = @[home_LoadUsage ,
                      home_LoadUsage2,
                      home_LoadUsage3,
                      home_LoadUsage4
    ];
    NSArray *NomalNameArr = @[@"energyUnSelect",@"PPVUnSelect",@"GridUnSelect",@"batUnSelect"];
    NSArray *selectNameArr = @[@"energySelect",@"PPVSelect",@"GridSelect",@"batSelect"];
    
    for (int i = 0; i < NomalNameArr.count; i++) {
        
        UIButton *onebtn = [self goToInitButton:CGRectMake(kScreenWidth-10*NOW_SIZE-45*HEIGHT_SIZE*4 + 45*HEIGHT_SIZE*i, 10*HEIGHT_SIZE, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE) TypeNum:2 fontSize:12 titleString:@"" selImgString:selectNameArr[i] norImgString:NomalNameArr[i]];
        onebtn.tag = 100+i;
        [bg1view addSubview:onebtn];
        
        [onebtn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            
            onebtn.selected = YES;
        }
    }
    _unitstr = @"kWh";
    _seleType = 1;
    _AACY = CGRectGetMaxY(bg1view.frame)+10*HEIGHT_SIZE;
//    [self initAAChatView];
    
    CGFloat nextY = 240*HEIGHT_SIZE+20*HEIGHT_SIZE+20*HEIGHT_SIZE+_AACY;

    NSArray *dataNameArr = @[home_dataStatu1,
                             home_dataStatu2,
                             home_dataStatu3
    ];
    NSArray *dataValueArr = @[@"5kWh",@"5kWh",@"5kWh"];
    CGFloat viewWide = (kScreenWidth-20*NOW_SIZE-10*NOW_SIZE)/3;
    for (int i = 0; i < dataNameArr.count; i++) {
        UIView *onev = [self goToInitView:CGRectMake(10*NOW_SIZE+(viewWide+5*NOW_SIZE)*i, nextY+10*HEIGHT_SIZE, viewWide, 80*HEIGHT_SIZE) backgroundColor:WhiteColor];
        onev.layer.cornerRadius = 10*HEIGHT_SIZE;
        onev.layer.masksToBounds = YES;
        onev.layer.shadowOffset = CGSizeMake(0, 0);
        onev.layer.shadowOpacity = 1;
        onev.layer.shadowRadius = 20*HEIGHT_SIZE;
        onev.layer.shadowColor = colorBlack.CGColor;
        onev.tag = 4000+i;
        [_bgscrollv addSubview:onev];
        onev.hidden = YES;
        
        UILabel *valuLB = [self goToInitLable:CGRectMake(0, 0, onev.xmg_width, 40*HEIGHT_SIZE) textName:dataValueArr[i] textColor:colorBlack fontFloat:16*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
        valuLB.tag = 2000+i;
        valuLB.numberOfLines = 0;
        [onev addSubview:valuLB];
        
        UILabel *nameLB = [self goToInitLable:CGRectMake(0, CGRectGetMaxY(valuLB.frame), onev.xmg_width, 40*HEIGHT_SIZE) textName:dataNameArr[i] textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
        nameLB.tag = 2100+i;
        
        [onev addSubview:nameLB];
        
    }
    
    UIButton *downBtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, nextY+10*HEIGHT_SIZE+80*HEIGHT_SIZE+50*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:3 fontSize:14*HEIGHT_SIZE titleString:@" Share My Data" selImgString:@"WedownLoad" norImgString:@"WedownLoad"];
    [downBtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
    downBtn.layer.cornerRadius = 45*HEIGHT_SIZE/2;
    downBtn.layer.masksToBounds = YES;
    downBtn.backgroundColor = WhiteColor;
    //    [_bgscrollv addSubview:downBtn];
    
    _bgscrollv.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(downBtn.frame)+kNavBarHeight+20*HEIGHT_SIZE);
}

- (void)typeClick:(UIButton *)clickBtn{
    
    for (int i = 0; i < 5; i ++) {
        UIButton *onebtn = [self.view viewWithTag:100+i];
        onebtn.selected = NO;
    }
    clickBtn.selected = YES;
    
    _leftUpName.text = _totalNameArr[clickBtn.tag-100];
    _seleType = (int)(clickBtn.tag - 100+1);
    [self getAllDevicedata];
}

- (void)initAAChatView{
    
    if (aaChartView) {
        [aaChartView removeFromSuperview];
    }
    if (_aachartbgview) {
        [_aachartbgview removeFromSuperview];
    }
    
    UIView *aabgv = [self goToInitView:CGRectMake(0, _AACY, kScreenWidth, 240*HEIGHT_SIZE+20*HEIGHT_SIZE+20*HEIGHT_SIZE) backgroundColor:COLOR(244, 244, 244, 1)];//40*HEIGHT_SIZE+
    //    aabgv.layer.cornerRadius = 8*HEIGHT_SIZE;
    //    aabgv.layer.masksToBounds = YES;
    [_bgscrollv addSubview:aabgv];
    _aachartbgview = aabgv;
    
    UILabel *unitLB = [self goToInitLable:CGRectMake(10*NOW_SIZE, 0, 100*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [aabgv addSubview:unitLB];
    _Unitlabel = unitLB;
    
    
    aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(5*NOW_SIZE,CGRectGetMaxY(unitLB.frame),_aachartbgview.xmg_width-10*NOW_SIZE,240*HEIGHT_SIZE)];
    [_aachartbgview addSubview:aaChartView];
    
    
    
    //    if (_seleType == 0) {//
    //        chartModel = [self configurePieChart];
    //        [self createZeroPie];
    //
    //
    //    }
    
//        _x_dataArr = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
//        _Y_dataArr = [NSMutableArray arrayWithArray:@[@14,@244,@323,@46,@52,@61,@79,@87,@98,@1075,@114,@126]];
    _x_dataArr = [[NSMutableArray alloc]init];
    
    //柱形
    if (_dateType == 0 || _dateType == 1 || _dateType == 2) {
        _Unitlabel.text = @"kWh";
        NSArray *nameArr = @[home_EnergyType1,
                             home_EnergyType2,
                             home_EnergyType3,
                             home_EnergyType4
        ];
        if((_seleType-1) < nameArr.count){
            
            self.nameStr = nameArr[_seleType-1];
        }
        
        
        if(_dateType == 0){//年，往后6年
            NSArray *seledateArr = [_dateString componentsSeparatedByString:@"-"];
            NSString *yearStr = @"";
            if(seledateArr.count > 0){
                
                yearStr = seledateArr[0];
            }
            for (int i = 0; i < 6; i ++) {
                [_x_dataArr insertObject:[NSString stringWithFormat:@"%d",[yearStr intValue]-i] atIndex:0];
            }
            
            _charColorHex = @"#000000";//
        }
        if(_dateType == 1){//月
            
            for (int i = 0; i < _Y_dataArr.count; i ++) {
                [_x_dataArr addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            _charColorHex = @"#0000FF";//
        }
        if(_dateType == 2){//日
            for (int i = 0; i < _Y_dataArr.count; i ++) {
                [_x_dataArr addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            _charColorHex = @"#008000";//
        }
        chartModel = [self configureColumnChart:_Y_dataArr];
        
    }
    //区域
    if (_dateType == 3) {
        _Unitlabel.text = @"kW";
        NSArray *nameArr = @[home_PowerType1,
                             home_PowerType2,
                             home_PowerType3,
                             home_PowerType4
        ];
        if((_seleType-1) < nameArr.count){
            
            self.nameStr = nameArr[_seleType-1];
        }
        
        
        
//        int hourINT = 0;
//        int minINT = 0;
//        for (int i = 0; i < _Y_dataArr.count; i++) {
//
//            minINT += 5;
//            if(minINT == 60){
//
//                minINT = 0;
//                if(hourINT <= 23){
//                    hourINT++;
//
//                }
//            }
//            NSString *minstr = [NSString stringWithFormat:@"%d",minINT];
//            if(minINT < 10){
//
//                minstr = [NSString stringWithFormat:@"0%d",minINT];
//            }
//            NSString *hourstr = [NSString stringWithFormat:@"%d",hourINT];
//            if(hourINT < 10){
//                hourstr = [NSString stringWithFormat:@"0%d",hourINT];
//            }
//            [_x_dataArr addObject:[NSString stringWithFormat:@"%@:%@",hourstr,minstr]];
//        }
        
        _x_dataArr = _powerMapArr;
        
        _charColorHex = @"#FFA500";
        
        chartModel = [self configureAreaChart:_Y_dataArr];
        
    }
    
    
    // 设置下方的文字效果
    AAItemStyle *aaItemStyle = AAItemStyle.new
        .colorSet(@"#55b8e5")//字体颜色
        .cursorSet(@"pointer")//(在移动端这个属性没什么意义,其实不用设置)指定鼠标滑过数据列时鼠标的形状。当绑定了数据列点击事件时，可以将此参数设置为 "pointer"，用来提醒用户改数据列是可以点击的。
        .fontSizeSet(@"10px")//字体大小
        .fontWeightSet(AAChartFontWeightTypeThin);//字体为细体字
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:chartModel];
    aaOptions.legend.itemStyle = aaItemStyle;
    AATooltip *tooltip = aaOptions.tooltip;// 浮动框设置
    tooltip
        .valueDecimalsSet(@2)//设置取值精确到小数点后几位
        .backgroundColorSet(@"#000000")
        .borderColorSet(@"#000000")
        .styleSet((id)AAStyle.new
                  .colorSet(@"#ffffff")
                  .fontSizeSet(@"12px"))
    ;
    [aaChartView aa_drawChartWithOptions:aaOptions];
}

- (AAChartModel *)configureColumnChart:(NSArray *)dataArr{
    
    
    
    //    chartModel = AAChartModel.new
    //        .chartTypeSet(AAChartTypeColumn)//图表类型
    //        .subtitleFontSizeSet(@0)
    //        .titleFontSizeSet(@0)
    //        .markerRadiusSet(@0)
    //        .colorsThemeSet(@[@"#00fe7d",@"#fbd214",@"#ff653c",@"#ab8dff"])//设置主体颜色数组
    //        .tooltipValueSuffixSet(_unitstr)//设置浮动提示框单位后缀
    //        .yAxisLineWidthSet(@1)//Y轴轴线线宽为0即是隐藏Y轴轴线
    //        .yAxisTitleSet(@"")
    ////        .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])//y轴横向分割线宽度为0(即是隐藏分割线)
    //        .categoriesSet(_x_dataArr)//设置 X 轴坐标文字内容
    //        .animationTypeSet(AAChartAnimationEaseOutCubic)//图形的渲染动画类型为 EaseOutCubic
    //        .animationDurationSet(@(1200))//图形渲染动画时长为1200毫秒
    //        .seriesSet(@[
    //            AASeriesElement.new
    //                .colorSet(_charColorHex)
    //                .nameSet(_nameStr)
    //                .dataSet(dataArr)
    //        ]);
    NSNumber *wide = @0;
    NSString *titstr = @"";
    if (dataArr.count == 0 || [_isHaveData isEqualToString:@"0"]) {
        wide = @0;
        titstr = @"No chart data";
    }
    chartModel = AAChartModel.new
        .chartTypeSet(AAChartTypeColumn)//图表类型
        .colorsThemeSet(@[@"#00fe7d",@"#fbd214",@"#ff653c",@"#ab8dff"])//设置主体颜色数组
        .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
        .yAxisLineWidthSet(wide)//Y轴轴线线宽为0即是隐藏Y轴轴线
        .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])//y轴横向分割线宽度为0(即是隐藏分割线)
        .titleSet(titstr)
        .categoriesSet(_x_dataArr)//设置 X 轴坐标文字内容
        .animationTypeSet(AAChartAnimationEaseOutCubic)//图形的渲染动画类型为 EaseOutCubic
        .animationDurationSet(@(1200))//图形渲染动画时长为1200毫秒
        .seriesSet(@[
            AASeriesElement.new
                .colorSet(_charColorHex)
                .nameSet(_nameStr)
                .dataSet(dataArr)
        ]);
    
    
    chartModel.markerSymbolStyle = AAChartSymbolStyleTypeBorderBlank;//设置折线连接点样式为:边缘白色
    chartModel.xAxisCrosshair.color = @"#778899";
    chartModel.xAxisCrosshair.width = @1;
    chartModel.xAxisCrosshair.dashStyle = AAChartLineDashStyleTypeLongDashDot;
    chartModel.stacking = AAChartStackingTypeNormal;
    [aaChartView setIsClearBackgroundColor:YES];
    [aaChartView aa_drawChartWithChartModel:chartModel];
    return chartModel;
    
    
    
}



- (AAChartModel *)configurePieChart {
    
    NSArray *coloarr = @[@"#3366FF",@"#FF9900",@"#00FF00",@"#facd32",@"#ffffa0",@"#EA007B"];
    
    
    return AAChartModel.new
        .chartTypeSet(AAChartTypePie)
        .colorsThemeSet(coloarr)
        .dataLabelsEnabledSet(YES)//是否直接显示扇形图数据
        .yAxisTitleSet(@"Number")
        .seriesSet(@[
            AASeriesElement.new
                .nameSet(@"Number")
                .innerSizeSet(@"20%")//内部圆环半径大小占比
                .sizeSet(@(80*HEIGHT_SIZE))//尺寸大小
                .borderWidthSet(@0)//描边的宽度
                .allowPointSelectSet(true)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
                .statesSet(AAStates.new
                .hoverSet(AAHover.new
                .enabledSet(false)//禁用点击区块之后出现的半透明遮罩层
            ))
                .dataSet(@[])]);
}


- (AAChartModel *)configureAreaChart:(NSArray *)dataArr{
    
    NSNumber *wide = @0;
    NSString *titstr = @"";
    if (dataArr.count == 0 || [_isHaveData isEqualToString:@"0"]) {
        wide = @0;
        titstr = @"No chart data";
    }
    
    chartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeLine)//图形类型
    .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
    .yAxisLineWidthSet(wide)//Y轴轴线线宽为0即是隐藏Y轴轴线
    .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])//y轴横向分割线宽度为0(即是隐藏分割线)
    .categoriesSet(_x_dataArr)//设置 X 轴坐标文字内容
    .animationTypeSet(AAChartAnimationEaseOutCubic)//图形渲染动画类型为"bounce"
    .titleSet(titstr)//图形标题
    .subtitleSet(@"")//图形副标题
    .dataLabelsEnabledSet(NO)//是否显示数字
    .markerSymbolStyleSet(AAChartSymbolStyleTypeBorderBlank)//折线连接点样式
    .markerRadiusSet(@0)//折线连接点半径长度,为0时相当于没有折线连接点
    .seriesSet(@[AAObject(AASeriesElement)
                     .colorSet(_charColorHex)
                     .nameSet(_nameStr)
                     .dataSet(dataArr),
               ]);
    
//    chartModel = AAChartModel.new
//        .chartTypeSet(AAChartTypeSpline)//图表类型
//        .colorsThemeSet(@[@"#00fe7d",@"#fbd214",@"#ff653c",@"#ab8dff"])//设置主体颜色数组
//        .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
//        .yAxisLineWidthSet(@1)//Y轴轴线线宽为0即是隐藏Y轴轴线
//        .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])//y轴横向分割线宽度为0(即是隐藏分割线)
//        .categoriesSet(_x_dataArr)//设置 X 轴坐标文字内容
//        .animationTypeSet(AAChartAnimationEaseOutCubic)//图形的渲染动画类型为 EaseOutCubic
//        .animationDurationSet(@(1200))//图形渲染动画时长为1200毫秒
//        .seriesSet(@[AAObject(AASeriesElement)
//                         .colorSet(_charColorHex)
//                         .nameSet(_nameStr)
//                         .dataSet(dataArr),
//                   ]);
    
    
//        chartModel= AAObject(AAChartModel)
//            .chartTypeSet(AAChartTypeLine)//设置图表的类型(这里以设置的为柱状图为例)
//            .subtitleFontSizeSet(@0)
//            .titleFontSizeSet(@0)
//            .markerRadiusSet(@0)
//            .xAxisCrosshairColorSet(@"#1d3942")
//            .yAxisCrosshairColorSet(@"#1d3942")
//            .xAxisLabelsFontSizeSet(@12)
//            .yAxisLabelsFontSizeSet(@10)
//            .xAxisLabelsFontColorSet(@"#545454")
//            .yAxisLabelsFontColorSet(@"#545454")
//
//            .categoriesSet(_x_dataArr)
//            .yAxisLineWidthSet(@1)//Y轴轴线线宽为0即是隐藏Y轴轴线
//            .yAxisTitleSet(@"")//设置 Y 轴标题
//            .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
//            .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
//        //    .colorsThemeSet(@[@"#00fe7d",@"#fbd214",@"#ff653c",@"#ab8dff"])//设置主体颜色数组
//
//            .zoomTypeSet(AAChartZoomTypeX)
//            .seriesSet(@[AAObject(AASeriesElement)
//                .colorSet(_charColorHex)
//                .nameSet(_nameStr)
//                .dataSet(dataArr),
//            ]);
    
    chartModel.markerSymbolStyle = AAChartSymbolStyleTypeBorderBlank;//设置折线连接点样式为:边缘白色
    chartModel.xAxisCrosshair.color = @"#778899";
    chartModel.xAxisCrosshair.width = @1;
    chartModel.xAxisCrosshair.dashStyle = AAChartLineDashStyleTypeLongDashDot;

    //            chartModel.xAxisCrosshairWidth = @1;//Zero width to disable crosshair by default
//                chartModel.AACrosshair.xAxisCrosshairColor = @"#778899";//浅石板灰准星线
    //    chartModel.xAxisCrosshairDashStyleType = AAChartLineDashStyleTypeLongDashDot;
    chartModel.stacking = AAChartStackingTypeNormal;
    [aaChartView setIsClearBackgroundColor:YES];
    [aaChartView aa_drawChartWithChartModel:chartModel];
    return chartModel;
    
    
}


- (void)dateClick:(UIButton *)dateClick{
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"Select time type" titles:_dateNameArr selectIndex:^(NSInteger selectIndex) {
        self.dateType = (int)selectIndex;
        [self.titbtn setTitle:[self getDateString:self.dateString type:_dateKeyArr[selectIndex]] forState:UIControlStateNormal];
        [self getAllDevicedata];
        
    } selectValue:^(NSString *selectValue) {
        [dateClick setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        
    } showCloseButton:YES];
    
}

//获取
- (void)getAllDevicedata{
    
    
    NSDictionary *pramdic = @{@"plantId":_PlantID,@"type":[NSString stringWithFormat:@"%d",_seleType],@"date":_dateString};
    
    NSString *urlstr = @"/v1/plant/getEnergyYear";
    if(_dateType == 1){//月
        
        urlstr = @"/v1/plant/getEnergyMonth";
    }
    if(_dateType == 2){//日
        
        urlstr = @"/v1/plant/getEnergyDay";
    }
    if(_dateType == 3){//时
        
        urlstr = @"/v1/plant/getEnergyHour";
    }
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:urlstr parameters:pramdic Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self.bgscrollv.mj_header endRefreshing];
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            //            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            //            [self showToastViewWithTitle:msg];
            
            if ([result isEqualToString:@"0"]) {
                
                
                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSDictionary class]]){
                    _isHaveData = @"1";

                    NSDictionary *netDic = [NSDictionary dictionaryWithDictionary:objarr];
                    
                    UILabel *lowlb = [self.view viewWithTag:2000];
                    UILabel *avglb = [self.view viewWithTag:2001];
                    UILabel *hightlb = [self.view viewWithTag:2002];
                    
                    
                    UILabel *lowNamelb = [self.view viewWithTag:2100];
                    UILabel *avgNamelb = [self.view viewWithTag:2101];
                    UILabel *hightNamelb = [self.view viewWithTag:2102];
                    
                    
                    UIView *lowview = [self.view viewWithTag:4000];
                    UIView *avgview = [self.view viewWithTag:4001];
                    UIView *hightview = [self.view viewWithTag:4002];
                    
                    if(self.dateType == 3){
                        //                        NSString *lowEnergy = [NSString stringWithFormat:@"%@",netDic[@"lowPower"]];
                        //                        NSString *avgEnergy = [NSString stringWithFormat:@"%@",netDic[@"avgPower"]];
                        //                        NSString *highEnergy = [NSString stringWithFormat:@"%@",netDic[@"highPower"]];
                        NSString *totalEnergy = [NSString stringWithFormat:@"%@",netDic[@"energy"]];
                        
                        //                        lowNamelb.text = [NSString stringWithFormat:@"%@(kW)",home_dataStatu1];
                        //                        avgNamelb.text = [NSString stringWithFormat:@"%@(kW)",home_dataStatu2];
                        //                        hightNamelb.text = [NSString stringWithFormat:@"%@(kW)",home_dataStatu3];
                        
                        //                        lowlb.text = lowEnergy;
                        //                        avglb.text = avgEnergy;
                        //                        hightlb.text = highEnergy;
                        
                        lowview.hidden = YES;
                        avgview.hidden = YES;
                        hightview.hidden = YES;
                        
                        self->_leftUpValue.text = [NSString stringWithFormat:@"%@kWh",totalEnergy];
//                        id enerarr = netDic[@"power"];
                        id powerMapDic = netDic[@"powerMap"];

//                        if([enerarr isKindOfClass:[NSArray class]]){
//                            self->_Y_dataArr =  [NSMutableArray arrayWithArray:enerarr];//enerarr
//
//                        }
                        if([powerMapDic isKindOfClass:[NSDictionary class]]){
                            
                            NSDictionary *powerDict = (NSDictionary *)powerMapDic;
                            
                            NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
                            NSComparator sort = ^(NSString *obj1, NSString *obj2){
                                NSRange range = NSMakeRange(0, obj1.length);
                                return [obj1 compare:obj2 options:comparisonOptions range:range];
                            };
                            _powerMapArr = [NSMutableArray arrayWithArray:[powerDict.allKeys sortedArrayUsingComparator:sort]];
                            _Y_dataArr = [NSMutableArray array];
                            for (NSString *key in _powerMapArr) {
                                NSString *valuestr = [NSString stringWithFormat:@"%@",powerDict[key]];
                   
                                if (kStringIsEmpty(valuestr)) {
                                    valuestr = @"0";
                                }
                                NSNumber *valuNumb = [NSNumber numberWithFloat:[valuestr floatValue]];
                                [_Y_dataArr addObject:valuNumb];

                            }
                            
                                                        
                        }else{
                            [_Y_dataArr removeAllObjects];
                            _isHaveData = @"0";
                        }
                    }else{
                        lowview.hidden = NO;
                        avgview.hidden = NO;
                        hightview.hidden = NO;
                        
                        NSString *lowEnergy = [NSString stringWithFormat:@"%@",netDic[@"lowEnergy"]];
                        NSString *avgEnergy = [NSString stringWithFormat:@"%@",netDic[@"avgEnergy"]];
                        NSString *highEnergy = [NSString stringWithFormat:@"%@",netDic[@"highEnergy"]];
                        NSString *totalEnergy = [NSString stringWithFormat:@"%@",netDic[@"totalEnergy"]];
                        lowNamelb.text = [NSString stringWithFormat:@"%@(kWh)",home_dataStatu1];
                        avgNamelb.text = [NSString stringWithFormat:@"%@(kWh)",home_dataStatu2];
                        hightNamelb.text = [NSString stringWithFormat:@"%@(kWh)",home_dataStatu3];
                        
                        
                        lowlb.text = lowEnergy;
                        avglb.text = avgEnergy;
                        hightlb.text = highEnergy;
                        _leftUpValue.text = [NSString stringWithFormat:@"%@kWh",totalEnergy];
                        
                        id enerarr = netDic[@"energy"];
                        if([enerarr isKindOfClass:[NSArray class]]){
                            _Y_dataArr = [NSMutableArray arrayWithArray:enerarr];
                            _isHaveData = @"1";

                        }else{
                            [_Y_dataArr removeAllObjects];
                            _isHaveData = @"0";
                        }
                        
                    }
                    
                    
                    [self initAAChatView];
                    
                    
                }
                
            }
            //
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self.bgscrollv.mj_header endRefreshing];

        if (error) {
            [self showToastViewWithTitle:linkTimeOut1];

        }
        _isHaveData = @"0";
        [_Y_dataArr removeAllObjects];

        [self initAAChatView];
    }];
}
@end
