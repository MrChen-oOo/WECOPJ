#define LeftDistance 60
#import "RedxMMScanView.h"
@interface RedxMMScanView()
@property (nonatomic, assign) NSInteger heightScale;
@property (nonatomic, strong) UIImageView *lineImageView;
@end
@implementation RedxMMScanView
{
    BOOL needStop;
}
-(id)initWithFrame:(CGRect)frame style:(NSString *)style
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        _scanType = MMScanTypeQrCode;
        self.heightScale = 1;
        self.lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_blue_line" inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"resource" ofType: @"bundle"]] compatibleWithTraitCollection:nil]];
        needStop = NO;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat Left = LeftDistance / _heightScale;
    CGSize sizeRetangle = CGSizeMake(self.frame.size.width - Left * 2, self.frame.size.width - Left * 2);
    CGFloat YMinRetangle = self.frame.size.height / 2.0 - sizeRetangle.height/(2.0 * _heightScale);
    _lineImageView.frame = CGRectMake(Left, YMinRetangle + 2, sizeRetangle.width - 4, 5);
    [self addSubview:_lineImageView];
}
- (void)setScanType:(MMScanType)scanType
{
    _scanType = scanType;
    if (scanType == MMScanTypeBarCode) {
        self.heightScale = 3;
        _lineImageView.alpha = 0;
    } else {
        self.heightScale = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            needStop = NO;
            [self startAnimating];
        });
    }
    [self setNeedsDisplay];
    [self setNeedsLayout];
}
- (void)startAnimating {
    if (needStop) {
        return;
    }
    CGFloat Left = LeftDistance / _heightScale;
    CGSize sizeRetangle = CGSizeMake(self.frame.size.width - Left * 2, (self.frame.size.width - Left * 2) / _heightScale);
    CGFloat YMinRetangle = self.frame.size.height / 2.0 - sizeRetangle.height/2.0;
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
    CGRect initFrame = CGRectMake(Left, YMinRetangle + 2, sizeRetangle.width - 4, 5);
    _lineImageView.frame = initFrame;
    _lineImageView.alpha = 1;
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:1.5 animations:^{
        _lineImageView.frame = CGRectMake(initFrame.origin.x, YMaxRetangle - 2, initFrame.size.width, initFrame.size.height);
    } completion:^(BOOL finished) {
        _lineImageView.alpha = 0;
        _lineImageView.frame = initFrame;
        [weakSelf performSelector:@selector(startAnimating) withObject:nil afterDelay:0.3];
    }];
}
- (void)stopAnimating {
    needStop = YES;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawScanRect];
}
- (void)drawScanRect {
    CGFloat Left = LeftDistance / _heightScale;
    CGSize sizeRetangle = CGSizeMake(self.frame.size.width - Left * 2, self.frame.size.width - Left * 2);
    CGFloat YMinRetangle = self.frame.size.height / 2.0 - sizeRetangle.height/(2.0 * _heightScale);
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height / _heightScale;
    CGFloat XRetangleRight = self.frame.size.width - Left;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.5);
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle);
    CGContextFillRect(context, rect);
    rect = CGRectMake(0, YMinRetangle, Left, sizeRetangle.height/_heightScale);
    CGContextFillRect(context, rect);
    rect = CGRectMake(XRetangleRight, YMinRetangle, Left,sizeRetangle.height/_heightScale);
    CGContextFillRect(context, rect);
    rect = CGRectMake(0, YMaxRetangle, self.frame.size.width, self.frame.size.height - YMaxRetangle);
    CGContextFillRect(context, rect);
    CGContextStrokePath(context);
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255 green:255 blue:255 alpha:1.00].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextAddRect(context, CGRectMake(Left, YMinRetangle, sizeRetangle.width, sizeRetangle.height/_heightScale));
    CGContextStrokePath(context);
    int wAngle = 15;
    int hAngle = 15;
    CGFloat linewidthAngle = 4;
    CGFloat diffAngle = linewidthAngle/3;
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.110 green:0.659 blue:0.894 alpha:1.00].CGColor);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, linewidthAngle);
    CGFloat leftX = Left - diffAngle;
    CGFloat topY = YMinRetangle - diffAngle;
    CGFloat rightX = XRetangleRight + diffAngle;
    CGFloat bottomY = YMaxRetangle + diffAngle;
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, leftX + wAngle, topY);
    CGContextMoveToPoint(context, leftX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, topY+hAngle);
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, leftX + wAngle, bottomY);
    CGContextMoveToPoint(context, leftX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, bottomY - hAngle);
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, rightX - wAngle, topY);
    CGContextMoveToPoint(context, rightX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, topY + hAngle);
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, rightX - wAngle, bottomY);
    CGContextMoveToPoint(context, rightX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, bottomY - hAngle);
    CGContextStrokePath(context);
}
@end
