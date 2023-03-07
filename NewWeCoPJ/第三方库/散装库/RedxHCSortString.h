#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface RedxHCSortString : NSObject
@property (strong, nonatomic) NSString     *initial;
@property (strong, nonatomic) NSString     *string;
@property (strong, nonatomic) NSString     *englishString;
@property (strong, nonatomic) NSObject     *model;
#pragma mark - 给数组按首字母排序和分组
+ (NSMutableDictionary *)sortAndGroupForArray:(NSArray *)ary PropertyName:(nullable NSString *)name;
#pragma mark - 给字符串数组进行排序
+ (NSMutableArray *)sortForStringAry:(NSArray *)ary;
#pragma mark - 得到一个字典的所有值
+ (NSMutableArray *)getAllValuesFromDict:(NSDictionary *)dict;
NS_ASSUME_NONNULL_END
@end
