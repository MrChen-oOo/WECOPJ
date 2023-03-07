#import "RedxMASViewConstraint.h"
#import "MASConstraint+Private.h"
#import "RedxMASCompositeConstraint.h"
#import "RedxMASLayoutConstraint.h"
#import "View+MASAdditions.h"
#import <objc/runtime.h>
@interface MAS_VIEW (RedxMASConstraints)
@property (nonatomic, readonly) NSMutableSet *mas_installedConstraints;
@end
@implementation MAS_VIEW (RedxMASConstraints)
static char kInstalledConstraintsKey;
- (NSMutableSet *)mas_installedConstraints {
    NSMutableSet *constraints = objc_getAssociatedObject(self, &kInstalledConstraintsKey);
    if (!constraints) {
        constraints = [NSMutableSet set];
        objc_setAssociatedObject(self, &kInstalledConstraintsKey, constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return constraints;
}
@end
@interface RedxMASViewConstraint ()
@property (nonatomic, strong, readwrite) RedxMASViewAttribute *secondViewAttribute;
@property (nonatomic, weak) MAS_VIEW *installedView;
@property (nonatomic, weak) RedxMASLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) BOOL hasLayoutRelation;
@property (nonatomic, strong) id mas_key;
@property (nonatomic, assign) BOOL useAnimator;
@end
@implementation RedxMASViewConstraint
- (id)initWithFirstViewAttribute:(RedxMASViewAttribute *)firstViewAttribute {
    self = [super init];
    if (!self) return nil;
    _firstViewAttribute = firstViewAttribute;
    self.layoutPriority = MASLayoutPriorityRequired;
    self.layoutMultiplier = 1;
    return self;
}
#pragma mark - NSCoping
- (id)copyWithZone:(NSZone __unused *)zone {
    RedxMASViewConstraint *constraint = [[RedxMASViewConstraint alloc] initWithFirstViewAttribute:self.firstViewAttribute];
    constraint.layoutConstant = self.layoutConstant;
    constraint.layoutRelation = self.layoutRelation;
    constraint.layoutPriority = self.layoutPriority;
    constraint.layoutMultiplier = self.layoutMultiplier;
    constraint.delegate = self.delegate;
    return constraint;
}
#pragma mark - Public
+ (NSArray *)installedConstraintsForView:(MAS_VIEW *)view {
    return [view.mas_installedConstraints allObjects];
}
#pragma mark - Private
- (void)setLayoutConstant:(CGFloat)layoutConstant {
    _layoutConstant = layoutConstant;
#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
    if (self.useAnimator) {
        [self.layoutConstraint.animator setConstant:layoutConstant];
    } else {
        self.layoutConstraint.constant = layoutConstant;
    }
#else
    self.layoutConstraint.constant = layoutConstant;
#endif
}
- (void)setLayoutRelation:(NSLayoutRelation)layoutRelation {
    _layoutRelation = layoutRelation;
    self.hasLayoutRelation = YES;
}
- (BOOL)supportsActiveProperty {
    return [self.layoutConstraint respondsToSelector:@selector(isActive)];
}
- (BOOL)isActive {
    BOOL active = YES;
    if ([self supportsActiveProperty]) {
        active = [self.layoutConstraint isActive];
    }
    return active;
}
- (BOOL)hasBeenInstalled {
    return (self.layoutConstraint != nil) && [self isActive];
}
- (void)setSecondViewAttribute:(id)secondViewAttribute {
    if ([secondViewAttribute isKindOfClass:NSValue.class]) {
        [self setLayoutConstantWithValue:secondViewAttribute];
    } else if ([secondViewAttribute isKindOfClass:MAS_VIEW.class]) {
        _secondViewAttribute = [[RedxMASViewAttribute alloc] initWithView:secondViewAttribute layoutAttribute:self.firstViewAttribute.layoutAttribute];
    } else if ([secondViewAttribute isKindOfClass:RedxMASViewAttribute.class]) {
        _secondViewAttribute = secondViewAttribute;
    } else {
        NSAssert(NO, @"attempting to add unsupported attribute: %@", secondViewAttribute);
    }
}
#pragma mark - NSLayoutConstraint multiplier proxies
- (RedxMASConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        NSAssert(!self.hasBeenInstalled,
                 @"Cannot modify constraint multiplier after it has been installed");
        self.layoutMultiplier = multiplier;
        return self;
    };
}
- (RedxMASConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        NSAssert(!self.hasBeenInstalled,
                 @"Cannot modify constraint multiplier after it has been installed");
        self.layoutMultiplier = 1.0/divider;
        return self;
    };
}
#pragma mark - MASLayoutPriority proxy
- (RedxMASConstraint * (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        NSAssert(!self.hasBeenInstalled,
                 @"Cannot modify constraint priority after it has been installed");
        self.layoutPriority = priority;
        return self;
    };
}
#pragma mark - NSLayoutRelation proxy
- (RedxMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attribute, NSLayoutRelation relation) {
        if ([attribute isKindOfClass:NSArray.class]) {
            NSAssert(!self.hasLayoutRelation, @"Redefinition of constraint relation");
            NSMutableArray *children = NSMutableArray.new;
            for (id attr in attribute) {
                RedxMASViewConstraint *viewConstraint = [self copy];
                viewConstraint.secondViewAttribute = attr;
                [children addObject:viewConstraint];
            }
            RedxMASCompositeConstraint *compositeConstraint = [[RedxMASCompositeConstraint alloc] initWithChildren:children];
            compositeConstraint.delegate = self.delegate;
            [self.delegate constraint:self shouldBeReplacedWithConstraint:compositeConstraint];
            return compositeConstraint;
        } else {
            NSAssert(!self.hasLayoutRelation || self.layoutRelation == relation && [attribute isKindOfClass:NSValue.class], @"Redefinition of constraint relation");
            self.layoutRelation = relation;
            self.secondViewAttribute = attribute;
            return self;
        }
    };
}
#pragma mark - Semantic properties
- (RedxMASConstraint *)with {
    return self;
}
- (RedxMASConstraint *)and {
    return self;
}
#pragma mark - attribute chaining
- (RedxMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    NSAssert(!self.hasLayoutRelation, @"Attributes should be chained before defining the constraint relation");
    return [self.delegate constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
}
#pragma mark - Animator proxy
#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
- (RedxMASConstraint *)animator {
    self.useAnimator = YES;
    return self;
}
#endif
#pragma mark - debug helpers
- (RedxMASConstraint * (^)(id))key {
    return ^id(id key) {
        self.mas_key = key;
        return self;
    };
}
#pragma mark - NSLayoutConstraint constant setters
- (void)setInsets:(MASEdgeInsets)insets {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeLeft:
        case NSLayoutAttributeLeading:
            self.layoutConstant = insets.left;
            break;
        case NSLayoutAttributeTop:
            self.layoutConstant = insets.top;
            break;
        case NSLayoutAttributeBottom:
            self.layoutConstant = -insets.bottom;
            break;
        case NSLayoutAttributeRight:
        case NSLayoutAttributeTrailing:
            self.layoutConstant = -insets.right;
            break;
        default:
            break;
    }
}
- (void)setOffset:(CGFloat)offset {
    self.layoutConstant = offset;
}
- (void)setSizeOffset:(CGSize)sizeOffset {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeWidth:
            self.layoutConstant = sizeOffset.width;
            break;
        case NSLayoutAttributeHeight:
            self.layoutConstant = sizeOffset.height;
            break;
        default:
            break;
    }
}
- (void)setCenterOffset:(CGPoint)centerOffset {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeCenterX:
            self.layoutConstant = centerOffset.x;
            break;
        case NSLayoutAttributeCenterY:
            self.layoutConstant = centerOffset.y;
            break;
        default:
            break;
    }
}
#pragma mark - RedxMASConstraint
- (void)activate {
    if ([self supportsActiveProperty] && self.layoutConstraint) {
        if (self.hasBeenInstalled) {
            return;
        }
        self.layoutConstraint.active = YES;
        [self.firstViewAttribute.view.mas_installedConstraints addObject:self];
    } else {
        [self install];
    }
}
- (void)deactivate {
    if ([self supportsActiveProperty]) {
        self.layoutConstraint.active = NO;
        [self.firstViewAttribute.view.mas_installedConstraints removeObject:self];
    } else {
        [self uninstall];
    }
}
- (void)install {
    if (self.hasBeenInstalled) {
        return;
    }
    MAS_VIEW *firstLayoutItem = self.firstViewAttribute.item;
    NSLayoutAttribute firstLayoutAttribute = self.firstViewAttribute.layoutAttribute;
    MAS_VIEW *secondLayoutItem = self.secondViewAttribute.item;
    NSLayoutAttribute secondLayoutAttribute = self.secondViewAttribute.layoutAttribute;
    if (!self.firstViewAttribute.isSizeAttribute && !self.secondViewAttribute) {
        secondLayoutItem = self.firstViewAttribute.view.superview;
        secondLayoutAttribute = firstLayoutAttribute;
    }
    RedxMASLayoutConstraint *layoutConstraint
        = [RedxMASLayoutConstraint constraintWithItem:firstLayoutItem
                                        attribute:firstLayoutAttribute
                                        relatedBy:self.layoutRelation
                                           toItem:secondLayoutItem
                                        attribute:secondLayoutAttribute
                                       multiplier:self.layoutMultiplier
                                         constant:self.layoutConstant];
    layoutConstraint.priority = self.layoutPriority;
    layoutConstraint.mas_key = self.mas_key;
    if (self.secondViewAttribute.view) {
        MAS_VIEW *closestCommonSuperview = [self.firstViewAttribute.view mas_closestCommonSuperview:self.secondViewAttribute.view];
        NSAssert(closestCommonSuperview,
                 @"couldn't find a common superview for %@ and %@",
                 self.firstViewAttribute.view, self.secondViewAttribute.view);
        self.installedView = closestCommonSuperview;
    } else if (self.firstViewAttribute.isSizeAttribute) {
        self.installedView = self.firstViewAttribute.view;
    } else {
        self.installedView = self.firstViewAttribute.view.superview;
    }
    RedxMASLayoutConstraint *existingConstraint = nil;
    if (self.updateExisting) {
        existingConstraint = [self layoutConstraintSimilarTo:layoutConstraint];
    }
    if (existingConstraint) {
        existingConstraint.constant = layoutConstraint.constant;
        self.layoutConstraint = existingConstraint;
    } else {
        [self.installedView addConstraint:layoutConstraint];
        self.layoutConstraint = layoutConstraint;
        [firstLayoutItem.mas_installedConstraints addObject:self];
    }
}
- (RedxMASLayoutConstraint *)layoutConstraintSimilarTo:(RedxMASLayoutConstraint *)layoutConstraint {
    for (NSLayoutConstraint *existingConstraint in self.installedView.constraints.reverseObjectEnumerator) {
        if (![existingConstraint isKindOfClass:RedxMASLayoutConstraint.class]) continue;
        if (existingConstraint.firstItem != layoutConstraint.firstItem) continue;
        if (existingConstraint.secondItem != layoutConstraint.secondItem) continue;
        if (existingConstraint.firstAttribute != layoutConstraint.firstAttribute) continue;
        if (existingConstraint.secondAttribute != layoutConstraint.secondAttribute) continue;
        if (existingConstraint.relation != layoutConstraint.relation) continue;
        if (existingConstraint.multiplier != layoutConstraint.multiplier) continue;
        if (existingConstraint.priority != layoutConstraint.priority) continue;
        return (id)existingConstraint;
    }
    return nil;
}
- (void)uninstall {
    [self.installedView removeConstraint:self.layoutConstraint];
    self.layoutConstraint = nil;
    self.installedView = nil;
    [self.firstViewAttribute.view.mas_installedConstraints removeObject:self];
}
@end
