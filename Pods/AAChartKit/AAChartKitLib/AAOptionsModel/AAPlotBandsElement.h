//
//  AAPlotBandsElement.h
//  AAChartKitDemo
//
//  Created by AnAn on 2018/12/23.
//  Copyright ยฉ 2018 An An. All rights reserved.
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

//borderColor: null
//borderWidth: ่พนๆกๅฎฝๅบฆ
//className: ็ฑปๅ
//color: ๆ ทๅผ
//events: ไบไปถ
//from: ๅผๅงๅผ
//id: ็ผๅท
//innerRadius: null
//label: {ๆ ็ญพ}
//outerRadius: 100%
//thickness: 10
//to: ็ปๆๅผ
//zIndex

#import <Foundation/Foundation.h>

@class AALabel;
@interface AAPlotBandsElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAPlotBandsElement, NSString *, borderColor)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotBandsElement, NSNumber *, borderWidth)
AAPropStatementAndPropSetFuncStatement(copy,   AAPlotBandsElement, NSString *, className)
AAPropStatementAndPropSetFuncStatement(copy,   AAPlotBandsElement, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotBandsElement, NSNumber *, from)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotBandsElement, AALabel  *, label)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotBandsElement, NSNumber *, to)
AAPropStatementAndPropSetFuncStatement(assign, AAPlotBandsElement, NSUInteger , zIndex)

@end
