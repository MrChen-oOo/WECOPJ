#import "NSArray+MASAdditions.h"
#ifdef MAS_SHORTHAND
@interface NSArray (MASShorthandAdditions)
- (NSArray *)makeConstraints:(void(^)(RedxMASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(RedxMASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(RedxMASConstraintMaker *make))block;
@end
@implementation NSArray (MASShorthandAdditions)
- (NSArray *)makeConstraints:(void(^)(RedxMASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}
- (NSArray *)updateConstraints:(void(^)(RedxMASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}
- (NSArray *)remakeConstraints:(void(^)(RedxMASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}
@end
#endif
