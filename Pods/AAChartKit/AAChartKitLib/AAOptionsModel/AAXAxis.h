//
//  AAXAxis.h
//  AAChartKit
//
//  Created by An An on 17/1/5.
//  Copyright ยฉ 2017ๅนด An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

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
#import "AAChartAxisType.h"

@class AAAxisTitle, AALabels, AACrosshair, AAPlotBandsElement, AAPlotLinesElement, AADateTimeLabelFormats;

@interface AAXAxis : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, alternateGridColor) //้ด้็ฝๆ ผ่ๆฏ, ๅฝๆๅฎ่ฏฅๅๆฐๆถ๏ผ็ธ้ปๅปๅบฆ็บฟไน้ดไผ็จๅฏนๅบ็้ข่ฒๆฅ็ปๅถ้ข่ฒๅ่พจๅธฆ.
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, AAAxisTitle  *, title)
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, AAChartAxisType, type)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, AADateTimeLabelFormats  *, dateTimeLabelFormats)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSArray<AAPlotBandsElement *>*, plotBands)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSArray<AAPlotLinesElement *>*, plotLines)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSArray  *, categories) 
AAPropStatementAndPropSetFuncStatement(assign, AAXAxis, BOOL,       reversed) 
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, lineWidth) //x่ฝด่ฝด็บฟๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, lineColor) //x่ฝด่ฝด็บฟ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, linkedTo)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, max)  //x่ฝดๆๅคงๅผ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, min)  //x่ฝดๆๅฐๅผ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, minPadding)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, minRange)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, minTickInterval) //ๆๅฐ้ด้
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, minorGridLineColor) //ๆฌก็ฝๆ ผ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, minorGridLineDashStyle) //ๆฌก็ฝๆ ผ็บฟๆกๆ ทๅผ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, minorGridLineWidth) //ๆฌก็ฝๆ ผ็บฟๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, minorTickColor) //ๆฌกๅปๅบฆ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, minorTickInterval)
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, minorTickLength) //ๆฌกๅปๅบฆ็บฟ้ฟๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, minorTickPosition) //ๆฌกๅปๅบฆ็บฟไฝ็ฝฎ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, minorTickWidth) // ๆฌกๅปๅบฆ็บฟๅฎฝๅบฆ

AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, gridLineWidth) //x่ฝด็ฝๆ ผ็บฟๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, gridLineColor) //x่ฝด็ฝๆ ผ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, gridLineDashStyle) //x่ฝด็ฝๆ ผ็บฟๆ ทๅผ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, gridZIndex) //็ฝๆ ผ็บฟ็ๅฑๅ ๅผ๏ผzIndex๏ผ ้ป่ฎคๆฏ๏ผ1.
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, offset) //x่ฝดๅ็ดๅ็งป
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, AALabels *, labels) //็จไบ่ฎพ็ฝฎ x ่ฝดๆๅญ็ธๅณ็
AAPropStatementAndPropSetFuncStatement(assign, AAXAxis, BOOL ,      visible) //็จไบ่ฎพ็ฝฎ x ่ฝดไปฅๅ x ่ฝดๆๅญๆฏๅฆๆพ็คบ
AAPropStatementAndPropSetFuncStatement(assign, AAXAxis, BOOL,       opposite) //ๆฏๅฆๅฐๅๆ ่ฝดๆพ็คบๅจๅฏน็ซ้ข๏ผ้ป่ฎคๆๅตไธ x ่ฝดๆฏๅจๅพ่กจ็ไธๆนๆพ็คบ๏ผy ่ฝดๆฏๅจๅทฆๆน๏ผๅๆ ่ฝดๆพ็คบๅจๅฏน็ซ้ขๅ๏ผx ่ฝดๆฏๅจไธๆนๆพ็คบ๏ผy ่ฝดๆฏๅจๅณๆนๆพ็คบ๏ผๅณๅๆ ่ฝดไผๆพ็คบๅจๅฏน็ซ้ข๏ผใ่ฏฅ้็ฝฎไธ่ฌๆฏ็จไบๅคๅๆ ่ฝดๅบๅๅฑ็คบ๏ผๅฆๅคๅจ Highstock ไธญ๏ผy ่ฝด้ป่ฎคๆฏๅจๅฏน็ซ้ขๆพ็คบ็ใ ้ป่ฎคๆฏ๏ผfalse.
AAPropStatementAndPropSetFuncStatement(assign, AAXAxis, BOOL ,      startOnTick) //Whether to force the axis to start on a tick. Use this option with the minPadding option to control the axis start. ้ป่ฎคๆฏ๏ผfalse.
AAPropStatementAndPropSetFuncStatement(assign, AAXAxis, BOOL ,      endOnTick) //ๆฏๅฆๅผบๅถๅฐๅๆ ่ฝด็ปๆไบๅปๅบฆ็บฟ๏ผๅฏไปฅ้่ฟๆฌๅฑๆงๅ maxPadding ๆฅๆงๅถๅๆ ่ฝด็็ปๆไฝ็ฝฎใ ้ป่ฎคๆฏ๏ผfalse.
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, AACrosshair *, crosshair)  //ๅๆ็บฟๆ ทๅผ่ฎพ็ฝฎ
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, tickColor) //x่ฝด่ฝด็บฟไธๆนๅปๅบฆ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, tickInterval) //x่ฝดๅปๅบฆ็น้ด้ๆฐ(่ฎพ็ฝฎๆฏ้ๅ ไธช็นๆพ็คบไธไธช X่ฝด็ๅๅฎน)
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, tickmarkPlacement) //ๆฌๅๆฐๅชๅฏนๅ็ฑป่ฝดๆๆใ ๅฝๅผไธบ on ๆถๅปๅบฆ็บฟๅฐๅจๅ็ฑปไธๆนๆพ็คบ๏ผๅฝๅผไธบ between ๆถ๏ผๅปๅบฆ็บฟๅฐๅจไธคไธชๅ็ฑปไธญ้ดๆพ็คบใๅฝ tickInterval ไธบ 1 ๆถ๏ผ้ป่ฎคๆฏ between๏ผๅถไปๆๅต้ป่ฎคๆฏ onใ ้ป่ฎคๆฏ๏ผnull.
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, tickWidth) //ๅๆ ่ฝดๅปๅบฆ็บฟ็ๅฎฝๅบฆ๏ผ่ฎพ็ฝฎไธบ 0 ๆถๅไธๆพ็คบๅปๅบฆ็บฟ
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSNumber *, tickLength)//ๅๆ ่ฝดๅปๅบฆ็บฟ็้ฟๅบฆใ ้ป่ฎคๆฏ๏ผ10.
AAPropStatementAndPropSetFuncStatement(copy,   AAXAxis, NSString *, tickPosition) //ๅปๅบฆ็บฟ็ธๅฏนไบ่ฝด็บฟ็ไฝ็ฝฎ๏ผๅฏ็จ็ๅผๆ inside ๅ outside๏ผๅๅซ่กจ็คบๅจ่ฝด็บฟ็ๅ้จๅๅค้จใ ้ป่ฎคๆฏ๏ผoutside.
AAPropStatementAndPropSetFuncStatement(strong, AAXAxis, NSArray  *, tickPositions) //่ชๅฎไน x ่ฝดๅๆ ๏ผๅฆ๏ผ[@(0), @(25), @(50), @(75) , (100)]๏ผ


@end
