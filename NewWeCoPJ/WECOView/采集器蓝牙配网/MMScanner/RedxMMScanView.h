#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MMScanTypeQrCode,
    MMScanTypeBarCode,
    MMScanTypeAll,
} MMScanType;
@interface RedxMMScanView : UIView
-(id)initWithFrame:(CGRect)frame style:(NSString *)style;
- (void)stopAnimating;
@property (nonatomic, assign) MMScanType scanType;
@end
