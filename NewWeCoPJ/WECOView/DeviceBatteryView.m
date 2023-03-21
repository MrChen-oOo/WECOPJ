//
//  DeviceBatteryView.m
//  HQBatteryGauge
//
//  Created by sky on 2018/3/28.
//  Copyright © 2018年 judian. All rights reserved.
//

#import "DeviceBatteryView.h"

@implementation DeviceBatteryView

- (void)initBatteryView0{
    float H=self.frame.size.height;
    float W=self.frame.size.width;
    float Per=(1/6.0)*H;
    
        float PerKW=(1/10.0)*W;
    
    
   
    float PerView2=W-(2.0*PerKW);
    
    float lineW=1.0;
    float lineRW=1.0;

    float ViewH=H-Per;
    float viewAllH=ViewH-(2.0*lineW);
     float PerKH=(1/22.0)*H;
    float PerViewH=(viewAllH-(PerKH*6.0))/5.0;
    float PerUnit=PerKH+PerViewH;
    
    int Count=0;   //电池格数
    
    UIColor *V0Color=COLOR(157, 182, 248, 1);//COLOR(93,98,104,1);
    
  
    if (_batValue<1) {
        Count=0;
        V0Color=[UIColor redColor];
    }else{
        if ((_batValue<20) && (_batValue>=1)) {
            Count=1;
        }else if ((_batValue<40) && (_batValue>=20)) {
            Count=2;
        }else if ((_batValue<60) && (_batValue>=40)) {
            Count=3;
        }else if ((_batValue<80) && (_batValue>=60)) {
            Count=4;
        }else if (_batValue>=80) {
            Count=5;
        }
        
        
    }
    
    
    
 
    UIView *V0 = [[UIView alloc] initWithFrame:CGRectMake(0, Per, W, ViewH)];
    V0.layer.borderWidth=lineW;
    V0.layer.borderColor=V0Color.CGColor;
//     V0.layer.cornerRadius=lineRW;
    [self addSubview:V0];
    
    float V2W=(2/5.0)*W;
    float V2x=(W-V2W)/2;
    UIView *V2 = [[UIView alloc] initWithFrame:CGRectMake(V2x, Per-PerViewH+lineW, V2W, PerViewH)];
    V2.layer.borderWidth=lineW;
    V2.layer.borderColor=V0Color.CGColor;
    //V2.layer.cornerRadius=lineRW;
//    V2.backgroundColor=V0Color;
    [self addSubview:V2];
    
    for (int i=0; i<Count; i++) {
        UIView *V1 = [[UIView alloc] initWithFrame:CGRectMake(PerKW, ViewH-PerUnit*(i+1), PerView2, PerViewH)];
        V1.backgroundColor=V0Color;
        V1.layer.borderWidth=lineW;
         V1.layer.cornerRadius=lineRW;
        V1.layer.borderColor=V0Color.CGColor;
        [V0 addSubview:V1];
    }

    
    
}



@end
