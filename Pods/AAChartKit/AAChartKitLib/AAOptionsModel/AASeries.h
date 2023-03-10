//
//  AASeries.h
//  AAChartKit
//
//  Created by An An on 17/1/5.
//  Copyright ยฉ 2017ๅนด An An. All rights reserved.
//
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************
//

/*
 
 * -------------------------------------------------------------------------------
 *
 * ๐ ๐ ๐ ๐  โโโ   WARM TIPS!!!   โโโ ๐ ๐ ๐ ๐
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import <Foundation/Foundation.h>

@class AAMarker, AAAnimation, AAShadow, AADataLabels, AAEvents, AAStates, AAPoint;

@interface AASeries : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AASeries, NSString     *, borderColor) //The border color, It is only valid for column, bar, pie, columnrange, pyramid and funnel chart types
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber     *, borderWidth) //The border width, It is only valid for column, bar, pie, columnrange, pyramid and funnel chart types
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber     *, borderRadius) //The corner radius of the border surrounding each column or bar.
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber     *, borderRadiusTopLeft)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber     *, borderRadiusTopRight)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber     *, borderRadiusBottomLeft)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber     *, borderRadiusBottomRight)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAMarker     *, marker) 
AAPropStatementAndPropSetFuncStatement(copy,   AASeries, NSString     *, stacking) 
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAAnimation  *, animation) 
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSArray      *, keys) 
//colorByPoint ๅณๅฎไบๅพ่กจๆฏๅฆ็ปๆฏไธชๆฐๆฎๅๆๆฏไธช็นๅ้ไธไธช้ข่ฒ๏ผ้ป่ฎคๅผๆฏ false๏ผ ๅณ้ป่ฎคๆฏ็ปๆฏไธชๆฐๆฎ็ฑปๅ้้ข่ฒ๏ผ
//AAPropStatementAndPropSetFuncStatement(assign, AASeries, BOOL , colorByPoint) //่ฎพ็ฝฎไธบ true ๅๆฏ็ปๆฏไธช็นๅ้้ข่ฒใ
//plotOptions.series.connectNulls
//https://www.zhihu.com/question/24173311
AAPropStatementAndPropSetFuncStatement(assign, AASeries, BOOL ,          connectNulls) //่ฎพ็ฝฎๆ็บฟๆฏๅฆๆญ็น้่ฟ
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAEvents *, events)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAShadow *, shadow)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAStates *, states)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAPoint  *, point)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, pointWidth) //ๆฑ็ถๅพ, ๆกๅฝขๅพ, ๆฑๅฝข่ๅดๅพ, ็ๅธๅพ, ็ฎฑ็บฟๅพ(็้กปๅพ)็ดๆฅ่ฎพ็ฝฎๅไธชๅพๅฝขๅ็ด?็ๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, maxPointWidth) //ๆฑ็ถๅพ, ๆกๅฝขๅพ, ๆฑๅฝข่ๅดๅพ, ็ๅธๅพ, ็ฎฑ็บฟๅพ(็้กปๅพ)็ดๆฅ่ฎพ็ฝฎๅไธชๅพๅฝขๅ็ด?็ๆๅคงๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, minPointLength) //ๆฑ็ถๅพ, ๆกๅฝขๅพ, ๆฑๅฝข่ๅดๅพ, ็ๅธๅพ, ็ฎฑ็บฟๅพ(็้กปๅพ)็ดๆฅ่ฎพ็ฝฎๅไธชๅพๅฝขๅ็ด?็ๆๅฐ้ซๅบฆ

@end


@interface AAEvents : NSObject

AAPropStatementAndPropSetFuncStatement(copy, AAEvents, NSString *, legendItemClick)

@end


@class AAPointEvents;

@interface AAPoint : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAPoint, AAPointEvents *, events)

@end


@interface AAPointEvents : NSObject

AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, click) //็นๅปไบไปถ
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, mouseOut) //้ผ?ๆ?ๅๅบ
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, mouseOver) //้ผ?ๆ?ๅ่ฟ
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, remove) //ๅ?้ค
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, select) //้ไธญ
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, unselect) //ๅๆถ้ไธญ
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, update) //ๆดๆฐ
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, legendItemClick) //ๅพไพ็นๅปไบไปถ

@end

