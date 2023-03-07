#import "RedxHCSortString.h"
#import <objc/runtime.h>
#import "UIAlertController+HCAdd.h"
@implementation RedxHCSortString
+ (NSMutableArray *)sortForStringAry:(NSArray *)ary {
    NSMutableArray *sortAry = [NSMutableArray arrayWithArray:ary];
    NSMutableArray *removeAry = [NSMutableArray new];
    for (NSString *str in sortAry){
        if ([str isEqualToString:@"#"]) {
            [removeAry addObject:str];
            break;
        }
    }
    [sortAry removeObjectsInArray:removeAry];
    [sortAry addObjectsFromArray:removeAry];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptorAry = [NSArray arrayWithObject:descriptor];
    [sortAry sortUsingDescriptors:descriptorAry];
    return sortAry;
}
+ (NSMutableArray *)getAllValuesFromDict:(NSDictionary *)dict {
    NSMutableArray *valuesAry = [NSMutableArray new];
    NSArray *keyAry = [self sortForStringAry:[dict allKeys]];
    for (NSString *key in keyAry){
        NSArray *value = [dict objectForKey:key];
        [valuesAry addObjectsFromArray:value];
    }
    return valuesAry;
}
+ (NSMutableDictionary *)sortAndGroupForArray:(NSArray *)ary PropertyName:(NSString *)name {
    NSMutableDictionary *sortDic = [NSMutableDictionary new];
    NSMutableArray *sortAry = [NSMutableArray new];
    NSMutableArray *objAry = [NSMutableArray new];
    NSString *type;
    if (ary.count <= 0) {
        return sortDic;
    }
    id objc = ary.firstObject;
    if ([objc isKindOfClass:[NSString class]]) {
        type = @"string";
        for (NSString *str in ary){
            RedxHCSortString *sortString = [RedxHCSortString new];
            sortString.string = str;
            [objAry addObject:sortString];
        }
    }else if ([objc isKindOfClass:[NSDictionary class]]){
        type = @"dict";
    }else{
        type = @"model";
        unsigned int propertyCount, i;
        objc_property_t *properties = class_copyPropertyList([objc class], &propertyCount);
        for (NSObject *obj in ary){
            RedxHCSortString *sortString = [RedxHCSortString new];
            sortString.model = obj;
            for (i = 0; i < propertyCount; i++) {
                objc_property_t property = properties[i];
                const char *char_name = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_name];
                if ([propertyName isEqualToString:name]) {
                    id propertyValue = [obj valueForKey:(NSString *)propertyName];
                    sortString.string = propertyValue;
                    [objAry addObject:sortString];
                    break;
                }
                if (i == propertyCount -1) {
                    [UIAlertController showAlertViewWithTitle:@"提示" Message:[NSString stringWithFormat:@"数据源中的Model没有你指定的属性:%@",name] BtnTitles:@[@"确定"] ClickBtn:nil];
                    return sortDic;
                }
            }
        }
    }
    sortAry = [self sortAsInitialWithArray:objAry];
    NSMutableArray *item = [NSMutableArray array];
    NSString *itemString;
    for (RedxHCSortString *sort in sortAry){
        if (![itemString isEqualToString:sort.initial]) {
            itemString = sort.initial;
            item = [NSMutableArray array];
            if ([type isEqualToString:@"string"]) {
                [item addObject:sort.string];
            }else if ([type isEqualToString:@"model"]){
                [item addObject:sort.model];
            }
            [sortDic setObject:item forKey:itemString];
        }else{
            if ([type isEqualToString:@"string"]) {
                [item addObject:sort.string];
            }else if ([type isEqualToString:@"model"]){
                [item addObject:sort.model];
            }
        }
    }
    return sortDic;
}
+ (NSMutableArray *)sortAsInitialWithArray:(NSArray *)ary {
    NSMutableArray *objectAry = [NSMutableArray array];
    for (NSInteger index = 0; index < ary.count; index++) {
        RedxHCSortString *sortString = ary[index];
        sortString.englishString = [RedxHCSortString transform:sortString.string];
        if (sortString.string == nil) {
            sortString.string = @"";
        }
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        NSString *header = [sortString.string substringToIndex:1];
        if ([predicate evaluateWithObject:header]) {
            sortString.initial = [header capitalizedString];
        }else{
            if (![sortString.string isEqualToString:@""]) {
                if ([header isEqualToString:@"长"]) {
                    sortString.initial = @"C";
                    sortString.englishString = [sortString.englishString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"C"];
                }else{
                    char initial = [sortString.englishString characterAtIndex:0];
                    if (initial >= 'A' && initial <= 'Z') {
                        sortString.initial = [NSString stringWithFormat:@"%c",initial];
                    }else{
                        sortString.initial = @"#";
                    }
                }
            }else{
                sortString.initial = @"#";
            }
        }
        [objectAry addObject:sortString];
    }
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"initial" ascending:YES];
    NSSortDescriptor *descriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"englishString" ascending:YES];
    NSArray *descriptorAry = [NSArray arrayWithObjects:descriptor,descriptor2, nil];
    [objectAry sortUsingDescriptors:descriptorAry];
    return objectAry;
}
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *english = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformStripCombiningMarks, NO);
    [english stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [english uppercaseString];
}
@end
