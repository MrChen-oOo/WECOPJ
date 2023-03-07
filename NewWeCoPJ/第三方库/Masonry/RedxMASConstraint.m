#import "RedxMASConstraint.h"
#import "MASConstraint+Private.h"
#define MASMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]
@implementation RedxMASConstraint
#pragma mark - Init
- (id)init {
	NSAssert(![self isMemberOfClass:[RedxMASConstraint class]], @"RedxMASConstraint is an abstract class, you should not instantiate it directly.");
	return [super init];
}
#pragma mark - NSLayoutRelation proxies
- (RedxMASConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}
- (RedxMASConstraint * (^)(id))mas_equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}
- (RedxMASConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}
- (RedxMASConstraint * (^)(id))mas_greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}
- (RedxMASConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}
- (RedxMASConstraint * (^)(id))mas_lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}
#pragma mark - MASLayoutPriority proxies
- (RedxMASConstraint * (^)())priorityLow {
    return ^id{
        self.priority(MASLayoutPriorityDefaultLow);
        return self;
    };
}
- (RedxMASConstraint * (^)())priorityMedium {
    return ^id{
        self.priority(MASLayoutPriorityDefaultMedium);
        return self;
    };
}
- (RedxMASConstraint * (^)())priorityHigh {
    return ^id{
        self.priority(MASLayoutPriorityDefaultHigh);
        return self;
    };
}
#pragma mark - NSLayoutConstraint constant proxies
- (RedxMASConstraint * (^)(MASEdgeInsets))insets {
    return ^id(MASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}
- (RedxMASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}
- (RedxMASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}
- (RedxMASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}
- (RedxMASConstraint * (^)(NSValue *value))valueOffset {
    return ^id(NSValue *offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}
- (RedxMASConstraint * (^)(id offset))mas_offset {
    return nil;
}
#pragma mark - NSLayoutConstraint constant setter
- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(MASEdgeInsets)) == 0) {
        MASEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}
#pragma mark - Semantic properties
- (RedxMASConstraint *)with {
    return self;
}
- (RedxMASConstraint *)and {
    return self;
}
#pragma mark - Chaining
- (RedxMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute __unused)layoutAttribute {
    MASMethodNotImplemented();
}
- (RedxMASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}
- (RedxMASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}
- (RedxMASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}
- (RedxMASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}
- (RedxMASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}
- (RedxMASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}
- (RedxMASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}
- (RedxMASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}
- (RedxMASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}
- (RedxMASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}
- (RedxMASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}
#if TARGET_OS_IPHONE || TARGET_OS_TV
- (RedxMASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}
- (RedxMASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}
- (RedxMASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}
- (RedxMASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}
- (RedxMASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}
- (RedxMASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}
- (RedxMASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}
- (RedxMASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}
#endif
#pragma mark - Abstract
- (RedxMASConstraint * (^)(CGFloat multiplier))multipliedBy { MASMethodNotImplemented(); }
- (RedxMASConstraint * (^)(CGFloat divider))dividedBy { MASMethodNotImplemented(); }
- (RedxMASConstraint * (^)(MASLayoutPriority priority))priority { MASMethodNotImplemented(); }
- (RedxMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation { MASMethodNotImplemented(); }
- (RedxMASConstraint * (^)(id key))key { MASMethodNotImplemented(); }
- (void)setInsets:(MASEdgeInsets __unused)insets { MASMethodNotImplemented(); }
- (void)setSizeOffset:(CGSize __unused)sizeOffset { MASMethodNotImplemented(); }
- (void)setCenterOffset:(CGPoint __unused)centerOffset { MASMethodNotImplemented(); }
- (void)setOffset:(CGFloat __unused)offset { MASMethodNotImplemented(); }
#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
- (RedxMASConstraint *)animator { MASMethodNotImplemented(); }
#endif
- (void)activate { MASMethodNotImplemented(); }
- (void)deactivate { MASMethodNotImplemented(); }
- (void)install { MASMethodNotImplemented(); }
- (void)uninstall { MASMethodNotImplemented(); }
@end
