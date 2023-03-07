#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface RedxRootNewViewController : UIViewController
- (void)showToastViewWithTitle:(NSString *)title;
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle;
- (void)showProgressView;
- (void)hideProgressView;
-(UIScrollView*)goToInitScrollView:(CGRect)scrollFrame backgroundColor:(UIColor*)backgroundColor;
-(UIView*)goToInitView:(CGRect)viewFrame backgroundColor:(UIColor*)backgroundColor;
-(UILabel*)goToInitLable:(CGRect)lableFrame textName:(NSString*)textString textColor:(UIColor*)textColor fontFloat:(float)fontFloat AlignmentType:(int)AlignmentType isAdjust:(BOOL)isAdjust;
-(UIImageView*)goToInitImageView:(CGRect)imageFrame imageString:(NSString*)imageString;
-(UIButton*)goToInitButton:(CGRect)buttonFrame TypeNum:(NSInteger)TypeNum fontSize:(float)fontSize titleString:(NSString*)titleString selImgString:(NSString*)selImgString norImgString:(NSString*)norImgString;
-(UIButton*)createRadiusButtonWithFrame:(CGRect)rect titleString:(NSString *)titleString fontSize:(float)fontSize;
- (NSString *)MD5:(NSString *)str;
-(CGSize)getStringSize:(float)fontSize  Wsize:(float)Wsize Hsize:(float)Hsize stringName:(NSString*)stringName;
-(void)set_TextColorForLabel:(UILabel *)label color:(UIColor *)color range:(NSRange)range;
-(void)set_DesignatedTextForLabel:(UILabel *)label text:(NSString *)text color:(UIColor *)color;
- (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect;
-(NSString*)getValidCode:(NSString*)serialNum;
@property (nonatomic, strong)  NSString *languageType;
-(NSString*)getTheLaugrage;
@property (nonatomic, copy) void (^demoBlock)(NSInteger index, NSString* string);
@property (nonatomic, assign) CGSize shareFrameSize;
@property (nonatomic, strong)  UIView *shareView;
@property (nonatomic, strong)  UIScrollView *shareScrollView;
@property (nonatomic, assign) BOOL isShareView;   
@property (nonatomic, assign) BOOL isGoToShareTheView;
@property (nonatomic, strong) NSArray *LangNameArr;
@property (nonatomic, strong) NSArray *LangKeyArr;
@property (nonatomic, strong) NSArray *LangKey2Arr;
-(void)addRightItemForShare;
-(void)rightPressForShareFirst;
- (NSInteger)getTimeInterval:(NSString *)sendDateString;
- (void)savePageMassage:(NSString *)FreqKey TimeKey:(NSString *)timeKey;
@end
NS_ASSUME_NONNULL_END
