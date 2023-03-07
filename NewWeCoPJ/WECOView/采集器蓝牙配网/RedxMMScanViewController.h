#import <UIKit/UIKit.h>
#import "RedxMMScanView.h"
@interface RedxMMScanViewController : RedxRootNewViewController
@property (nonatomic, strong) UILabel *tipTitle;  
@property (nonatomic, strong) UIView *toolsView;  
@property (nonatomic, strong) UIButton *photoBtn; 
@property (nonatomic, strong) UIButton *flashBtn; 
@property (nonatomic, strong)NSString* titleString;
@property (nonatomic, assign)NSInteger scanBarType;     
    @property (nonatomic, assign) BOOL isOSS;
  @property (nonatomic, assign) BOOL isDataloggerView;
@property (nonatomic, assign) BOOL isWhiteColor; 
- (instancetype)initWithQrType:(MMScanType)type onFinish:(void (^)(NSString *result, NSError *error))finish;
+ (void)recognizeQrCodeImage:(UIImage *)image onFinish:(void (^)(NSString *result))finish;
+ (UIImage*)createQRImageWithString:(NSString*)content QRSize:(CGSize)size;
+ (UIImage* )createQRImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor;
+ (UIImage *)createBarCodeImageWithString:(NSString *)content barSize:(CGSize)size;
+ (UIImage* )createBarCodeImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor;

@property (nonatomic, strong)NSString* PlantID;

@end
