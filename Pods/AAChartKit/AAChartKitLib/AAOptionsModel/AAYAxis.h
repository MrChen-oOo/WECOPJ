//
//  AAYAxis.h
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

@class AAAxisTitle, AALabels, AACrosshair, AAStyle, AAPlotBandsElement, AAPlotLinesElement, AADateTimeLabelFormats;

typedef NSString *AAChartYAxisGridLineInterpolationType;

AACHARTKIT_EXTERN AAChartYAxisGridLineInterpolationType const AAChartYAxisGridLineInterpolationTypeCircle;
AACHARTKIT_EXTERN AAChartYAxisGridLineInterpolationType const AAChartYAxisGridLineInterpolationTypePolygon;

@interface AAYAxis : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AAYAxis, BOOL,       allowDecimals)  //y่ฝดๆฏๅฆๅ่ฎธๆพ็คบๅฐๆฐ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, alternateGridColor) //้ด้็ฝๆ ผ่ๆฏ, ๅฝๆๅฎ่ฏฅๅๆฐๆถ๏ผ็ธ้ปๅปๅบฆ็บฟไน้ดไผ็จๅฏนๅบ็้ข่ฒๆฅ็ปๅถ้ข่ฒๅ่พจๅธฆ.
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, AAAxisTitle  *, title)
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, AAChartAxisType, type)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, AADateTimeLabelFormats  *, dateTimeLabelFormats)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSArray<AAPlotBandsElement *>*, plotBands)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSArray<AAPlotLinesElement *>*, plotLines)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSArray  *, categories)
AAPropStatementAndPropSetFuncStatement(assign, AAYAxis, BOOL,       reversed)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, gridLineWidth) // y ่ฝด็ฝๆ ผ็บฟๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, gridLineColor) // y ่ฝด็ฝๆ ผ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, gridLineDashStyle) //็ฝๆ ผ็บฟ็บฟๆกๆ ทๅผ๏ผๆๆๅฏ็จ็็บฟๆกๆ ทๅผๅ่๏ผHighcharts็บฟๆกๆ ทๅผ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, gridZIndex) //็ฝๆ ผ็บฟ็ๅฑๅ ๅผ๏ผzIndex๏ผ ้ป่ฎคๆฏ๏ผ1.
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, AAChartYAxisGridLineInterpolationType, gridLineInterpolation) //Polar charts only. Whether the grid lines should draw as a polygon with straight lines between categories, or as circles. Can be either circle or polygon. ้ป่ฎคๆฏ๏ผnull.
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, AALabels *, labels) //็จไบ่ฎพ็ฝฎ y ่ฝดๆๅญ็ธๅณ็
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, lineWidth) // y ่ฝด็บฟๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, lineColor) // y ่ฝด็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, offset) // y ่ฝด็บฟๆฐดๅนณๅ็งป

AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, max)  //y่ฝดๆๅคงๅผ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, min)  //y่ฝดๆๅฐๅผ๏ผ่ฎพ็ฝฎไธบ0ๅฐฑไธไผๆ่ดๆฐ๏ผ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, minPadding)  //Padding of the min value relative to the length of the axis. A padding of 0.05 will make a 100px axis 5px longer. This is useful when you don't want the lowest data value to appear on the edge of the plot area. ้ป่ฎคๆฏ๏ผ0.05.
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, minRange)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, minTickInterval) //ๆๅฐ้ด้
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, minorGridLineColor) //ๆฌก็ฝๆ ผ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, minorGridLineDashStyle) //ๆฌก็ฝๆ ผ็บฟๆกๆ ทๅผ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, minorGridLineWidth) //ๆฌก็ฝๆ ผ็บฟๅฎฝๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, minorTickColor) //ๆฌกๅปๅบฆ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, minorTickInterval)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, minorTickLength) //ๆฌกๅปๅบฆ็บฟ้ฟๅบฆ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, minorTickPosition) //ๆฌกๅปๅบฆ็บฟไฝ็ฝฎ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, minorTickWidth) // ๆฌกๅปๅบฆ็บฟๅฎฝๅบฆ

AAPropStatementAndPropSetFuncStatement(assign, AAYAxis, BOOL,       visible)  //y่ฝดๆฏๅฆๅ่ฎธๆพ็คบ
AAPropStatementAndPropSetFuncStatement(assign, AAYAxis, BOOL,       opposite) //ๆฏๅฆๅฐๅๆ ่ฝดๆพ็คบๅจๅฏน็ซ้ข๏ผ้ป่ฎคๆๅตไธ x ่ฝดๆฏๅจๅพ่กจ็ไธๆนๆพ็คบ๏ผy ่ฝดๆฏๅจๅทฆๆน๏ผๅๆ ่ฝดๆพ็คบๅจๅฏน็ซ้ขๅ๏ผx ่ฝดๆฏๅจไธๆนๆพ็คบ๏ผy ่ฝดๆฏๅจๅณๆนๆพ็คบ๏ผๅณๅๆ ่ฝดไผๆพ็คบๅจๅฏน็ซ้ข๏ผใ่ฏฅ้็ฝฎไธ่ฌๆฏ็จไบๅคๅๆ ่ฝดๅบๅๅฑ็คบ๏ผๅฆๅคๅจ Highstock ไธญ๏ผy ่ฝด้ป่ฎคๆฏๅจๅฏน็ซ้ขๆพ็คบ็ใ ้ป่ฎคๆฏ๏ผfalse.
AAPropStatementAndPropSetFuncStatement(assign, AAYAxis, BOOL ,      startOnTick) //Whether to force the axis to start on a tick. Use this option with the minPadding option to control the axis start. ้ป่ฎคๆฏ๏ผfalse.
AAPropStatementAndPropSetFuncStatement(assign, AAYAxis, BOOL ,      endOnTick) //ๆฏๅฆๅผบๅถๅฐๅๆ ่ฝด็ปๆไบๅปๅบฆ็บฟ๏ผๅฏไปฅ้่ฟๆฌๅฑๆงๅ maxPadding ๆฅๆงๅถๅๆ ่ฝด็็ปๆไฝ็ฝฎใ ้ป่ฎคๆฏ๏ผfalse.
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, AACrosshair*, crosshair)  //ๅๆ็บฟๆ ทๅผ่ฎพ็ฝฎ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, AALabels *, stackLabels)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, tickAmount)//ๅปๅบฆๆปๆฐ
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, tickColor) // ๅปๅบฆ็บฟ้ข่ฒ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, tickInterval) 
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, tickWidth) //ๅๆ ่ฝดๅปๅบฆ็บฟ็ๅฎฝๅบฆ๏ผ่ฎพ็ฝฎไธบ 0 ๆถๅไธๆพ็คบๅปๅบฆ็บฟ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSNumber *, tickLength)//ๅๆ ่ฝดๅปๅบฆ็บฟ็้ฟๅบฆใ ้ป่ฎคๆฏ๏ผ10.
AAPropStatementAndPropSetFuncStatement(copy,   AAYAxis, NSString *, tickPosition) //ๅปๅบฆ็บฟ็ธๅฏนไบ่ฝด็บฟ็ไฝ็ฝฎ๏ผๅฏ็จ็ๅผๆ inside ๅ outside๏ผๅๅซ่กจ็คบๅจ่ฝด็บฟ็ๅ้จๅๅค้จใ ้ป่ฎคๆฏ๏ผoutside.
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, NSArray  *, tickPositions) //่ชๅฎไนY่ฝดๅๆ ๏ผๅฆ๏ผ[@(0), @(25), @(50), @(75) , (100)]๏ผ
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, id        , top)
AAPropStatementAndPropSetFuncStatement(strong, AAYAxis, id        , height)


@end

@interface AAAxisTitle : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAAxisTitle, NSString *, align)
AAPropStatementAndPropSetFuncStatement(copy,   AAAxisTitle, NSString *, margin)
AAPropStatementAndPropSetFuncStatement(strong, AAAxisTitle, NSNumber *, offset)
AAPropStatementAndPropSetFuncStatement(strong, AAAxisTitle, NSNumber *, rotation)
AAPropStatementAndPropSetFuncStatement(strong, AAAxisTitle, AAStyle  *, style)
AAPropStatementAndPropSetFuncStatement(copy,   AAAxisTitle, NSString *, text)
AAPropStatementAndPropSetFuncStatement(strong, AAAxisTitle, NSNumber *, x) //ๆ ้ข็ธๅฏนไบๆฐดๅนณๅฏน้ฝ็ๅ็งป้๏ผๅๅผ่ๅดไธบ๏ผๅพ่กจๅทฆ่พน่ทๅฐๅพ่กจๅณ่พน่ท๏ผๅฏไปฅๆฏ่ดๅผ๏ผๅไฝpxใ ้ป่ฎคๆฏ๏ผ0.
AAPropStatementAndPropSetFuncStatement(strong, AAAxisTitle, NSNumber *, y) //ๆ ้ข็ธๅฏนไบๅ็ดๅฏน้ฝ็ๅ็งป้๏ผๅๅผ่ๅด๏ผๅพ่กจ็ไธ่พน่ท๏ผchart.spacingTop ๏ผๅฐๅพ่กจ็ไธ่พน่ท๏ผchart.spacingBottom๏ผ๏ผๅฏไปฅๆฏ่ดๅผ๏ผๅไฝๆฏpxใ้ป่ฎคๅผๅๅญไฝๅคงๅฐๆๅณใ

@end
