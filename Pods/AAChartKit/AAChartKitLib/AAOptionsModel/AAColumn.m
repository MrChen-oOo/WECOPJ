//
//  AAColumn.m
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

#import "AAColumn.h"

@implementation AAColumn
    
- (instancetype)init {
    self = [super init];
    if (self) {
        _grouping = true;
    }
    return self;
}

AAPropSetFuncImplementation(AAColumn, NSString *,     name)
AAPropSetFuncImplementation(AAColumn, NSArray  *,     data)
AAPropSetFuncImplementation(AAColumn, NSString *,     color)
AAPropSetFuncImplementation(AAColumn, BOOL,           grouping)
AAPropSetFuncImplementation(AAColumn, NSNumber *,     pointPadding)
AAPropSetFuncImplementation(AAColumn, NSNumber *,     pointPlacement)
AAPropSetFuncImplementation(AAColumn, NSNumber *,     groupPadding)
AAPropSetFuncImplementation(AAColumn, NSNumber *,     borderWidth)
AAPropSetFuncImplementation(AAColumn, BOOL ,          colorByPoint)
AAPropSetFuncImplementation(AAColumn, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AAColumn, NSString *,     stacking)
AAPropSetFuncImplementation(AAColumn, NSNumber *,     borderRadius)
AAPropSetFuncImplementation(AAColumn, NSNumber *,     yAxis)
AAPropSetFuncImplementation(AAColumn, NSNumber *,     pointWidth) //ๆฑๅฝขๆก็ๅฎฝๅบฆ
AAPropSetFuncImplementation(AAColumn, NSNumber *,     maxPointWidth) //ๆฑๅฝขๆก็ๆๅคงๅฎฝๅบฆ
AAPropSetFuncImplementation(AAColumn, NSNumber *,     minPointLength) //ๆฑๅฝขๆก็ๆๅฐ้ซๅบฆ

@end
