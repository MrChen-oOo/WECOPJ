//
//  AALabel.m
//  AAChartKitDemo
//
//  Created by AnAn on 2018/12/30.
//  Copyright Â© 2018 An An. All rights reserved.
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

#import "AALabel.h"
#import "NSString+toPureJSString.h"

@implementation AALabel

AAPropSetFuncImplementation(AALabel, NSString *, align)//æ ç­¾çå¯¹é½æ¹å¼ï¼å¯ç¨çå¼æ "left"ã"center" å "right"ãé»è®¤å¼æ¯æ ¹æ®åæ è½´çä½ç½®ï¼å¨å¾è¡¨ä¸­çä½ç½®ï¼å³æ ç­¾çæè½¬è§åº¦è¿è¡æºè½å¤æ­çã é»è®¤æ¯ï¼center.
AAPropSetFuncImplementation(AALabel, NSNumber *, rotation)//æ ç­¾çæè½¬è§åº¦ é»è®¤æ¯ï¼0.
AAPropSetFuncImplementation(AALabel, NSString *, text)//æå­
AAPropSetFuncImplementation(AALabel, NSString *, textAlign)//æå­å¯¹é½
AAPropSetFuncImplementation(AALabel, BOOL      , useHTML)//HTMLæ¸²æ
AAPropSetFuncImplementation(AALabel, NSString *, verticalAlign)//ç«ç´å¯¹é½
AAPropSetFuncImplementation(AALabel, AAStyle  *, style)//è½´æ ç­¾ç CSS æ ·å¼
AAPropSetFuncImplementation(AALabel, NSNumber *, x)//æ°´å¹³åç§»
AAPropSetFuncImplementation(AALabel, NSNumber *, y)// ç«ç´åç§»

AAJSFuncTypePropSetFuncImplementation(AALabel, NSString *, formatter)

- (void)setFormatter:(NSString *)formatter {
    _formatter = [formatter aa_toPureJSString];
}


@end
