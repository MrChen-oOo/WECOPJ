//
//  AAChart.h
//  AAChartKit
//
//  Created by An An on 17/1/5.
//  Copyright Â© 2017å¹´ An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * ð ð ð ð  âââ   WARM TIPS!!!   âââ ð ð ð ð
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
#import "AAGlobalMacro.h"

@class AAAnimation, AAScrollablePlotArea, AAResetZoomButton, AAChartEvents;

@interface AAChart : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, type)
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSString    *, backgroundColor)
AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, plotBackgroundImage) //æå®ç»å¾åºèæ¯å¾ççå°åãå¦æéè¦è®¾ç½®æ´ä¸ªå¾è¡¨çèæ¯ï¼è¯·éè¿ CSS æ¥ç»å®¹å¨åç´ ï¼divï¼è®¾ç½®èæ¯å¾ãå¦å¤å¦æéè¦å¨å¯¼åºå¾çä¸­åå«è¿ä¸ªèæ¯å¾ï¼è¦æ±è¿ä¸ªå°åæ¯å¬ç½å¯ä»¥è®¿é®çå°åï¼åå«å¯ä»¥è®¿é®ä¸æ¯ç»å¯¹è·¯å¾ï¼ã
AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, pinchType) 
AAPropStatementAndPropSetFuncStatement(assign, AAChart, BOOL,          panning) 
AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, panKey) //è®¾å®å¹³ç§»æé®ãæä½è®¾å®çæé®æ¶é¼ æ æ»å¨æ¯å¯¹å¾è¡¨è¿è¡å¹³ç§»æä½ãï¼é»è®¤æ¯ç¼©æ¾æä½ï¼éè¿æ­¤æé®å¯ä»¥å®ç°å¨ç¼©æ¾åå¹³ç§»ä¹é´çåæ¢ï¼
AAPropStatementAndPropSetFuncStatement(assign, AAChart, BOOL,          polar) 
AAPropStatementAndPropSetFuncStatement(strong, AAChart, AAAnimation *, animation) //è®¾ç½®å¯ç¨å¨ç»çæ¶é´åç±»å
AAPropStatementAndPropSetFuncStatement(assign, AAChart, BOOL,          inverted)
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSArray     *, margin)// å¾è¡¨å¤è¾¹ç¼åç»å¾åºåä¹é´çè¾¹è·ã æ°ç»ä¸­çæ°å­åå«è¡¨ç¤ºé¡¶é¨ï¼å³ä¾§ï¼åºé¨åå·¦ä¾§ ([ð,ð,ð,ð])ã ä¹å¯ä»¥ä½¿ç¨ marginTopï¼marginRightï¼marginBottom å marginLeft æ¥è®¾ç½®æä¸ä¸ªæ¹åçè¾¹è·ãé»è®¤å¼ä¸º[null]
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginTop) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginRight) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginBottom) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginLeft) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSArray     *, spacing) // å¾è¡¨çåè¾¹è·ï¼æå¾è¡¨å¤è¾¹ç¼åç»å¾åºä¹é´çè·ç¦»ï¼æ°ç»ä¸­çæ°å­åå«è¡¨ç¤ºé¡¶é¨ï¼å³ä¾§ï¼åºé¨åå·¦ä¾§([ð,ð,ð,ð])ãå¯ä»¥ä½¿ç¨éé¡¹ spacingTopï¼spacingRightï¼spacingBottom å spacingLeft æ¥æå®æä¸ä¸ªåè¾¹è·ã é»è®¤æ¯ï¼[10, 10, 15, 10].
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, spacingTop) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, spacingRight) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, spacingBottom) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, spacingLeft) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, AAScrollablePlotArea *, scrollablePlotArea)
AAPropStatementAndPropSetFuncStatement(strong, AAChart, AAResetZoomButton *, resetZoomButton)
AAPropStatementAndPropSetFuncStatement(strong, AAChart, AAChartEvents *, events)


@end


//Refer to online API document: https://api.highcharts.com/highcharts/chart.scrollablePlotArea
@interface AAScrollablePlotArea : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, minHeight)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, minWidth)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, opacity)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, scrollPositionX)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, scrollPositionY)

@end


@class AAPosition;

@interface AAResetZoomButton : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAResetZoomButton, AAPosition   *, position)
AAPropStatementAndPropSetFuncStatement(copy  , AAResetZoomButton, NSString     *, relativeTo)
AAPropStatementAndPropSetFuncStatement(strong, AAResetZoomButton, NSDictionary *, theme)

@end


@interface AAChartEvents : NSObject

AAPropStatementAndPropSetFuncStatement(copy  , AAChartEvents, NSString     *, load)
AAPropStatementAndPropSetFuncStatement(copy  , AAChartEvents, NSString     *, redraw)
AAPropStatementAndPropSetFuncStatement(copy  , AAChartEvents, NSString     *, render)
AAPropStatementAndPropSetFuncStatement(copy  , AAChartEvents, NSString     *, selection)

@end

