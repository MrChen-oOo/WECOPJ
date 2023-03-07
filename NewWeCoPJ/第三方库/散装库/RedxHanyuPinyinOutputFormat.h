#ifndef _HanyuPinyinOutputFormat_H_
#define _HanyuPinyinOutputFormat_H_
#import <Foundation/Foundation.h>
typedef enum {
  ToneTypeWithToneNumber,
  ToneTypeWithoutTone,
  ToneTypeWithToneMark
}ToneType;
typedef enum {
    CaseTypeUppercase,
    CaseTypeLowercase
}CaseType;
typedef enum {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
}VCharType;
@interface RedxHanyuPinyinOutputFormat : NSObject
@property(nonatomic, assign) VCharType vCharType;
@property(nonatomic, assign) CaseType caseType;
@property(nonatomic, assign) ToneType toneType;
- (id)init;
- (void)restoreDefault;
@end
#endif 
