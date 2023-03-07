#import "RedxMASCompositeConstraint.h"
#import "MASConstraint+Private.h"
@interface RedxMASCompositeConstraint () <RedxMASConstraintDelegate>
@property (nonatomic, strong) id mas_key;
@property (nonatomic, strong) NSMutableArray *childConstraints;
@end
@implementation RedxMASCompositeConstraint
- (id)initWithChildren:(NSArray *)children {
    self = [super init];
    if (!self) return nil;
    _childConstraints = [children mutableCopy];
    for (RedxMASConstraint *constraint in _childConstraints) {
        constraint.delegate = self;
    }
    return self;
}
#pragma mark - RedxMASConstraintDelegate
- (void)constraint:(RedxMASConstraint *)constraint shouldBeReplacedWithConstraint:(RedxMASConstraint *)replacementConstraint {
    NSUInteger index = [self.childConstraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.childConstraints replaceObjectAtIndex:index withObject:replacementConstraint];
}
- (RedxMASConstraint *)constraint:(RedxMASConstraint __unused *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    id<RedxMASConstraintDelegate> strongDelegate = self.delegate;
    RedxMASConstraint *newConstraint = [strongDelegate constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    newConstraint.delegate = self;
    [self.childConstraints addObject:newConstraint];
    return newConstraint;
}
#pragma mark - NSLayoutConstraint multiplier proxies 
- (RedxMASConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (RedxMASConstraint *constraint in self.childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}
- (RedxMASConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        for (RedxMASConstraint *constraint in self.childConstraints) {
            constraint.dividedBy(divider);
        }
        return self;
    };
}
#pragma mark - MASLayoutPriority proxy
- (RedxMASConstraint * (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        for (RedxMASConstraint *constraint in self.childConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}
#pragma mark - NSLayoutRelation proxy
- (RedxMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attr, NSLayoutRelation relation) {
        for (RedxMASConstraint *constraint in self.childConstraints.copy) {
            constraint.equalToWithRelation(attr, relation);
        }
        return self;
    };
}
#pragma mark - attribute chaining
- (RedxMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    [self constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    return self;
}
#pragma mark - Animator proxy
#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
- (RedxMASConstraint *)animator {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        [constraint animator];
    }
    return self;
}
#endif
#pragma mark - debug helpers
- (RedxMASConstraint * (^)(id))key {
    return ^id(id key) {
        self.mas_key = key;
        int i = 0;
        for (RedxMASConstraint *constraint in self.childConstraints) {
            constraint.key([NSString stringWithFormat:@"%@[%d]", key, i++]);
        }
        return self;
    };
}
#pragma mark - NSLayoutConstraint constant setters
- (void)setInsets:(MASEdgeInsets)insets {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        constraint.insets = insets;
    }
}
- (void)setOffset:(CGFloat)offset {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        constraint.offset = offset;
    }
}
- (void)setSizeOffset:(CGSize)sizeOffset {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        constraint.sizeOffset = sizeOffset;
    }
}
- (void)setCenterOffset:(CGPoint)centerOffset {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        constraint.centerOffset = centerOffset;
    }
}
#pragma mark - RedxMASConstraint
- (void)activate {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        [constraint activate];
    }
}
- (void)deactivate {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        [constraint deactivate];
    }
}
- (void)install {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}
- (void)uninstall {
    for (RedxMASConstraint *constraint in self.childConstraints) {
        [constraint uninstall];
    }
}
@end
