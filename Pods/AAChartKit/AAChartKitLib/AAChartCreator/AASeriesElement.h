//
//  AASeriesElement.h
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

@class AAMarker, AADataLabels, AATooltip, AAStates, AAShadow, AAZonesElement, AADataSorting;

@interface AASeriesElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, type) 
AAPropStatementAndPropSetFuncStatement(assign, AASeriesElement, BOOL      , allowPointSelect) //æ¯å¦åè®¸å¨ç¹å»æ°æ®ç¹æ è®°ï¼markersï¼ãæ±å­ï¼æ±å½¢å¾ï¼ãæåºï¼é¥¼å¾ï¼æ¶éä¸­è¯¥ç¹ï¼éä¸­çç¹å¯ä»¥éè¿ Chart.getSelectedPoints æ¥è·åã é»è®¤æ¯ï¼false.
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, name) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSArray  *, data) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSArray  *, colors)
AAPropStatementAndPropSetFuncStatement(assign, AASeriesElement, id        , colorByPoint) //When using automatic point colors pulled from the options.colors collection, this option determines whether the chart should receive one color per series or one color per point. é»è®¤æ¯ï¼false.
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, AAMarker *, marker) 
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, stacking) 
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, dashStyle) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, threshold) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, lineWidth) //æçº¿å¾ãæ²çº¿å¾ãç´æ¹æçº¿å¾ãæçº¿å¡«åå¾ãæ²çº¿å¡«åå¾ãç´æ¹æçº¿å¡«åå¾ççº¿æ¡å®½åº¦
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, borderColor) //The border color, It is only valid for column, bar, pie, columnrange, pyramid and funnel chart types
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, borderWidth) //The border width, It is only valid for column, bar, pie, columnrange, pyramid and funnel chart types
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, borderRadius) //The corner radius of the border surrounding each column or bar.
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, borderRadiusTopLeft)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, borderRadiusTopRight)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, borderRadiusBottomLeft)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, borderRadiusBottomRight)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSString *, fillColor) //æçº¿å¡«åå¾ãæ²çº¿å¡«åå¾ãç´æ¹æçº¿å¡«åå¾ç­å¡«åå¾ç±»åçå¡«åé¢è²
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, fillOpacity) //æçº¿å¡«åå¾ãæ²çº¿å¡«åå¾ãç´æ¹æçº¿å¡«åå¾ç­å¡«åå¾ç±»åçå¡«åé¢è²éæåº¦
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSString *, negativeColor)  // The color for the parts of the graph or points that are below the threshold
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSString *, negativeFillColor)//A separate color for the negative part of the area.
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, innerSize) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, size) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSArray  *, keys) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, yAxis) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, AADataLabels*, dataLabels) 
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, id        , step) //æ¯å¦è½¬åä¸ºç´æ¹æçº¿å¾
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, AAStates *, states)
AAPropStatementAndPropSetFuncStatement(assign, AASeriesElement, BOOL      , showInLegend) //Whether to display this particular series or series type in the legend. The default value is true for standalone series, false for linked series. é»è®¤æ¯ï¼true.
AAPropStatementAndPropSetFuncStatement(assign, AASeriesElement, BOOL      , visible) //æ°æ®åæ¯å¦æ¾ç¤ºçç¶æ,å¯ä»¥éè¿ series.show()ãseries.hide()ãseries.setVisible æ¥æ¹åè¿ä¸ªå±æ§
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSArray<AAZonesElement *>*, zones)
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, zoneAxis) //Defines the Axis on which the zones are applied. é»è®¤æ¯ï¼y.
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, AAShadow *, shadow) //æ°æ®åçé´å½±ææãä» 2.3 å¼å§é´å½±å¯ä»¥éç½®æåå« colorãoffsetXãoffsetYãopacity å width å±æ§çå¯¹è±¡å½¢å¼ã é»è®¤æ¯ï¼false
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, stack)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, AATooltip*, tooltip)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, NSNumber *, zIndex) //å±å ï¼series element å¨å¾è¡¨ä¸­æ¾ç¤ºçå±å çº§å«ï¼å¼è¶å¤§ï¼æ¾ç¤ºè¶åå
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, pointPlacement)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, id        , enableMouseTracking)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, AADataSorting *, dataSorting)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, id        , reversed) //Only useful for pyramid chart and funnel chart
AAPropStatementAndPropSetFuncStatement(copy,   AASeriesElement, NSString *, id)
AAPropStatementAndPropSetFuncStatement(strong, AASeriesElement, id        , connectNulls)
AAPropStatementAndPropSetFuncStatement(assign, AASeriesElement, BOOL        , enabledCrosshairs)

@end


@interface AADataElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy  , AADataElement, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AADataElement, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(strong, AADataElement, AAMarker *, marker)
AAPropStatementAndPropSetFuncStatement(copy  , AADataElement, NSString *, name)
AAPropStatementAndPropSetFuncStatement(strong, AADataElement, NSNumber *, x)
AAPropStatementAndPropSetFuncStatement(strong, AADataElement, NSNumber *, y)

@end


@interface AAZonesElement : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAZonesElement, NSNumber *, value)
AAPropStatementAndPropSetFuncStatement(copy,   AAZonesElement, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AAZonesElement, NSString *, fillColor)
AAPropStatementAndPropSetFuncStatement(copy,   AAZonesElement, NSString *, dashStyle)

@end


@interface AADataSorting : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AADataSorting, BOOL, enabled)
AAPropStatementAndPropSetFuncStatement(assign, AADataSorting, BOOL, matchByName)

@end


