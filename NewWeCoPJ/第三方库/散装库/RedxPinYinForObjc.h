#import <Foundation/Foundation.h>
#import "RedxHanyuPinyinOutputFormat.h"
#import "RedxPinyinHelper.h"
@interface RedxPinYinForObjc : NSObject
+ (NSString*)chineseConvertToPinYin:(NSString*)chinese;
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese;
@end
