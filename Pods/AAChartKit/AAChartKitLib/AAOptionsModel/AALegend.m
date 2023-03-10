//
//  AALegend.m
//  AAChartKit
//
//  Created by An An on 17/1/6.
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

#import "AALegend.h"

@implementation AALegend

AAPropSetFuncImplementation(AALegend, AAChartLayoutType,        layout)
AAPropSetFuncImplementation(AALegend, AAChartAlignType,         align)
AAPropSetFuncImplementation(AALegend, AAChartVerticalAlignType, verticalAlign)
AAPropSetFuncImplementation(AALegend, BOOL,          enabled) 
AAPropSetFuncImplementation(AALegend, NSString    *, borderColor) 
AAPropSetFuncImplementation(AALegend, NSNumber    *, borderWidth) 
AAPropSetFuncImplementation(AALegend, NSNumber    *, itemMarginTop)
AAPropSetFuncImplementation(AALegend, NSNumber    *, itemMarginBottom)
AAPropSetFuncImplementation(AALegend, AAItemStyle *, itemStyle)
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolHeight)//ๆ ๅฟ้ซๅบฆ
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolPadding)//ๆ ๅฟๅ่ท
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolRadius)//ๅพๆ ๅ่ง
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolWidth)//ๅพๆ ๅฎฝๅบฆ
AAPropSetFuncImplementation(AALegend, NSNumber    *, x) 
AAPropSetFuncImplementation(AALegend, NSNumber    *, y)
AAPropSetFuncImplementation(AALegend, BOOL,          floating)
AAPropSetFuncImplementation(AALegend, NSString    *, labelFormat)//ๅพไพๆ ็ญพๆ ผๅผๅๅญ็ฌฆไธฒ

@end



@implementation AAItemStyle

AAPropSetFuncImplementation(AAItemStyle, NSString *, color)
AAPropSetFuncImplementation(AAItemStyle, NSString *, cursor)
AAPropSetFuncImplementation(AAItemStyle, NSString *, fontSize)
AAPropSetFuncImplementation(AAItemStyle, NSString *, fontWeight)

@end
