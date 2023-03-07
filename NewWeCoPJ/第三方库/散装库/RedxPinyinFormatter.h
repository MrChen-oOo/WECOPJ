#ifndef _PinyinFormatter_H_
#define _PinyinFormatter_H_
#import <Foundation/Foundation.h>
@class RedxHanyuPinyinOutputFormat;
@interface RedxPinyinFormatter : NSObject {
}
+ (NSString *)formatHanyuPinyinWithNSString:(NSString *)pinyinStr
                withHanyuPinyinOutputFormat:(RedxHanyuPinyinOutputFormat *)outputFormat;
+ (NSString *)convertToneNumber2ToneMarkWithNSString:(NSString *)pinyinStr;
- (id)init;
@end
#endif 
