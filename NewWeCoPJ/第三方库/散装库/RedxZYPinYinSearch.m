#import "RedxZYPinYinSearch.h"
#import "RedxChineseInclude.h"
#import "RedxPinYinForObjc.h"
#import "objc/runtime.h"
#import <UIKit/UIKit.h>
@implementation RedxZYPinYinSearch
+(NSArray *)searchWithOriginalArray:(NSArray *)originalArray andSearchText:(NSString *)searchText andSearchByPropertyName:(NSString *)propertyName{
    NSMutableArray * dataSourceArray = [[NSMutableArray alloc]init];
    NSString * type;
    if(originalArray.count <= 0){
        return originalArray;
    }
    else{
        id object = originalArray[0];
        if ([object isKindOfClass:[NSString class]]) {
            type = @"string";
        }
        else if([object isKindOfClass:[NSDictionary class]]){
            type = @"dict";
            NSDictionary * dict = originalArray[0];
            BOOL isExit = NO;
            for (NSString * key in dict.allKeys) {
                if([key isEqualToString:propertyName]){
                    isExit = YES;
                    break;
                }
            }
            if (!isExit) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"数据源中的字典没有你指定的key:%@",propertyName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return originalArray;
            }
        }
        else{
            type = @"model";
            NSMutableArray *props = [NSMutableArray array];
            unsigned int outCount, i;
            objc_property_t *properties = class_copyPropertyList([object class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                [props addObject:propertyName];
            }
            free(properties);
            BOOL isExit = NO;
            for (NSString * property in props) {
                if([property isEqualToString:propertyName]){
                    isExit = YES;
                    break;
                }
            }
            if (!isExit) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"数据源中的Model没有你指定的属性:%@",propertyName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return originalArray;
            }
        }
    }
    if (searchText.length>0&&![RedxChineseInclude isIncludeChineseInString:searchText]) {
        for (int i=0; i<originalArray.count; i++) {
            NSString * tempString;
            if ([type isEqualToString:@"string"]) {
                tempString = originalArray[i];
            }
            else{
                tempString = [originalArray[i]valueForKey:propertyName];
            }
            if ([RedxChineseInclude isIncludeChineseInString:tempString]) {
                NSString *tempPinYinStr = [RedxPinYinForObjc chineseConvertToPinYin:tempString];
                NSRange titleResult=[tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [dataSourceArray addObject:originalArray[i]];
                    continue;
                }
                NSString *tempPinYinHeadStr = [RedxPinYinForObjc chineseConvertToPinYinHead:tempString];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [dataSourceArray addObject:originalArray[i]];
                    continue;
                }
            }
            else {
                NSRange titleResult=[tempString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [dataSourceArray addObject:originalArray[i]];
                    continue;
                }
            }
        }
    } else if (searchText.length>0&&[RedxChineseInclude isIncludeChineseInString:searchText]) {
        for (id object in originalArray) {
            NSString * tempString;
            if ([type isEqualToString:@"string"]) {
                tempString = object;
            }
            else{
                tempString = [object valueForKey:propertyName];
            }
            NSRange titleResult=[tempString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [dataSourceArray addObject:object];
            }
        }
    }
    return dataSourceArray;
}
@end
