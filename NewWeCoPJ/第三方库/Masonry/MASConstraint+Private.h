#import "RedxMASConstraint.h"
@protocol RedxMASConstraintDelegate;
@interface RedxMASConstraint ()
@property (nonatomic, assign) BOOL updateExisting;
@property (nonatomic, weak) id<RedxMASConstraintDelegate> delegate;
- (void)setLayoutConstantWithValue:(NSValue *)value;
@end
@interface RedxMASConstraint (Abstract)
- (RedxMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;
- (RedxMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;
@end
@protocol RedxMASConstraintDelegate <NSObject>
- (void)constraint:(RedxMASConstraint *)constraint shouldBeReplacedWithConstraint:(RedxMASConstraint *)replacementConstraint;
- (RedxMASConstraint *)constraint:(RedxMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;
@end
