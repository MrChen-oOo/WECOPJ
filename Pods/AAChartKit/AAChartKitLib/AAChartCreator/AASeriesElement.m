//
//  AASeriesElement.m
//  AAChartKit
//
//  Created by An An on 17/1/19.
//  Copyright Â© 2017å¹´ An An. xAll rights reserved.
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


#import "AASeriesElement.h"

@implementation AASeriesElement

- (instancetype)init {
    self = [super init];
    if (self) {
        _allowPointSelect = false;
        _showInLegend = true;
        _visible = true;
    }
    return self;
}

AAPropSetFuncImplementation(AASeriesElement, NSString *, type) 
AAPropSetFuncImplementation(AASeriesElement, BOOL      , allowPointSelect) //æ¯å¦åè®¸å¨ç¹å»æ°æ®ç¹æ è®°ï¼markersï¼ãæ±å­ï¼æ±å½¢å¾ï¼ãæåºï¼é¥¼å¾ï¼æ¶éä¸­è¯¥ç¹ï¼éä¸­çç¹å¯ä»¥éè¿ Chart.getSelectedPoints æ¥è·åã é»è®¤æ¯ï¼false.
AAPropSetFuncImplementation(AASeriesElement, NSString *, name) 
AAPropSetFuncImplementation(AASeriesElement, NSArray  *, data) 
AAPropSetFuncImplementation(AASeriesElement, NSString *, color)
AAPropSetFuncImplementation(AASeriesElement, NSArray  *, colors)
AAPropSetFuncImplementation(AASeriesElement, id        , colorByPoint) //When using automatic point colors pulled from the options.colors collection, this option determines whether the chart should receive one color per series or one color per point. é»è®¤æ¯ï¼false.
AAPropSetFuncImplementation(AASeriesElement, AAMarker *, marker) 
AAPropSetFuncImplementation(AASeriesElement, NSString *, stacking) 
AAPropSetFuncImplementation(AASeriesElement, NSString *, dashStyle) 
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, threshold) 
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, lineWidth) //æçº¿å¾ãæ²çº¿å¾ãç´æ¹æçº¿å¾ãæçº¿å¡«åå¾ãæ²çº¿å¡«åå¾ãç´æ¹æçº¿å¡«åå¾ççº¿æ¡å®½åº¦
AAPropSetFuncImplementation(AASeriesElement, NSString *, borderColor) //The border color, It is only valid for column, bar, pie, columnrange, pyramid and funnel chart types
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, borderWidth) //The border width, It is only valid for column, bar, pie, columnrange, pyramid and funnel chart types
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, borderRadius) //The corner radius of the border surrounding each column or bar.
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, borderRadiusTopLeft)
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, borderRadiusTopRight)
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, borderRadiusBottomLeft)
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, borderRadiusBottomRight)
AAPropSetFuncImplementation(AASeriesElement, NSString *, fillColor) //æçº¿å¡«åå¾ãæ²çº¿å¡«åå¾ãç´æ¹æçº¿å¡«åå¾ç­å¡«åå¾ç±»åçå¡«åé¢è²
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, fillOpacity) //æçº¿å¡«åå¾ãæ²çº¿å¡«åå¾ãç´æ¹æçº¿å¡«åå¾ç­å¡«åå¾ç±»åçå¡«åé¢è²éæåº¦
AAPropSetFuncImplementation(AASeriesElement, NSString *, negativeColor)  //The color for the parts of the graph or points that are below the threshold
AAPropSetFuncImplementation(AASeriesElement, NSString *, negativeFillColor)//A separate color for the negative part of the area.
AAPropSetFuncImplementation(AASeriesElement, NSString *, innerSize) 
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, size) 
AAPropSetFuncImplementation(AASeriesElement, NSArray  *, keys) 
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, yAxis) 
AAPropSetFuncImplementation(AASeriesElement, AADataLabels*, dataLabels) 
AAPropSetFuncImplementation(AASeriesElement, id        , step) //æ¯å¦è½¬åä¸ºç´æ¹æçº¿å¾
AAPropSetFuncImplementation(AASeriesElement, AAStates *, states)
AAPropSetFuncImplementation(AASeriesElement, BOOL      , showInLegend) //Whether to display this particular series or series type in the legend. The default value is true for standalone series, false for linked series. é»è®¤æ¯ï¼true.
AAPropSetFuncImplementation(AASeriesElement, BOOL      , visible) //æ°æ®åæ¯å¦æ¾ç¤ºçç¶æ,å¯ä»¥éè¿ series.show()ãseries.hide()ãseries.setVisible æ¥æ¹åè¿ä¸ªå±æ§
AAPropSetFuncImplementation(AASeriesElement, NSArray<AAZonesElement *>*, zones)
AAPropSetFuncImplementation(AASeriesElement, NSString *, zoneAxis) //Defines the Axis on which the zones are applied. é»è®¤æ¯ï¼y.
AAPropSetFuncImplementation(AASeriesElement, AAShadow *, shadow) //æ°æ®åçé´å½±ææãä» 2.3 å¼å§é´å½±å¯ä»¥éç½®æåå« colorãoffsetXãoffsetYãopacity å width å±æ§çå¯¹è±¡å½¢å¼ã é»è®¤æ¯ï¼false
AAPropSetFuncImplementation(AASeriesElement, NSString *, stack)
AAPropSetFuncImplementation(AASeriesElement, AATooltip*, tooltip)
AAPropSetFuncImplementation(AASeriesElement, NSNumber *, zIndex) //å±å ï¼series element å¨å¾è¡¨ä¸­æ¾ç¤ºçå±å çº§å«ï¼å¼è¶å¤§ï¼æ¾ç¤ºè¶åå
AAPropSetFuncImplementation(AASeriesElement, NSString *, pointPlacement)
AAPropSetFuncImplementation(AASeriesElement, id        , enableMouseTracking)
AAPropSetFuncImplementation(AASeriesElement, AADataSorting *, dataSorting)
AAPropSetFuncImplementation(AASeriesElement, id        , reversed) //Only useful for pyramid chart and funnel chart
AAPropSetFuncImplementation(AASeriesElement, NSString *, id)
AAPropSetFuncImplementation(AASeriesElement, id        , connectNulls)
AAPropSetFuncImplementation(AASeriesElement, BOOL        , enabledCrosshairs)

@end


@implementation AADataElement

AAPropSetFuncImplementation(AADataElement, NSString *, color)
AAPropSetFuncImplementation(AADataElement, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AADataElement, AAMarker *, marker)
AAPropSetFuncImplementation(AADataElement, NSString *, name)
AAPropSetFuncImplementation(AADataElement, NSNumber *, x)
AAPropSetFuncImplementation(AADataElement, NSNumber *, y)

@end


@implementation AAZonesElement : NSObject

AAPropSetFuncImplementation(AAZonesElement, NSNumber *, value)
AAPropSetFuncImplementation(AAZonesElement, NSString *, color)
AAPropSetFuncImplementation(AAZonesElement, NSString *, fillColor)
AAPropSetFuncImplementation(AAZonesElement, NSString *, dashStyle)

@end


@implementation AADataSorting : NSObject

AAPropSetFuncImplementation(AADataSorting, BOOL, enabled)
AAPropSetFuncImplementation(AADataSorting, BOOL, matchByName)

@end
