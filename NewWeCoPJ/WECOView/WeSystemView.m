//
//  WeSystemView.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/24.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeSystemView.h"
@interface WeSystemView (){
    float animalUnitLong;
    float animalUnitShort;
    float animalUnitOff;
    NSInteger allStatue;
    NSArray*lableNameArray;
    NSArray*lableValueArray;
    NSArray*liuxiangArray;
    NSArray *unitValueArray;
    NSString*powerUnit;
    float animalAll_H;
    float animalAll_H2;
    float TIME;
}
@end

@implementation WeSystemView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = WhiteColor;
        //        [self createSystemUI];
    }
    return self;
}

- (void)createSystemUI{
    
    
    
    NSString *soc00Value = [NSString stringWithFormat:@"%@",_dataDic[@"batterySoc"]];
    
    if ([soc00Value containsString:@"%"]) {
        NSArray *socarr = [soc00Value componentsSeparatedByString:@"%"];
        soc00Value = socarr.firstObject;
    }
    
    //    NSString *powerUnit = @"W";
    //    float animalH_K=10*HEIGHT_SIZE,animalW_K=26*NOW_SIZE;
    animalAll_H=30*HEIGHT_SIZE;
    animalAll_H2=30*HEIGHT_SIZE;
    TIME = 0.3;
    
    UIView *onlinev = [self goToInitView:CGRectMake(self.xmg_width/2-80*HEIGHT_SIZE/2, 5*HEIGHT_SIZE, 80*HEIGHT_SIZE, 30*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    [self addSubview:onlinev];
    onlinev.layer.cornerRadius = 15*HEIGHT_SIZE;
    onlinev.layer.masksToBounds = YES;
    
    
    UIImageView *signimg = [self goToInitImageView:CGRectMake(5*NOW_SIZE,(30*HEIGHT_SIZE-12*HEIGHT_SIZE)/2, 12*HEIGHT_SIZE, 12*HEIGHT_SIZE) imageString:@"Weonline"];//WeOffline
    signimg.contentMode = UIViewContentModeScaleAspectFit;
    [onlinev addSubview:signimg];
    
    
    UILabel *ollb = [self goToInitLable:CGRectMake(CGRectGetMaxX(signimg.frame), 0, onlinev.xmg_width-CGRectGetMaxX(signimg.frame)-4*NOW_SIZE, 30*HEIGHT_SIZE) textName:home_Online textColor:[UIColor greenColor] fontFloat:12*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [onlinev addSubview:ollb];
    
    //    UILabel *errorLB2=[self goToInitLable:CGRectMake(10*NOW_SIZE,5*HEIGHT_SIZE, 150*NOW_SIZE, 20*HEIGHT_SIZE) textName:pvctaddError textColor:[UIColor redColor] fontFloat:12*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    //    errorLB2.layer.cornerRadius = 20*HEIGHT_SIZE/2;
    //    errorLB2.layer.masksToBounds = YES;
    //    errorLB2.backgroundColor = backgroundNewColor;
    //    [self addSubview:errorLB2];
    //    _errorTipsLB = errorLB2;
    //    errorLB2.hidden = YES;
    
    CGFloat leftSpace = 15*HEIGHT_SIZE;
    //        CGFloat anmWide = 8*HEIGHT_SIZE;
    //        CGFloat lineHeig = 30*HEIGHT_SIZE;
    
    CGFloat spaceF = 5*HEIGHT_SIZE;//(self.xmg_width-leftSpace*2-(30*HEIGHT_SIZE+30*HEIGHT_SIZE)*2-140*HEIGHT_SIZE)/4;
    CGFloat centViewWide = self.xmg_width-leftSpace*2-(30*HEIGHT_SIZE+30*HEIGHT_SIZE)*2-4*spaceF;
    
    if(centViewWide > 140*HEIGHT_SIZE){
        
        centViewWide = 140*HEIGHT_SIZE;
        spaceF = (self.xmg_width-leftSpace*2-(30*HEIGHT_SIZE+30*HEIGHT_SIZE)*2-140*HEIGHT_SIZE)/4;
    }
    
    NSString *mainIMGName = @"PCSIcon";//类型0：PCS；1：逆变器
    
    NSString *mainDeviceType = [NSString stringWithFormat:@"%@",self.dataDic[@"mainDeviceType"]];
    
    if ([mainDeviceType isEqualToString:@"1"]) {
        mainIMGName = @"XPIcon";
    }
    
    CGSize offImgSize0 = IMAGE(@"leftUpOff").size;
    CGSize MainIcon = IMAGE(mainIMGName).size;
    
    
    CGFloat wide0 = self.xmg_width/2-MainIcon.width/2-15*HEIGHT_SIZE-20*HEIGHT_SIZE;
    CGFloat heig = offImgSize0.height*wide0/offImgSize0.width;
    
    CGSize offImgSize = CGSizeMake(wide0, heig);
    
    
    //    UILabel *GridLB = [self goToInitLable:CGRectMake(5*HEIGHT_SIZE, CGRectGetMaxY(leftIMGV.frame), leftIMGV.xmg_x-5*HEIGHT_SIZE, 20*HEIGHT_SIZE) textName:WeGrid textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
    //    [self addSubview:GridLB];
    
    //左边
    
    UILabel *GridValueLB = [self goToInitLable:CGRectMake(15*HEIGHT_SIZE,CGRectGetMaxY(onlinev.frame)+10*HEIGHT_SIZE,self.xmg_width/2 - 15*HEIGHT_SIZE, 40*HEIGHT_SIZE) textName:@"Grid:0W" textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:NO];
    [self addSubview:GridValueLB];
    _GridLB = GridValueLB;
    _GridLB.numberOfLines = 2;
    
    UIImageView *leftIMGV = [self goToInitImageView:CGRectMake(self.xmg_width/2-MainIcon.width/2-offImgSize.width-15*HEIGHT_SIZE+5*HEIGHT_SIZE, CGRectGetMaxY(GridValueLB.frame), 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemGrid"];
    [self addSubview:leftIMGV];
    _GridMGV = leftIMGV;
    
    
    UIView *leftView = [self goToInitView:CGRectMake(self.xmg_width/2-MainIcon.width/2-offImgSize.width, CGRectGetMaxY(leftIMGV.frame), offImgSize.width, offImgSize.height) backgroundColor:[UIColor whiteColor]];
    [self addSubview:leftView];
    
    UIImageView *leftoffimg = [[UIImageView alloc]initWithImage:IMAGE(@"leftUpOff")];
    leftoffimg.frame = CGRectMake(0, 0, offImgSize.width, offImgSize.height);
    [leftView addSubview:leftoffimg];
    
    
    
    
    //    UILabel *solarLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(upIMGV.frame), upIMGV.xmg_y, self.xmg_width-CGRectGetMaxX(upIMGV.frame)-5*HEIGHT_SIZE, 20*HEIGHT_SIZE) textName:WeSolar textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    //    [self addSubview:solarLB];
    UILabel *solarValueLB = [self goToInitLable:CGRectMake(self.xmg_width/2,GridValueLB.xmg_y, self.xmg_width/2-15*HEIGHT_SIZE, 40*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@:0W",WeSolar] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:NO];
    solarValueLB.numberOfLines = 2;
    [self addSubview:solarValueLB];
    _ppvLB = solarValueLB;
    
    
    UIImageView *upIMGV = [self goToInitImageView:CGRectMake(self.xmg_width/2+MainIcon.width/2+offImgSize.width-15*HEIGHT_SIZE-5*HEIGHT_SIZE, leftIMGV.xmg_y, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemPPV"];
    [self addSubview:upIMGV];
    _SolarIMGV = upIMGV;
    
    UIView *upView = [self goToInitView:CGRectMake(self.xmg_width/2+MainIcon.width/2, CGRectGetMaxY(upIMGV.frame), offImgSize.width, offImgSize.height) backgroundColor:[UIColor whiteColor]];
    [self addSubview:upView];
    UIImageView *righUpoffimg = [[UIImageView alloc]initWithImage:IMAGE(@"rightUpOff")];
    righUpoffimg.frame = CGRectMake(0, 0, offImgSize.width, offImgSize.height);
    [upView addSubview:righUpoffimg];
    
    
    
    
    
    UIImageView *mainIMGV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame), CGRectGetMaxY(leftView.frame)+5*HEIGHT_SIZE-MainIcon.height/2, MainIcon.width, MainIcon.height)];
    
    mainIMGV.image = IMAGE(mainIMGName);
    [self addSubview:mainIMGV];
    
    
    
    
    //下边
    UIView *downView = [self goToInitView:CGRectMake(leftView.xmg_x, CGRectGetMaxY(leftView.frame)+10*HEIGHT_SIZE, offImgSize.width, offImgSize.height) backgroundColor:[UIColor whiteColor]];
    [self addSubview:downView];
    
    UIImageView *leftDownoffimg = [[UIImageView alloc]initWithImage:IMAGE(@"leftDownOff")];
    leftDownoffimg.frame = CGRectMake(0, 0, offImgSize.width, offImgSize.height);
    [downView addSubview:leftDownoffimg];
    
    
    UIImageView *downIMGV = [self goToInitImageView:CGRectMake(leftIMGV.xmg_x, CGRectGetMaxY(downView.frame), 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemBat"];
    //    [self addSubview:downIMGV];
    _BatIMGV = downIMGV;
    
    
    ////////////////画图
    
    //    CGRect batimgRect = CGRectMake(leftIMGV.xmg_x-10*HEIGHT_SIZE, CGRectGetMaxY(downView.frame), 50*HEIGHT_SIZE, 50*HEIGHT_SIZE);
    float centerX=downIMGV.xmg_x+downIMGV.xmg_width*0.5;    float centerY=downIMGV.xmg_y+downIMGV.xmg_height*0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    
    _progressView = [[CircleView alloc] initWithFrame:CGRectMake(downIMGV.xmg_x, downIMGV.xmg_y, downIMGV.xmg_width, downIMGV.xmg_height)];
    _progressView.center = center;
    _progressView.startAngle = - M_PI*1/2 ;
    _socPercentValue= [soc00Value floatValue]/100.0;
    _progressView.endAngle   =- M_PI*1/2 +M_PI*2*_socPercentValue;
    _progressView.trackLineWidth=3*HEIGHT_SIZE;
    _progressView.progressLineWidth=3*HEIGHT_SIZE;
    _progressView.trackColor=COLOR(223, 231, 234, 1);
    _progressView.progressColor=COLOR(157, 182, 248, 1);
    [self addSubview:_progressView];
    [_progressView drawDefaultUI];
    
    float step = 1.0 / 30.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:step target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
    float batW=0.28*30*HEIGHT_SIZE;
    float batH=batW*(7.0/3.0);
    float batX=centerX-batW*0.5;
    float batY=centerY-batH*0.5;
    //    if (_isTLXH) {
    //        batW=0.22*image_leftW;
    //        batH=batW*(7.0/3.0);
    //        batX=centerX-batW-1;
    //         batY=centerY-batH*0.5;
    //    }
    
    DeviceBatteryView *batteryView=[[DeviceBatteryView alloc]initWithFrame:CGRectMake(batX, batY, batW, batH)];
    [self addSubview:batteryView];
    batteryView.batValue= [soc00Value floatValue];
    [batteryView initBatteryView0];
    
    
    
    
    
    //    UILabel *batLB = [self goToInitLable:CGRectMake(5*HEIGHT_SIZE, downIMGV.xmg_y, downIMGV.xmg_x-5*HEIGHT_SIZE, 20*HEIGHT_SIZE) textName:WeBat textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
    //    [self addSubview:batLB];
    UILabel *batValueLB = [self goToInitLable:CGRectMake(15*HEIGHT_SIZE,CGRectGetMaxY(downIMGV.frame), self.xmg_width/2-15*HEIGHT_SIZE, 70*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@:+0kW\n0%%",WeBat] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:NO];
    batValueLB.numberOfLines = 0;
    [self addSubview:batValueLB];
    _batPowerLB = batValueLB;
    
    //右边
    
    UIView *rightView = [self goToInitView:CGRectMake(upView.xmg_x,CGRectGetMaxY(upView.frame)+10*HEIGHT_SIZE, upView.xmg_width, upView.xmg_height) backgroundColor:[UIColor whiteColor]];
    [self addSubview:rightView];
    
    UIImageView *righDownoffimg = [[UIImageView alloc]initWithImage:IMAGE(@"rightDownOff")];
    righDownoffimg.frame = CGRectMake(0, 0, offImgSize.width, offImgSize.height);
    [rightView addSubview:righDownoffimg];
    
    UIImageView *rightIMGV = [self goToInitImageView:CGRectMake(upIMGV.xmg_x, CGRectGetMaxY(rightView.frame), 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemHome"];
    [self addSubview:rightIMGV];
    _HomeIMGV = rightIMGV;
    
    //    UILabel *HomeLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(rightIMGV.frame), rightIMGV.xmg_y, solarLB.xmg_width, 20*HEIGHT_SIZE) textName:WeHome textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    //    [self addSubview:HomeLB];
    UILabel *HomeValueLB = [self goToInitLable:CGRectMake(_ppvLB.xmg_x,CGRectGetMaxY(rightIMGV.frame),_ppvLB.xmg_width, 40*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@:0W",WeHome] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:NO];
    [self addSubview:HomeValueLB];
    _HomeLB = HomeValueLB;
    _HomeLB.numberOfLines = 2;
    
    
    
    
    
    
    
    NSString *ppvstr = [NSString stringWithFormat:@"%@",_dataDic[@"pvPower"]];
    NSString *gridstr = [NSString stringWithFormat:@"%@",_dataDic[@"elcGridPower"]];
    NSString *batpower = [NSString stringWithFormat:@"%@",_dataDic[@"batteryPower"]];
    NSString *soc = [NSString stringWithFormat:@"%@",_dataDic[@"batterySoc"]];
    NSString *loadPower = [NSString stringWithFormat:@"%@",_dataDic[@"loadPower"]];
    NSString *plantStatus = [NSString stringWithFormat:@"%@",_dataDic[@"plantStatus"]];
    
    
    
    
    
    
    //    allStatue = 1;
    if ([plantStatus isEqualToString:@"0"]) {
        
        signimg.image = IMAGE(@"WeOffline");
        ollb.text = home_OffLine;
        ollb.textColor = colorblack_154;
        _SolarIMGV.image = IMAGE(@"SystemPPV");
        _GridMGV.image = IMAGE(@"SystemGrid");
        _BatIMGV.image = IMAGE(@"SystemBat");
        _HomeIMGV.image = IMAGE(@"SystemHome");
        
    }else{
        if([ppvstr floatValue] == 0){
            _SolarIMGV.image = IMAGE(@"SystemPPV");
            
        }else{
            _SolarIMGV.image = IMAGE(@"SystemPPVOn");
            
            righUpoffimg.hidden = YES;
            
            FLAnimatedImageView*  rightUpgifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, leftView.xmg_width,leftView.xmg_height)];
            rightUpgifView.contentMode = UIViewContentModeScaleAspectFit;
            rightUpgifView.clipsToBounds = YES;
            rightUpgifView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"rightUp" withExtension:@"gif"]]];
            [upView addSubview:rightUpgifView];
            
        }
        
        if([gridstr floatValue] > 0){
            _GridMGV.image = IMAGE(@"SystemGridOn");
            leftoffimg.hidden = YES;
            
            NSString *leftOnToStr = @"leftUp2";
            if ([mainDeviceType isEqualToString:@"1"]) {
                leftOnToStr = @"leftUp";
            }
            
            FLAnimatedImageView*  rightUpgifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, leftView.xmg_width,leftView.xmg_height)];
            rightUpgifView.contentMode = UIViewContentModeScaleAspectFit;
            rightUpgifView.clipsToBounds = YES;
            rightUpgifView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:leftOnToStr withExtension:@"gif"]]];
            [leftView addSubview:rightUpgifView];
            
        }else if([gridstr floatValue] < 0){
            _GridMGV.image = IMAGE(@"SystemGridOn");
            leftoffimg.hidden = YES;
            NSString *leftOnToStr = @"leftUp";
            if ([mainDeviceType isEqualToString:@"1"]) {
                leftOnToStr = @"leftUp2";
            }
            
            FLAnimatedImageView*  rightUpgifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, leftView.xmg_width,leftView.xmg_height)];
            rightUpgifView.contentMode = UIViewContentModeScaleAspectFit;
            rightUpgifView.clipsToBounds = YES;
            rightUpgifView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:leftOnToStr withExtension:@"gif"]]];
            [leftView addSubview:rightUpgifView];
            
        }else{
            _GridMGV.image = IMAGE(@"SystemGrid");
            
            
        }
        
        if([batpower floatValue] == 0){
            _BatIMGV.image = IMAGE(@"SystemBat");
            
            
            
        }else if([batpower floatValue] > 0){
            _BatIMGV.image = IMAGE(@"SystemBatOn");
            leftDownoffimg.hidden = YES;
            
            NSString *leftOnToStr = @"leftDown2";
            if ([mainDeviceType isEqualToString:@"1"]) {
                leftOnToStr = @"leftDown";
            }
            
            FLAnimatedImageView*  rightUpgifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, leftView.xmg_width,leftView.xmg_height)];
            rightUpgifView.contentMode = UIViewContentModeScaleAspectFit;
            rightUpgifView.clipsToBounds = YES;
            rightUpgifView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:leftOnToStr withExtension:@"gif"]]];
            [downView addSubview:rightUpgifView];
            
        }else{
            _BatIMGV.image = IMAGE(@"SystemBatOn");
            leftDownoffimg.hidden = YES;
            NSString *leftOnToStr = @"leftDown";
            if ([mainDeviceType isEqualToString:@"1"]) {
                leftOnToStr = @"leftDown2";
            }
            
            FLAnimatedImageView*  rightUpgifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, leftView.xmg_width,leftView.xmg_height)];
            rightUpgifView.contentMode = UIViewContentModeScaleAspectFit;
            rightUpgifView.clipsToBounds = YES;
            rightUpgifView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:leftOnToStr withExtension:@"gif"]]];
            [downView addSubview:rightUpgifView];
        }
        
        
        if([loadPower floatValue] == 0){
            _HomeIMGV.image = IMAGE(@"SystemHome");
            
            
            
        }else{
            _HomeIMGV.image = IMAGE(@"SystemHomeOn");
            righDownoffimg.hidden = YES;
            FLAnimatedImageView*  rightUpgifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, leftView.xmg_width,leftView.xmg_height)];
            rightUpgifView.contentMode = UIViewContentModeScaleAspectFit;
            rightUpgifView.clipsToBounds = YES;
            rightUpgifView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"rightDown2" withExtension:@"gif"]]];
            [rightView addSubview:rightUpgifView];
        }
        
    }
    
 
    
    _ppvLB.text = [NSString stringWithFormat:@"%@\n%@kW",WeSolar,[self removeFuHao:ppvstr]];//[NSString stringWithFormat:@"%@\n%.1fkW",WeSolar,fabsf([ppvstr floatValue])];//[self UnitSet:[ppvstr floatValue]];
    _GridLB.text = [NSString stringWithFormat:@"Grid\n%@kW",[self removeFuHao:gridstr]];//[NSString stringWithFormat:@"Grid\n%.1fkW",fabsf([gridstr floatValue])];//[self UnitSet:[gridstr floatValue]];
    _batPowerLB.text = [NSString stringWithFormat:@"%@\n%@kW\n%@",WeBat,[self removeFuHao:batpower],soc];//[NSString stringWithFormat:@"%@\n%.1fkW\n%@",WeBat,fabsf([batpower floatValue]),soc];//[self UnitSet:[batpower floatValue]],soc];
    _HomeLB.text = [NSString stringWithFormat:@"%@\n%@kW",WeHome,[self removeFuHao:loadPower]];//[NSString stringWithFormat:@"%@\n%.1fkW",WeHome,fabsf([loadPower floatValue])];//[self UnitSet:[loadPower floatValue]];
    
    [self set_DesignatedTextForLabel:_GridLB text:@"Grid" color:colorblack_154];
    [self set_DesignatedTextForLabel:_ppvLB text:WeSolar color:colorblack_154];
    [self set_DesignatedTextForLabel:_batPowerLB text:WeBat color:colorblack_154];
    
    [self set_DesignatedTextForLabel:_HomeLB text:WeHome color:colorblack_154];
    
}


- (NSString *)removeFuHao:(NSString *)valustr{
    
    NSArray *valArr = [valustr componentsSeparatedByString:@"-"];
//    if (valArr.count > 0) {
//
//    }
    
    return valArr.lastObject;
}

- (void)createSystemUI22{
    
    
    //    NSString *powerUnit = @"W";
    //    float animalH_K=10*HEIGHT_SIZE,animalW_K=26*NOW_SIZE;
    animalAll_H=30*HEIGHT_SIZE;
    animalAll_H2=30*HEIGHT_SIZE;
    TIME = 0.3;
    
    UIView *onlinev = [self goToInitView:CGRectMake(self.xmg_width-10*NOW_SIZE-80*HEIGHT_SIZE, 5*HEIGHT_SIZE, 80*HEIGHT_SIZE, 30*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    [self addSubview:onlinev];
    onlinev.layer.cornerRadius = 15*HEIGHT_SIZE;
    onlinev.layer.masksToBounds = YES;
    
    
    UIImageView *signimg = [self goToInitImageView:CGRectMake(5*NOW_SIZE,(30*HEIGHT_SIZE-12*HEIGHT_SIZE)/2, 12*HEIGHT_SIZE, 12*HEIGHT_SIZE) imageString:@"Weonline"];//WeOffline
    signimg.contentMode = UIViewContentModeScaleAspectFit;
    [onlinev addSubview:signimg];
    
    
    UILabel *ollb = [self goToInitLable:CGRectMake(CGRectGetMaxX(signimg.frame), 0, onlinev.xmg_width-CGRectGetMaxX(signimg.frame)-4*NOW_SIZE, 30*HEIGHT_SIZE) textName:home_Online textColor:[UIColor greenColor] fontFloat:12*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [onlinev addSubview:ollb];
    
    //    UILabel *errorLB2=[self goToInitLable:CGRectMake(10*NOW_SIZE,5*HEIGHT_SIZE, 150*NOW_SIZE, 20*HEIGHT_SIZE) textName:pvctaddError textColor:[UIColor redColor] fontFloat:12*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    //    errorLB2.layer.cornerRadius = 20*HEIGHT_SIZE/2;
    //    errorLB2.layer.masksToBounds = YES;
    //    errorLB2.backgroundColor = backgroundNewColor;
    //    [self addSubview:errorLB2];
    //    _errorTipsLB = errorLB2;
    //    errorLB2.hidden = YES;
    
    CGFloat leftSpace = 15*HEIGHT_SIZE;
    CGFloat anmWide = 8*HEIGHT_SIZE;
    CGFloat lineHeig = 30*HEIGHT_SIZE;
    
    CGFloat spaceF = 5*HEIGHT_SIZE;//(self.xmg_width-leftSpace*2-(30*HEIGHT_SIZE+30*HEIGHT_SIZE)*2-140*HEIGHT_SIZE)/4;
    CGFloat centViewWide = self.xmg_width-leftSpace*2-(30*HEIGHT_SIZE+30*HEIGHT_SIZE)*2-4*spaceF;
    
    if(centViewWide > 140*HEIGHT_SIZE){
        
        centViewWide = 140*HEIGHT_SIZE;
        spaceF = (self.xmg_width-leftSpace*2-(30*HEIGHT_SIZE+30*HEIGHT_SIZE)*2-140*HEIGHT_SIZE)/4;
    }
    
    UIImageView *upIMGV = [self goToInitImageView:CGRectMake(self.xmg_width/2-30*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemPPV"];
    [self addSubview:upIMGV];
    _SolarIMGV = upIMGV;
    
    
    UILabel *solarLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(upIMGV.frame), upIMGV.xmg_y, 80*NOW_SIZE, 20*HEIGHT_SIZE) textName:WeSolar textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self addSubview:solarLB];
    UILabel *solarValueLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(upIMGV.frame),CGRectGetMaxY(solarLB.frame), 100*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"0W" textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:NO];
    solarValueLB.numberOfLines = 2;
    [self addSubview:solarValueLB];
    _ppvLB = solarValueLB;
    
    UIView *upView = [self goToInitView:CGRectMake(self.xmg_width/2-5*HEIGHT_SIZE, CGRectGetMaxY(solarValueLB.frame)+spaceF, anmWide, lineHeig) backgroundColor:WhiteColor];
    [self addSubview:upView];
    
    //中心
    UIView *oneBgView = [self goToInitView:CGRectMake(self.xmg_width/2 - centViewWide/2, CGRectGetMaxY(upView.frame)+spaceF, centViewWide, centViewWide) backgroundColor:WhiteColor];
    oneBgView.layer.cornerRadius = centViewWide/2;
    oneBgView.layer.masksToBounds = YES;
    oneBgView.layer.borderColor = COLOR(232, 240, 255, 1).CGColor;
    oneBgView.layer.borderWidth = 5*HEIGHT_SIZE;
    [self addSubview:oneBgView];
    
    UIView *twoBgView = [self goToInitView:CGRectMake(10*HEIGHT_SIZE, 10*HEIGHT_SIZE, centViewWide-20*HEIGHT_SIZE, centViewWide-20*HEIGHT_SIZE) backgroundColor:WhiteColor];
    twoBgView.layer.cornerRadius = (centViewWide-20*HEIGHT_SIZE)/2;
    twoBgView.layer.masksToBounds = YES;
    twoBgView.layer.borderColor = COLOR(125, 158, 248, 1).CGColor;
    twoBgView.layer.borderWidth = 5*HEIGHT_SIZE;
    [oneBgView addSubview:twoBgView];
    
    UIView *threeBgView = [self goToInitView:CGRectMake(twoBgView.xmg_x+10*HEIGHT_SIZE,twoBgView.xmg_y+10*HEIGHT_SIZE, twoBgView.xmg_width-20*HEIGHT_SIZE, twoBgView.xmg_width-20*HEIGHT_SIZE) backgroundColor:COLOR(59, 106, 252, 1)];
    threeBgView.layer.cornerRadius = (twoBgView.xmg_width-20*HEIGHT_SIZE)/2;
    threeBgView.layer.masksToBounds = YES;
    //    threeBgView.layer.borderColor = COLOR(59, 106, 252, 1).CGColor;
    //    threeBgView.layer.borderWidth = 10*HEIGHT_SIZE;
    [oneBgView addSubview:threeBgView];
    
    UILabel *ACDCLB = [self goToInitLable:CGRectMake(5*HEIGHT_SIZE, threeBgView.xmg_height/2-20*HEIGHT_SIZE, threeBgView.xmg_width-10*HEIGHT_SIZE, 40*HEIGHT_SIZE) textName:@"AC/DC" textColor:WhiteColor fontFloat:18*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [threeBgView addSubview:ACDCLB];
    
    
    
    
    
    //左边
    UIImageView *leftIMGV = [self goToInitImageView:CGRectMake(leftSpace, oneBgView.xmg_y+oneBgView.xmg_height/2-30*HEIGHT_SIZE/2, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemGrid"];
    [self addSubview:leftIMGV];
    _GridMGV = leftIMGV;
    
    UILabel *GridLB = [self goToInitLable:CGRectMake(5*HEIGHT_SIZE, CGRectGetMaxY(leftIMGV.frame), (leftSpace-5)*2+30*HEIGHT_SIZE, 20*HEIGHT_SIZE) textName:WeGrid textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [self addSubview:GridLB];
    UILabel *GridValueLB = [self goToInitLable:CGRectMake(GridLB.xmg_x,CGRectGetMaxY(GridLB.frame),GridLB.xmg_width, 40*HEIGHT_SIZE) textName:@"0W" textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:NO];
    [self addSubview:GridValueLB];
    _GridLB = GridValueLB;
    _GridLB.numberOfLines = 2;
    
    
    UIView *leftView = [self goToInitView:CGRectMake(CGRectGetMaxX(leftIMGV.frame)+spaceF, leftIMGV.xmg_y+leftIMGV.xmg_height/2-5*HEIGHT_SIZE, lineHeig, anmWide) backgroundColor:WhiteColor];
    [self addSubview:leftView];
    
    //下边
    UIView *downView = [self goToInitView:CGRectMake(self.xmg_width/2-5*HEIGHT_SIZE, CGRectGetMaxY(oneBgView.frame)+spaceF, anmWide, lineHeig) backgroundColor:WhiteColor];
    [self addSubview:downView];
    
    
    UIImageView *downIMGV = [self goToInitImageView:CGRectMake(self.xmg_width/2-30*HEIGHT_SIZE, CGRectGetMaxY(downView.frame)+spaceF, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemBat"];
    [self addSubview:downIMGV];
    _BatIMGV = downIMGV;
    
    UILabel *batLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(downIMGV.frame), CGRectGetMaxY(downView.frame)+spaceF, 80*NOW_SIZE, 20*HEIGHT_SIZE) textName:WeBat textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self addSubview:batLB];
    UILabel *batValueLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(downIMGV.frame),CGRectGetMaxY(batLB.frame), 100*NOW_SIZE, 40*HEIGHT_SIZE) textName:@"+0kW\n0%" textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:NO];
    batValueLB.numberOfLines = 0;
    [self addSubview:batValueLB];
    _batPowerLB = batValueLB;
    
    //右边
    
    UIView *rightView = [self goToInitView:CGRectMake(CGRectGetMaxX(oneBgView.frame)+spaceF, leftIMGV.xmg_y+leftIMGV.xmg_height/2-5*HEIGHT_SIZE, lineHeig, anmWide) backgroundColor:WhiteColor];
    [self addSubview:rightView];
    
    UIImageView *rightIMGV = [self goToInitImageView:CGRectMake(CGRectGetMaxX(rightView.frame)+spaceF, oneBgView.xmg_y+oneBgView.xmg_height/2-30*HEIGHT_SIZE/2, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"SystemHome"];
    [self addSubview:rightIMGV];
    _HomeIMGV = rightIMGV;
    
    UILabel *HomeLB = [self goToInitLable:CGRectMake(self.xmg_width-5*HEIGHT_SIZE-((leftSpace-5)*2+30*HEIGHT_SIZE), CGRectGetMaxY(rightIMGV.frame), (leftSpace-5)*2+30*HEIGHT_SIZE, 20*HEIGHT_SIZE) textName:WeHome textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [self addSubview:HomeLB];
    UILabel *HomeValueLB = [self goToInitLable:CGRectMake(HomeLB.xmg_x,CGRectGetMaxY(HomeLB.frame),HomeLB.xmg_width, 40*HEIGHT_SIZE) textName:@"0W" textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:NO];
    [self addSubview:HomeValueLB];
    _HomeLB = HomeValueLB;
    _HomeLB.numberOfLines = 2;
    
    
    
    
    
    
    
    CGPoint leftUpPoint = upView.frame.origin;
    CGPoint leftdownPoint = leftView.frame.origin;
    CGPoint rightdownPoint = downView.frame.origin;
    CGPoint rightUpPoint = rightView.frame.origin;
    
    animalUnitLong=8*HEIGHT_SIZE;
    animalUnitShort=5*HEIGHT_SIZE;
    animalUnitOff=animalUnitShort;
    
    
    NSString *ppvstr = [NSString stringWithFormat:@"%@",_dataDic[@"pvPower"]];
    NSString *gridstr = [NSString stringWithFormat:@"%@",_dataDic[@"elcGridPower"]];
    NSString *batpower = [NSString stringWithFormat:@"%@",_dataDic[@"batteryPower"]];
    NSString *soc = [NSString stringWithFormat:@"%@",_dataDic[@"batterySoc"]];
    NSString *loadPower = [NSString stringWithFormat:@"%@",_dataDic[@"loadPower"]];
    NSString *plantStatus = [NSString stringWithFormat:@"%@",_dataDic[@"plantStatus"]];
    
    
    //    allStatue = 1;
    if ([plantStatus isEqualToString:@"0"]) {
        
        signimg.image = IMAGE(@"WeOffline");
        ollb.text = home_OffLine;
        ollb.textColor = colorblack_154;
        [self initOffAnimalUI:1 Point0:leftUpPoint];
        [self initOffAnimalUI:2 Point0:leftdownPoint];
        [self initOffAnimalUI:1 Point0:rightdownPoint];
        [self initOffAnimalUI:2 Point0:rightUpPoint];
        _SolarIMGV.image = IMAGE(@"SystemPPV");
        _GridMGV.image = IMAGE(@"SystemGrid");
        _BatIMGV.image = IMAGE(@"SystemBat");
        _HomeIMGV.image = IMAGE(@"SystemHome");
        
    }else{
        if([ppvstr floatValue] == 0){
            [self initOffAnimalUI:1 Point0:leftUpPoint];
            _SolarIMGV.image = IMAGE(@"SystemPPV");
            
        }else{
            _SolarIMGV.image = IMAGE(@"SystemPPVOn");
            
            [self initAnimalUI0:2 Point0:leftUpPoint isAnimal:YES imageString:@"plant_arrow_green1"];
            
        }
        
        if([gridstr floatValue] > 0){
            _GridMGV.image = IMAGE(@"SystemGridOn");
            
            [self initAnimalUI0:4 Point0:leftdownPoint isAnimal:YES imageString:@"plant_arrow_green"];
            
        }else if([gridstr floatValue] < 0){
            _GridMGV.image = IMAGE(@"SystemGridOn");
            
            [self initAnimalUI0:3 Point0:leftdownPoint isAnimal:YES imageString:@"plant_arrow_green"];
            
        }else{
            _GridMGV.image = IMAGE(@"SystemGrid");
            
            [self initOffAnimalUI:2 Point0:leftdownPoint];
            
        }
        
        if([batpower floatValue] == 0){
            _BatIMGV.image = IMAGE(@"SystemBat");
            
            [self initOffAnimalUI:1 Point0:rightdownPoint];
            
        }else if([batpower floatValue] > 0){
            _BatIMGV.image = IMAGE(@"SystemBatOn");
            
            [self initAnimalUI0:1 Point0:rightdownPoint isAnimal:YES imageString:@"plant_arrow_green1"];
            
            
        }else{
            _BatIMGV.image = IMAGE(@"SystemBatOn");
            
            [self initAnimalUI0:2 Point0:rightdownPoint isAnimal:YES imageString:@"plant_arrow_green1"];
            
        }
        
        
        if([loadPower floatValue] == 0){
            _HomeIMGV.image = IMAGE(@"SystemHome");
            
            [self initOffAnimalUI:2 Point0:rightUpPoint];
            
            
        }else{
            _HomeIMGV.image = IMAGE(@"SystemHomeOn");
            
            [self initAnimalUI0:4 Point0:rightUpPoint isAnimal:YES imageString:@"plant_arrow_green"];
            
        }
        
    }
    
    
    
    _ppvLB.text = [NSString stringWithFormat:@"%.1fkW",fabsf([ppvstr floatValue])];//[self UnitSet:[ppvstr floatValue]];
    _GridLB.text = [NSString stringWithFormat:@"%.1fkW",fabsf([gridstr floatValue])];//[self UnitSet:[gridstr floatValue]];
    _batPowerLB.text = [NSString stringWithFormat:@"%.1fkW\n%@",fabsf([batpower floatValue]),soc];//[self UnitSet:[batpower floatValue]],soc];
    _HomeLB.text = [NSString stringWithFormat:@"%.1fkW",fabsf([loadPower floatValue])];//[self UnitSet:[loadPower floatValue]];
    
}

- (NSString *)UnitSet:(float)Numb{
    
    
    //    if(Numb > 1000){
    Numb = Numb/1000;
    return [NSString stringWithFormat:@"%.3fkW",Numb];
    //    }else{
    //
    //        return [NSString stringWithFormat:@"%.1fW",Numb];
    //
    //    }
    
}



- (void)bgview:(UIView *)bgvie namestr:(NSString *)nameStr valuestr:(NSString *)valueStr danwei:(NSString *)danweiStr image:(NSString *)imageStr batStr:(NSString *)batstr{
    
    UIImageView *imagv = [self goToInitImageView:CGRectMake(10*NOW_SIZE, 15*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:imageStr];
    [bgvie addSubview:imagv];
    
    //    if (!kStringIsEmpty(batstr)) {
    //        UILabel *batlb = [self goToInitLable:CGRectMake(0,10*HEIGHT_SIZE, 30*HEIGHT_SIZE, 20*HEIGHT_SIZE) textName:batstr textColor:WhiteColor fontFloat:10*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    //        [imagv addSubview:batlb];
    //    }
    
    UIColor *textcolor = mainColor;
    if ([batstr isEqualToString:@"0"]) {
        textcolor = colorblack_102;
    }
    if (kStringIsEmpty(valueStr)) {
        valueStr = @"";
    }
    UILabel *namlb = [self goToInitLable:CGRectMake(CGRectGetMaxX(imagv.frame)+5*NOW_SIZE,0, bgvie.xmg_width - CGRectGetMaxX(imagv.frame)-5*NOW_SIZE, 30*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@%@",valueStr,danweiStr] textColor:textcolor fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    namlb.numberOfLines = 0;
    [bgvie addSubview:namlb];
    
    UILabel *valuelb = [self goToInitLable:CGRectMake(CGRectGetMaxX(imagv.frame)+5*NOW_SIZE,CGRectGetMaxY(namlb.frame), bgvie.xmg_width - CGRectGetMaxX(imagv.frame)-5*NOW_SIZE, 30*HEIGHT_SIZE) textName:nameStr textColor:colorblack_102 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    valuelb.numberOfLines = 0;
    [bgvie addSubview:valuelb];
    
    
}
-(void)initOffAnimalUI:(NSInteger)derectorNum Point0:(CGPoint)Point0{
    int NUM=3;
    float AllH=animalAll_H;
    if (derectorNum==1 || derectorNum==2) {
        AllH=animalAll_H2;
    }
    float imageW=animalUnitOff;
    float K=(AllH-imageW*NUM)*0.5;
    float unitK=imageW+K;
    for (int i=0; i<NUM; i++) {
        UIImageView* unitImage;
        if (derectorNum==2) {
            unitImage=[self goToInitImageView:CGRectMake(Point0.x+unitK*i, Point0.y, imageW, imageW) imageString:@"plant_animal_offline"];
        }else   if (derectorNum==1) {
            unitImage=[self goToInitImageView:CGRectMake(Point0.x, Point0.y+unitK*i, imageW, imageW) imageString:@"plant_animal_offline"];
        }
        [self addSubview:unitImage];
    }
}
-(void)initAnimalUI0:(NSInteger)derectorNum Point0:(CGPoint)Point0 isAnimal:(BOOL)isAnimal imageString:(NSString*)imageString{
    int NUM=3;
    float AllH=animalAll_H;
    if (derectorNum==1 || derectorNum==2) {
        AllH=animalAll_H2;
    }
    float K=(AllH-animalUnitShort*NUM)*0.5;
    float unitK=animalUnitShort+K;
    for (int i=0; i<NUM; i++) {
        UIImageView* unitImage;
        int N=i;
        if (derectorNum==4) {
            unitImage=[self goToInitImageView:CGRectMake(Point0.x+unitK*i, Point0.y, animalUnitShort, animalUnitLong) imageString:imageString];
        }else   if (derectorNum==2) {
            unitImage=[self goToInitImageView:CGRectMake(Point0.x, Point0.y+unitK*i, animalUnitLong, animalUnitShort) imageString:imageString];
        }else   if (derectorNum==1) {
            N=NUM-1-i;
            unitImage=[self goToInitImageView:CGRectMake(Point0.x, Point0.y+unitK*i, animalUnitLong, animalUnitShort) imageString:imageString];
            unitImage.transform=CGAffineTransformMakeRotation((90*2*M_PI)/180);
        }else   if (derectorNum==3) {
            N=NUM-1-i;
            unitImage=[self goToInitImageView:CGRectMake(Point0.x+unitK*i, Point0.y, animalUnitShort, animalUnitLong) imageString:imageString];
            unitImage.transform=CGAffineTransformMakeRotation((90*2*M_PI)/180);
        }
        [self addSubview:unitImage];
        if (isAnimal) {
            [unitImage.layer addAnimation:[self getAnimationOne:TIME*3 delayTime:0+TIME*N] forKey:nil];
        }
    }
}
-(CABasicAnimation *)getAnimationOne:(float)time  delayTime:(float)delayTime
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.beginTime = CACurrentMediaTime() + delayTime;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}



-(UIView*)goToInitView:(CGRect)viewFrame backgroundColor:(UIColor*)backgroundColor{
    UIView *View = [[UIView alloc] initWithFrame:viewFrame];
    View.backgroundColor = backgroundColor;
    return View;
}
-(UILabel*)goToInitLable:(CGRect)lableFrame textName:(NSString*)textString textColor:(UIColor*)textColor fontFloat:(float)fontFloat AlignmentType:(int)AlignmentType isAdjust:(BOOL)isAdjust{
    UILabel *label= [[UILabel alloc] initWithFrame:lableFrame];
    label.text=textString;
    label.textColor=textColor;
    label.font = [UIFont systemFontOfSize:fontFloat];
    if (AlignmentType==1) {
        label.textAlignment = NSTextAlignmentLeft;
    }else if (AlignmentType==2) {
        label.textAlignment = NSTextAlignmentRight;
    }else{
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.adjustsFontSizeToFitWidth=isAdjust;
    return label;
}
-(UIImageView*)goToInitImageView:(CGRect)imageFrame imageString:(NSString*)imageString{
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:imageFrame];
    [imageView setImage:[UIImage imageNamed:imageString]];
    return imageView;
}
-(UIButton*)goToInitButton:(CGRect)buttonFrame TypeNum:(NSInteger)TypeNum fontSize:(float)fontSize titleString:(NSString*)titleString selImgString:(NSString*)selImgString norImgString:(NSString*)norImgString{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=buttonFrame;
    if (TypeNum==1 || TypeNum==3) {
        [button setTitle:titleString forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize: fontSize];
    }
    if (TypeNum==2 || TypeNum==3) {
        [button setImage:[UIImage imageNamed:selImgString] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:norImgString] forState:UIControlStateNormal];
    }
    return button;
}

-(void)set_DesignatedTextForLabel:(UILabel *)label text:(NSString *)text color:(UIColor *)color{
    if (color) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:[label.text rangeOfString:text]];
        label.attributedText = attStr;
    }
}
- (void)updateProgress {
    CGFloat progress = _progressView.progress;
    if (progress > 100 || (progress==100)) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    progress += 0.3;
    _progressView.progress = progress;
}
@end
