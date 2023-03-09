//
//  WeOverDataVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/26.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeImpactVC.h"
#import "AAChartKit.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "CGXPickerView.h"
@interface WeImpactVC (){
    
    AAChartView *aaChartView;
    AAChartModel *chartModel;
    int segmentSelect;
    NSString *dateselect;

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
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *datePickerButton;

@property (nonatomic, strong) NSDateFormatter *dayFormatter; // 获取日期
@property (nonatomic, strong) NSArray *dateNameArr;
@property (nonatomic, strong) NSArray *dateKeyArr;
@property (nonatomic, strong) UIView *solarView;
@property (nonatomic, strong) UIView *loadPView;
@property (nonatomic, strong) UIView *linePreView;

@property (nonatomic, strong) UILabel *SolarValueLB;
@property (nonatomic, strong) UILabel *loadValueLB;
@property (nonatomic, strong) UILabel *offsetPreLB;
@property (nonatomic, strong) NSString *incomeUnit;
@property (nonatomic, assign) CGFloat solarsetY;
@property (nonatomic, strong) UILabel *nowtimeLB;
@property (nonatomic, strong) NSString *isHaveData;


@end

@implementation WeImpactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = home_Impact;
    self.view.backgroundColor = COLOR(244, 244, 244, 1);
    
    
    _dateNameArr = @[[NSString stringWithFormat:@" %@",home_dateName1],
                     [NSString stringWithFormat:@" %@",home_dateName2],
                     [NSString stringWithFormat:@" %@",home_dateName3],
    ];//,@"Week"
    _dateKeyArr = @[@"year",@"month",@"day"];
    segmentSelect = 2;
    
    UIButton *rigbtn = [self goToInitButton:CGRectMake(0, 0, 80*HEIGHT_SIZE, 20*HEIGHT_SIZE) TypeNum:3 fontSize:14*HEIGHT_SIZE titleString:_dateNameArr[segmentSelect] selImgString:@"WedateImg" norImgString:@"WedateImg"];
    [rigbtn setTitleColor:colorBlack forState:UIControlStateNormal];
    rigbtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [rigbtn addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rigbtn];
    [self getDateData];
    
  
    
    [self createUI];
    [self getAllDevicedata];
    // Do any additional setup after loading the view.
}

- (void)getDateData{
    
    // 获取当天时间
    self.dayFormatter = [[NSDateFormatter alloc] init];
    self.dayFormatter .locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [self.dayFormatter   setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [self.dayFormatter stringFromDate:[NSDate date]];
    
//    NSArray *timearr = [time componentsSeparatedByString:@"-"];

    dateselect = time;//[self.dayFormatter stringFromDate:[NSDate date]];

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
    
//    UIView *bg1view = [self goToInitView:CGRectMake(0, 0, kScreenWidth, 40*HEIGHT_SIZE) backgroundColor:WhiteColor];
//    [_bgscrollv addSubview:bg1view];
    
//    [self creatDateUI:bg1view];
//    UILabel *loadULB = [self goToInitLable:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 80*NOW_SIZE, 25*HEIGHT_SIZE) textName:@"Load Usage" textColor:colorblack_154 fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    [bg1view addSubview:loadULB];
//    UILabel *loadDataLB = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(loadULB.frame), 80*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"88.7kWh" textColor:colorBlack fontFloat:16*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    [bg1view addSubview:loadDataLB];
//
//    NSArray *NomalNameArr = @[@"energyUnSelect",@"PPVUnSelect",@"GridUnSelect",@"batUnSelect"];
//    NSArray *selectNameArr = @[@"energySelect",@"PPVSelect",@"GridSelect",@"batSelect"];
//
//    for (int i = 0; i < NomalNameArr.count; i++) {
//
//        UIButton *onebtn = [self goToInitButton:CGRectMake(kScreenWidth-10*NOW_SIZE-45*HEIGHT_SIZE*4 + 45*HEIGHT_SIZE*i, 10*HEIGHT_SIZE, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE) TypeNum:2 fontSize:12 titleString:@"" selImgString:selectNameArr[i] norImgString:NomalNameArr[i]];
//        onebtn.tag = 100+i;
//        [bg1view addSubview:onebtn];
//
//        [onebtn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
//        if(i == 0){
//
//            onebtn.selected = YES;
//        }
//    }
//    _unitstr = @"kWh";
    _seleType = 1;
    _AACY = 10*HEIGHT_SIZE;
//    [self initAAChatView];
    CGFloat nextY = 240*HEIGHT_SIZE+20*HEIGHT_SIZE+20*HEIGHT_SIZE+_AACY;
//    UIView *linev = [self goToInitView:CGRectMake(20*NOW_SIZE, nextY+10*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 1*HEIGHT_SIZE) backgroundColor:colorblack_154];
//    [_bgscrollv addSubview:linev];
//
//    UILabel *solarlb = [self goToInitLable:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(linev.frame)+10*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 30*HEIGHT_SIZE) textName:home_SOffset textColor:colorBlack fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    [_bgscrollv addSubview:solarlb];
//
//    UILabel *timeNowLB = [self goToInitLable:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(solarlb.frame), kScreenWidth-40*NOW_SIZE, 25*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    [_bgscrollv addSubview:timeNowLB];
//    _nowtimeLB = timeNowLB;
//    _solarsetY = CGRectGetMaxY(timeNowLB.frame)+10*HEIGHT_SIZE;
//
//    UIView *solarLefLb = [self goToInitView:CGRectMake(kScreenWidth/2-40*NOW_SIZE-30*NOW_SIZE, _solarsetY+80*HEIGHT_SIZE+60*HEIGHT_SIZE-1*HEIGHT_SIZE, 30*NOW_SIZE, 1*HEIGHT_SIZE) backgroundColor:[UIColor orangeColor]];
//    solarLefLb.layer.cornerRadius = 10*HEIGHT_SIZE;
//    solarLefLb.layer.masksToBounds = YES;
//    [_bgscrollv addSubview:solarLefLb];
//    _solarView = solarLefLb;
//
//    UILabel *solarValueLb = [self goToInitLable:CGRectMake(CGRectGetMaxX(solarLefLb.frame)-100*NOW_SIZE, CGRectGetMaxY(solarLefLb.frame)+10*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"0KWh%@",WeSolar] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
//    solarValueLb.tag = 2000;
//    solarValueLb.numberOfLines = 0;
//    [_bgscrollv addSubview:solarValueLb];
//    _SolarValueLB = solarValueLb;
//    [self set_DesignatedTextForLabel:solarValueLb text:WeSolar color:colorblack_186];
//
////    UILabel *solarValueLb2 = [self goToInitLable:CGRectMake(CGRectGetMaxX(solarValueLb.frame), CGRectGetMaxY(solarLefLb.frame)+10*HEIGHT_SIZE, 50*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"Solar" textColor:colorblack_186 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
////    [_bgscrollv addSubview:solarValueLb2];
//
//
//    UIView *linv22 = [self goToInitView:CGRectMake(CGRectGetMaxX(solarLefLb.frame)+3*NOW_SIZE, solarLefLb.xmg_y, 80*NOW_SIZE, 0.8*HEIGHT_SIZE) backgroundColor:colorblack_154];
//    [_bgscrollv addSubview:linv22];
//    _linePreView = linv22;
//
//    UILabel *valuLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(solarLefLb.frame)+3*NOW_SIZE, CGRectGetMaxY(linv22.frame), 80*NOW_SIZE, 50*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"0%%\n%@",home_EnOffset] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    valuLB.tag = 2001;
//    valuLB.numberOfLines = 0;
//    [_bgscrollv addSubview:valuLB];
//    _offsetPreLB = valuLB;
//    [self set_DesignatedTextForLabel:valuLB text:home_EnOffset color:colorblack_186];
//
////    UILabel *valuLB2 = [self goToInitLable:CGRectMake(CGRectGetMaxX(solarLefLb.frame)+3*NOW_SIZE, CGRectGetMaxY(valuLB.frame), 80*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"Energy Offset" textColor:colorblack_186 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
////    [_bgscrollv addSubview:valuLB2];
////    _loadPre2LB = valuLB2;
//
//    UIView *loadrightLb = [self goToInitView:CGRectMake(CGRectGetMaxX(valuLB.frame)+3*NOW_SIZE, _solarsetY+80*HEIGHT_SIZE+60*HEIGHT_SIZE-1*HEIGHT_SIZE, 30*NOW_SIZE, 1*HEIGHT_SIZE) backgroundColor:COLOR(59, 106, 252, 1)];
//    loadrightLb.layer.cornerRadius = 10*HEIGHT_SIZE;
//    loadrightLb.layer.masksToBounds = YES;
//    [_bgscrollv addSubview:loadrightLb];
//    _loadPView = loadrightLb;
//
//    UILabel *loadValueLb = [self goToInitLable:CGRectMake(loadrightLb.xmg_x, CGRectGetMaxY(loadrightLb.frame)+10*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"0KWh%@",home_Load] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    loadValueLb.tag = 2002;
//    loadValueLb.numberOfLines = 0;
//
//    [_bgscrollv addSubview:loadValueLb];
//    _loadValueLB = loadValueLb;
//    [self set_DesignatedTextForLabel:loadValueLb text:home_Load color:colorblack_186];
    
    
    
    
//    UILabel *loadValueLb2 = [self goToInitLable:CGRectMake(CGRectGetMaxX(loadValueLb.frame), CGRectGetMaxY(loadrightLb.frame)+10*HEIGHT_SIZE, 30*NOW_SIZE+loadrightLb.xmg_width/2, 30*HEIGHT_SIZE) textName:@"Load" textColor:colorblack_186 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    [_bgscrollv addSubview:loadValueLb2];
    
//    NSArray *dataNameArr = @[@"Low",@"Avg",@"High"];
//    NSArray *dataValueArr = @[@"5kWh",@"5kWh",@"5kWh"];
//    CGFloat viewWide = (kScreenWidth-20*NOW_SIZE-10*NOW_SIZE)/3;
//    for (int i = 0; i < dataNameArr.count; i++) {
//        UIView *onev = [self goToInitView:CGRectMake(10*NOW_SIZE+(viewWide+5*NOW_SIZE)*i, CGRectGetMaxY(_aachartbgview.frame)+10*HEIGHT_SIZE, viewWide, 80*HEIGHT_SIZE) backgroundColor:WhiteColor];
//        onev.layer.cornerRadius = 10*HEIGHT_SIZE;
//        onev.layer.masksToBounds = YES;
//        onev.layer.shadowOffset = CGSizeMake(0, 0);
//        onev.layer.shadowOpacity = 1;
//        onev.layer.shadowRadius = 20*HEIGHT_SIZE;
//        onev.layer.shadowColor = colorBlack.CGColor;
//        [_bgscrollv addSubview:onev];
//
//        UILabel *valuLB = [self goToInitLable:CGRectMake(0, 0, onev.xmg_width, 40*HEIGHT_SIZE) textName:dataValueArr[i] textColor:colorBlack fontFloat:16*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
//        [onev addSubview:valuLB];
//
//        UILabel *nameLB = [self goToInitLable:CGRectMake(0, CGRectGetMaxY(valuLB.frame), onev.xmg_width, 40*HEIGHT_SIZE) textName:dataNameArr[i] textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
//        [onev addSubview:nameLB];
//
//    }
//
//    UIButton *downBtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(_aachartbgview.frame)+10*HEIGHT_SIZE+80*HEIGHT_SIZE+50*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:3 fontSize:14*HEIGHT_SIZE titleString:@" Download My Data" selImgString:@"WedownLoad" norImgString:@"WedownLoad"];
//    [downBtn setTitleColor:COLOR(250, 250, 250, 1) forState:UIControlStateNormal];
//    downBtn.layer.cornerRadius = 45*HEIGHT_SIZE/2;
//    downBtn.layer.masksToBounds = YES;
//    downBtn.backgroundColor = backgroundNewColor;
//    [_bgscrollv addSubview:downBtn];
    
    _bgscrollv.contentSize = CGSizeMake(kScreenWidth, nextY+kNavBarHeight+20*HEIGHT_SIZE);
}

//- (void)typeClick:(UIButton *)clickBtn{
//
//    for (int i = 0; i < 4; i ++) {
//        UIButton *onebtn = [self.view viewWithTag:100+i];
//        onebtn.selected = NO;
//    }
//    clickBtn.selected = YES;
//
//    _seleType = (int)(clickBtn.tag - 100+1);
//
////    _unitstr = @"kWh";
//
////    [self initAAChatView];
//}

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
    
//    _x_dataArr = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
//    _Y_dataArr = [NSMutableArray arrayWithArray:@[@14,@244,@323,@46,@52,@61,@79,@87,@98,@1075,@114,@126]];
    _x_dataArr = [[NSMutableArray alloc]init];

    //柱形
    if (segmentSelect == 0 || segmentSelect == 1 || segmentSelect == 2) {
        _Unitlabel.text = _incomeUnit;

        if(segmentSelect == 0){//年，往后6年
            NSArray *seledateArr = [dateselect componentsSeparatedByString:@"-"];
            NSString *yearStr = @"";
            if(seledateArr.count > 0){
                
                yearStr = seledateArr[0];
            }
            for (int i = 0; i < 6; i ++) {
                [_x_dataArr insertObject:[NSString stringWithFormat:@"%d",[yearStr intValue]-i] atIndex:0];
            }
                        
            _charColorHex = @"#FFA500";//
        }
        if(segmentSelect == 1){//月
            
            for (int i = 0; i < _Y_dataArr.count; i ++) {
                [_x_dataArr addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            _charColorHex = @"#FFA500";//
        }
        if(segmentSelect == 2){//日
            for (int i = 0; i < _Y_dataArr.count; i ++) {
                [_x_dataArr addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            _charColorHex = @"#FFA500";//
        }
        chartModel = [self configureColumnChart:_Y_dataArr];

    }
//    //区域
//    if (segmentSelect == 3) {
//        _Unitlabel.text = @"KW";
//
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
//
//
//
//        _charColorHex = @"#FFA500";
//
//        chartModel = [self configureAreaChart:_Y_dataArr];
//
//    }
 
    
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
    NSNumber *wide = @1;
    NSString *titstr = @"";
    if (dataArr.count == 0 || [_isHaveData isEqualToString:@"0"]) {
        wide = @0;
        titstr = @"No chart data";
    }
    
    chartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeColumn)//图表类型
    .colorsThemeSet(@[@"#00fe7d",@"#fbd214",@"#ff653c",@"#ab8dff"])//设置主体颜色数组
    .tooltipValueSuffixSet([NSString stringWithFormat:@"(%@)",_incomeUnit])//设置浮动提示框单位后缀
    .yAxisLineWidthSet(@1)//Y轴轴线线宽为0即是隐藏Y轴轴线
    .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])//y轴横向分割线宽度为0(即是隐藏分割线)
    .categoriesSet(_x_dataArr)//设置 X 轴坐标文字内容
    .animationTypeSet(AAChartAnimationEaseOutCubic)//图形的渲染动画类型为 EaseOutCubic
    .animationDurationSet(@(1200))//图形渲染动画时长为1200毫秒
    .seriesSet(@[
        AASeriesElement.new
            .colorSet(_charColorHex)
            .nameSet(@"Income")
            .dataSet(dataArr)
    ]);

    
    
    
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
//                .nameSet(@"Energy Value")
//                .dataSet(dataArr)
//        ]);
    
    
    chartModel.markerSymbolStyle = AAChartSymbolStyleTypeBorderBlank;//设置折线连接点样式为:边缘白色
    //            chartModel.xAxisCrosshairWidth = @1;//Zero width to disable crosshair by default
    //            chartModel.xAxisCrosshairColor = @"#778899";//浅石板灰准星线
    //    chartModel.xAxisCrosshairDashStyleType = AAChartLineDashStyleTypeLongDashDot;
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
    
    chartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeArea)//图表类型
    .colorsThemeSet(@[@"#00fe7d",@"#fbd214",@"#ff653c",@"#ab8dff"])//设置主体颜色数组
    .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
    .yAxisLineWidthSet(@1)//Y轴轴线线宽为0即是隐藏Y轴轴线
    .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])//y轴横向分割线宽度为0(即是隐藏分割线)
    .categoriesSet(_x_dataArr)//设置 X 轴坐标文字内容
    .animationTypeSet(AAChartAnimationEaseOutCubic)//图形的渲染动画类型为 EaseOutCubic
    .animationDurationSet(@(1200))//图形渲染动画时长为1200毫秒
    .seriesSet(@[AAObject(AASeriesElement)
                     .colorSet(_charColorHex)
                     .nameSet(@"")
                     .dataSet(dataArr),
                 ]);
    
    
//    chartModel= AAObject(AAChartModel)
//        .chartTypeSet(AAChartTypeArea)//设置图表的类型(这里以设置的为柱状图为例)
//        .subtitleFontSizeSet(@0)
//        .titleFontSizeSet(@0)
//        .markerRadiusSet(@0)
//        .xAxisCrosshairColorSet(@"#1d3942")
//        .yAxisCrosshairColorSet(@"#1d3942")
//        .xAxisLabelsFontSizeSet(@12)
//        .yAxisLabelsFontSizeSet(@10)
//        .xAxisLabelsFontColorSet(@"#545454")
//        .yAxisLabelsFontColorSet(@"#545454")
//
//        .categoriesSet(_x_dataArr)
//        .yAxisLineWidthSet(@1)//Y轴轴线线宽为0即是隐藏Y轴轴线
//        .yAxisTitleSet(@"")//设置 Y 轴标题
//        .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
//        .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
//    //    .colorsThemeSet(@[@"#00fe7d",@"#fbd214",@"#ff653c",@"#ab8dff"])//设置主体颜色数组
//
//        .zoomTypeSet(AAChartZoomTypeX)
//        .seriesSet(@[AAObject(AASeriesElement)
//            .colorSet(_charColorHex)
//            .nameSet(@"")
//            .dataSet(dataArr),
//        ]);
    
    chartModel.markerSymbolStyle = AAChartSymbolStyleTypeBorderBlank;//设置折线连接点样式为:边缘白色
    //            chartModel.xAxisCrosshairWidth = @1;//Zero width to disable crosshair by default
    //            chartModel.xAxisCrosshairColor = @"#778899";//浅石板灰准星线
    //    chartModel.xAxisCrosshairDashStyleType = AAChartLineDashStyleTypeLongDashDot;
    chartModel.stacking = AAChartStackingTypeNormal;
    [aaChartView setIsClearBackgroundColor:YES];
    [aaChartView aa_drawChartWithChartModel:chartModel];
    return chartModel;
    
    
}


- (void)dateClick:(UIButton *)dateClick{
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"Select time type" titles:_dateNameArr selectIndex:^(NSInteger selectIndex) {
        
        self->segmentSelect = (int)selectIndex;
        [self.datePickerButton setTitle:[self getDateString:self->dateselect type:self->_dateKeyArr[selectIndex]] forState:UIControlStateNormal];
        [self getAllDevicedata];
        
    } selectValue:^(NSString *selectValue) {
        [dateClick setTitle:selectValue forState:UIControlStateNormal];

    } showCloseButton:YES];
    
}

- (void)creatDateUI:(UIView *)timeDisplayView{
    
    float timeH=40*HEIGHT_SIZE;  float timeW=ScreenWidth/2;
    //时间选择器
    
    float ButtonW2=25*HEIGHT_SIZE;float ButtonH2=25*HEIGHT_SIZE; float K2=2*NOW_SIZE;
    _lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastButton.frame = CGRectMake(kScreenWidth/2-50*HEIGHT_SIZE-25*HEIGHT_SIZE,(timeDisplayView.xmg_height-25*HEIGHT_SIZE)*0.5, 25*HEIGHT_SIZE, 25*HEIGHT_SIZE);
//    [self.lastButton setTitle:@"<" forState:UIControlStateNormal];
//    [self.lastButton setTitleColor:colorBlack forState:UIControlStateNormal];
    [self.lastButton setImage:[UIImage imageNamed:@"st_last_click"] forState:UIControlStateNormal];
    //self.lastButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.lastButton.tag = 1004;
    [self.lastButton addTarget:self action:@selector(lastDate:) forControlEvents:UIControlEventTouchUpInside];
    [timeDisplayView addSubview:self.lastButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(kScreenWidth/2+50*HEIGHT_SIZE, (timeDisplayView.xmg_height-25*HEIGHT_SIZE)*0.5, 25*HEIGHT_SIZE, 25*HEIGHT_SIZE);
    [self.nextButton setImage:[UIImage imageNamed:@"st_next_click"] forState:UIControlStateNormal];
//    [self.lastButton setTitle:@"<" forState:UIControlStateNormal];
    [self.lastButton setTitleColor:colorBlack forState:UIControlStateNormal];
    //self.nextButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.nextButton.tag = 1005;
    [self.nextButton addTarget:self action:@selector(nextDate:) forControlEvents:UIControlEventTouchUpInside];
    [timeDisplayView addSubview:self.nextButton];
    
    float ButtonW3=timeW-ButtonW2-ButtonW2-K2*4;
    self.datePickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.datePickerButton.frame = CGRectMake(CGRectGetMaxX(_lastButton.frame),5*HEIGHT_SIZE, 100*HEIGHT_SIZE, 30*HEIGHT_SIZE);
    [self.datePickerButton setTitle:[self getDateString:dateselect type:_dateKeyArr[0]] forState:UIControlStateNormal];
    [self.datePickerButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
    self.datePickerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.datePickerButton addTarget:self action:@selector(pickDate:) forControlEvents:UIControlEventTouchUpInside];
    [timeDisplayView addSubview:self.datePickerButton];
}

#pragma mark -- 时间选择
- (void)pickDate:(UIButton *)button{
    //TODO: 选择日期
    [CGXPickerView showDatePickerWithTitle:root_xuanzeshijian DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
        
        
        NSString *dtype = self.dateKeyArr[segmentSelect];
        // 判断是否选择未来时间
        if ([self compareDate:[self getDateString:selectValue type:dtype]]) {
            [self showAlertViewWithTitle:root_Alet_user message:root_wufa_chakan_weilai_shuju cancelButtonTitle:root_OK];
            return;
        }
        dateselect = selectValue;
        
        if(segmentSelect < _dateKeyArr.count){
            
            [_datePickerButton setTitle:[self getDateString:dateselect type:_dateKeyArr[segmentSelect]] forState:UIControlStateNormal];
            [self getAllDevicedata];
        }
       

//        if (segmentSelect == 0) { //
//            [_datePickerButton setTitle:[self getDateString:dateselect type:@"year"] forState:UIControlStateNormal];
////            [self requestDayDatasWithDayString:[self getDateString:dateselect type:@"day"]];
//        } else if (segmentSelect == 1){ //
//            [_datePickerButton setTitle:[self getDateString:dateselect type:@"month"] forState:UIControlStateNormal];
////            [self requestMonthDatasWithMonthString:[self getDateString:dateselect type:@"month"]];
//        } else if (segmentSelect == 2){ //
//            [_datePickerButton setTitle:[self getDateString:dateselect type:@"day"] forState:UIControlStateNormal];
////            [self requestYearDatasWithYearString:[self getDateString:dateselect type:@"year"]];
//        }
    }];
}


//TODO: 上一天，月，年
- (void)lastDate:(UIButton *)button{
    
    if (segmentSelect == 2) { // 实时
        NSDate *currentDayDate = [self.dayFormatter dateFromString:dateselect];
        NSDate *yesterday = [currentDayDate dateByAddingTimeInterval:-24*60*60];
        dateselect = [self.dayFormatter stringFromDate:yesterday];
//        [_datePickerButton setTitle:[self getDateString:dateselect type:@"day"] forState:UIControlStateNormal];
//        [self requestDayDatasWithDayString:[self getDateString:dateselect type:@"day"]];
    } else if (segmentSelect == 1){ // 月
        NSDate *currentDayDate = [self.dayFormatter dateFromString:dateselect];
        NSDate *lastMonth = [currentDayDate dateByAddingTimeInterval:-24*60*60*30];
        dateselect = [self.dayFormatter stringFromDate:lastMonth];
//        [_datePickerButton setTitle:[self getDateString:dateselect type:@"month"] forState:UIControlStateNormal];
//        [self requestMonthDatasWithMonthString:[self getDateString:dateselect type:@"month"]];
    } else if (segmentSelect == 0){ // 年
        NSDate *currentDayDate = [self.dayFormatter dateFromString:dateselect];
        NSDate *lastYear = [currentDayDate dateByAddingTimeInterval:-24*60*60*365];
        dateselect = [self.dayFormatter stringFromDate:lastYear];
//        [_datePickerButton setTitle:[self getDateString:dateselect type:@"year"] forState:UIControlStateNormal];
//        [self requestYearDatasWithYearString:[self getDateString:dateselect type:@"year"]];
    }
    [_datePickerButton setTitle:[self getDateString:dateselect type:_dateKeyArr[segmentSelect]] forState:UIControlStateNormal];
    [self getAllDevicedata];

    
}
//TODO: 下一天，月，年
- (void)nextDate:(UIButton *)button{
    NSString *dtype = _dateKeyArr[segmentSelect];
    // 判断是否选择未来时间
    if ([self compareDate:[self getDateString:dateselect type:dtype]]) {
        [self showAlertViewWithTitle:root_Alet_user message:root_wufa_chakan_weilai_shuju cancelButtonTitle:root_OK];
        return;
    }
    if (segmentSelect == 2) { // 实时
        NSDate *currentDayDate = [self.dayFormatter dateFromString:dateselect];
        NSDate *yesterday = [currentDayDate dateByAddingTimeInterval:24*60*60];
        dateselect = [self.dayFormatter stringFromDate:yesterday];
//        [_datePickerButton setTitle:dateselect forState:UIControlStateNormal];
//        [self requestDayDatasWithDayString:[self getDateString:dateselect type:@"day"]];
    } else if (segmentSelect == 1){ // 月
        NSDate *currentDayDate = [self.dayFormatter dateFromString:dateselect];
        NSDate *lastMonth = [currentDayDate dateByAddingTimeInterval:24*60*60*30];
        dateselect = [self.dayFormatter stringFromDate:lastMonth];
//        [_datePickerButton setTitle:[self getDateString:dateselect type:@"month"] forState:UIControlStateNormal];
//        [self requestMonthDatasWithMonthString:[self getDateString:dateselect type:@"month"]];
    } else if (segmentSelect == 0){ // 年
        NSDate *currentDayDate = [self.dayFormatter dateFromString:dateselect];
        NSDate *lastYear = [currentDayDate dateByAddingTimeInterval:24*60*60*365];
        dateselect = [self.dayFormatter stringFromDate:lastYear];
//        [_datePickerButton setTitle:[self getDateString:dateselect type:@"year"] forState:UIControlStateNormal];
//        [self requestYearDatasWithYearString:[self getDateString:dateselect type:@"year"]];
    }
    [_datePickerButton setTitle:[self getDateString:dateselect type:_dateKeyArr[segmentSelect]] forState:UIControlStateNormal];
    [self getAllDevicedata];

    
}

// 判断时间是否为未来的时间
- (BOOL)compareDate:(NSString *)sDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDayStr = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *dayArr = [currentDayStr componentsSeparatedByString:@"-"];
    NSInteger currentDays = 0;
    
    NSArray *selectArr = [sDate componentsSeparatedByString:@"-"]; // 选择的时间
    NSInteger selectDays = 0;
    if (selectArr[0]) {
        selectDays += [selectArr[0] integerValue]*365;
        currentDays = [dayArr[0] integerValue]*365;
    }
    if (selectArr[1]) {
        selectDays += [selectArr[1] integerValue]*30;
        currentDays += + [dayArr[1] integerValue]*30;
    }
    if (selectArr[2]) {
        selectDays += [selectArr[2] integerValue];
        currentDays += + [dayArr[2] integerValue];
    }
    // 选择的时间小于当前时间
    if (selectDays < currentDays) {
        return NO;
    }
    
    return YES;
}
// 根据输入的时间，读取年，月，日
- (NSString *)getDateString:(NSString *)dateString type:(NSString *)type{
    
    NSArray *array = [dateString componentsSeparatedByString:@"-"];
    if ([type isEqualToString:@"day"]) {
        return [NSString stringWithFormat:@"%@-%@-%@", array[0],array[1],array[2]];
    } else if ([type isEqualToString:@"month"]) {
        return [NSString stringWithFormat:@"%@-%@", array[0],array[1]];
    } else if ([type isEqualToString:@"year"]) {
        return array[0];
    }
    return @"";
}


//获取
- (void)getAllDevicedata{
    
    
    NSDictionary *pramdic = @{@"plantId":_PlantID};//,@"date":dateselect
    
    NSString *urlstr = @"/v1/plant/getEnergyImpactYear";
    if(segmentSelect == 1){//月
        
        urlstr = @"/v1/plant/getEnergyImpactMonth";
    }
    if(segmentSelect == 2){//日
        
        urlstr = @"/v1/plant/getEnergyImpactDay";
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
                    
                    NSDictionary *netDic = [NSDictionary dictionaryWithDictionary:objarr];
              
                    _incomeUnit = [NSString stringWithFormat:@"%@",netDic[@"incomeUnit"]];

                    NSString *pvEnergy = [NSString stringWithFormat:@"%@",netDic[@"pvEnergy"]];
                    NSString *loadEnergy = [NSString stringWithFormat:@"%@",netDic[@"loadEnergy"]];
                    NSString *impactPvLoadDate = [NSString stringWithFormat:@"%@",netDic[@"impactPvLoadDate"]];

                    _nowtimeLB.text = impactPvLoadDate;
                    _SolarValueLB.text = [NSString stringWithFormat:@"%@kWh%@",netDic[@"pvEnergy"],WeSolar];
                    _SolarValueLB.textColor = colorBlack;
                    [self set_DesignatedTextForLabel:_SolarValueLB text:WeSolar color:colorblack_186];

                    _loadValueLB.text = [NSString stringWithFormat:@"%@kWh%@",netDic[@"loadEnergy"],home_Load];
                    _loadValueLB.textColor = colorBlack;
                    [self set_DesignatedTextForLabel:_loadValueLB text:home_Load color:colorblack_186];

                    _offsetPreLB.text = [NSString stringWithFormat:@"%@%%\n%@",netDic[@"pvLoadPerce"],home_EnOffset];
                    _offsetPreLB.textColor = colorBlack;
                    [self set_DesignatedTextForLabel:_offsetPreLB text:home_EnOffset color:colorblack_186];

                    
                    
//                    if([loadEnergy floatValue] >= 0 && [pvEnergy floatValue] >= 0){
//
//                        if([loadEnergy floatValue] == 0 && [pvEnergy floatValue] == 0){
//                            _solarView.frame = CGRectMake(kScreenWidth/2-40*NOW_SIZE-30*NOW_SIZE, _solarsetY+140*HEIGHT_SIZE-1*HEIGHT_SIZE, 30*NOW_SIZE, 1*HEIGHT_SIZE);
////                            _solarView.xmg_height = _loadPView.xmg_height;
//
//                            _loadPView.frame = CGRectMake(_loadPView.xmg_x, _solarsetY+140*HEIGHT_SIZE-1*HEIGHT_SIZE, 30*NOW_SIZE, 1*HEIGHT_SIZE);
//
//
//                            _linePreView.xmg_y = _loadPView.xmg_y;
//                            _offsetPreLB.xmg_y = CGRectGetMaxY(_linePreView.frame);
//
//                        }else if([pvEnergy floatValue] >= [loadEnergy floatValue] && [pvEnergy floatValue] > 0){
//
//                            float prec = [loadEnergy floatValue]/[pvEnergy floatValue];
//
//                            float otherPre =  1-prec;
//
//                            _solarView.frame = CGRectMake(kScreenWidth/2-40*NOW_SIZE-30*NOW_SIZE, _solarsetY, 30*NOW_SIZE, 140*HEIGHT_SIZE);
////                            _solarView.xmg_height = _loadPView.xmg_height;
//
//                            _loadPView.frame = CGRectMake(_loadPView.xmg_x, _solarView.frame.origin.y+_solarView.frame.size.height * otherPre, 30*NOW_SIZE, _solarView.frame.size.height * (1-otherPre));
//
//
//                            _linePreView.xmg_y = _loadPView.xmg_y;
//                            _offsetPreLB.xmg_y = CGRectGetMaxY(_linePreView.frame);
//                        }else{
//
//                            if ([loadEnergy floatValue] > 0) {
//                                float prec = [pvEnergy floatValue]/[loadEnergy floatValue];
//
//                                float otherPre =  1-prec;
//                                _loadPView.frame = CGRectMake(_loadPView.xmg_x, _solarsetY, 30*NOW_SIZE, 140*HEIGHT_SIZE);
//
//                                _solarView.frame = CGRectMake(_solarView.xmg_x, _solarsetY+_loadPView.frame.size.height * otherPre, 30*NOW_SIZE, _loadPView.frame.size.height * (1-otherPre));
//
//    //                            _solarView.xmg_y = _loadPView.xmg_y+(_loadPView.xmg_height)*otherPre;
//    //                            _solarView.xmg_height = _loadPView.xmg_height - _solarView.xmg_y;
//                                _linePreView.xmg_y = _solarView.xmg_y;
//                                _offsetPreLB.xmg_y = CGRectGetMaxY(_linePreView.frame);
//                            }
//
//                        }
//
//
//                    }
                    
                    

                    id enerarr = netDic[@"saveCosts"];
                    if([enerarr isKindOfClass:[NSArray class]]){
                        _Y_dataArr = [NSMutableArray arrayWithArray:enerarr];
                        _isHaveData = @"1";

                    }else{
                        _isHaveData = @"0";
                        [_Y_dataArr removeAllObjects];
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
