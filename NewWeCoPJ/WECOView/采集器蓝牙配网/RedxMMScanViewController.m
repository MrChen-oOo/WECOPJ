#import "RedxMMScanViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>
//#import "RedxuseToWifiView1.h"
//#import "RedxquickRegister2ViewController.h"
//#import "RedxtoolFirstView.h"
#import "RedxdataloggerShowViewController.h"
#import "RedxNewAddCollector22VC.h"


@interface RedxMMScanViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVCaptureMetadataOutputObjectsDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) RedxMMScanView *scanRectView;
@property (strong, nonatomic) AVCaptureDevice            *device;
@property (strong, nonatomic) AVCaptureDeviceInput       *input;
@property (strong, nonatomic) AVCaptureMetadataOutput    *output;
@property (strong, nonatomic) AVCaptureSession           *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic) CGRect scanRect;
@property (nonatomic, strong) UIButton *scanTypeQrBtn; 
@property (nonatomic, strong) UIButton *scanTypeBarBtn; 
@property (nonatomic, copy) void (^scanFinish)(NSString *, NSError *);
@property (nonatomic, assign) MMScanType scanType;
@property(nonatomic,assign) BOOL isFirstLogin;
@end
@implementation RedxMMScanViewController
{
    NSString *appName;
    BOOL delayQRAction;
    BOOL delayBarAction;
}
- (instancetype)initWithQrType:(MMScanType)type onFinish:(void (^)(NSString *result, NSError *error))finish {
    self = [super init];
    if (self) {
        self.scanType = type;
        self.scanFinish = finish;
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    [self.navigationController.navigationBar setTintColor:COLOR(51, 51, 51, 1)];
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName :COLOR(51, 51, 51, 1)}];
    //    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Scan";
    delayQRAction = NO;
    delayBarAction = NO;
    self.view.backgroundColor = [UIColor blackColor];
    //    appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    //    if (appName == nil || appName.length == 0) {
    //        appName = @"Redx";
    //    }
    _isFirstLogin=YES;
    [self initScanDevide];
    [self drawScanView];
    [self initScanType];
    //    [self setNavItem:self.scanType];
    [self drawBottomItems];
    if (_isDataloggerView) {
        [self initTheShowDataloggerView];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_scanBarType==1) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"theToolPasswordOpenEnable"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (!_isFirstLogin) {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.session) [self.session startRunning];
        
    });
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isFirstLogin=NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.session) [self.session stopRunning];
    });
}
- (void)initScanDevide {
    if ([self isAvailableCamera]) {
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        self.output = [[AVCaptureMetadataOutput alloc] init];
        [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        self.session = [[AVCaptureSession alloc] init];
        [self.session setSessionPreset:AVCaptureSessionPresetInputPriority];
        if ([self.session canAddInput:self.input]) [self.session addInput:self.input];
        if ([self.session canAddOutput:self.output]) [self.session addOutput:self.output];
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                            AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                            AVMetadataObjectTypeCode128Code];
        self.output.rectOfInterest = _scanRect;
        self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.preview.frame = [UIScreen mainScreen].bounds;
        [self.view.layer insertSublayer:self.preview atIndex:0];
    }
}
- (void)initScanType{
    if (self.scanType == MMScanTypeAll) {
        _scanRect = CGRectFromString([self scanRectWithScale:1][0]);
        self.output.rectOfInterest = _scanRect;
    } else if (self.scanType == MMScanTypeQrCode) {
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                            AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                            AVMetadataObjectTypeCode128Code];
        self.title = @"二维码";
        _scanRect = CGRectFromString([self scanRectWithScale:1][0]);
        self.output.rectOfInterest = _scanRect;
        _tipTitle.text = @"将取景框对准二维码,即可自动扫描";
        _tipTitle.center = CGPointMake(self.view.center.x, self.view.center.y + CGSizeFromString([self scanRectWithScale:1][1]).height/2 + 25);
    } else if (self.scanType == MMScanTypeBarCode) {
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                            AVMetadataObjectTypeCode128Code];
        self.title = @"条码";
        _scanRect = CGRectFromString([self scanRectWithScale:3][0]);
        self.output.rectOfInterest = _scanRect;
        [self.scanRectView setScanType: MMScanTypeBarCode];
        _tipTitle.text = @"将取景框对准条码,即可自动扫描";
        _tipTitle.center = CGPointMake(self.view.center.x, self.view.center.y + CGSizeFromString([self scanRectWithScale:3][1]).height/2 + 25);
    }
}
- (NSArray *)scanRectWithScale:(NSInteger)scale {
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    CGFloat Left = 60 / scale;
    CGSize scanSize = CGSizeMake(self.view.frame.size.width - Left * 2, (self.view.frame.size.width - Left * 2) / scale);
    CGRect scanRect = CGRectMake((windowSize.width-scanSize.width)/2, (windowSize.height-scanSize.height)/2, scanSize.width, scanSize.height);
    scanRect = CGRectMake(scanRect.origin.y/windowSize.height, scanRect.origin.x/windowSize.width, scanRect.size.height/windowSize.height,scanRect.size.width/windowSize.width);
    return @[NSStringFromCGRect(scanRect), NSStringFromCGSize(scanSize)];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ( (metadataObjects.count==0) )
    {
        [self showError:@"图片中未识别到二维码"];
        return;
    }
    if (metadataObjects.count>0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.session stopRunning];
            AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
            [self renderUrlStr:metadataObject.stringValue];
        });
    }
}
- (void)renderUrlStr:(NSString *)url {
    
    
    
    if (self.scanFinish) {
        RedxNewAddCollector22VC *addvc = [[RedxNewAddCollector22VC alloc]init];
        addvc.SNStr = url;
        addvc.stationId = _PlantID;
        [self.navigationController pushViewController:addvc animated:YES];
        
        //        if (self.navigationController &&[self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        //            [self.navigationController popViewControllerAnimated:NO];
        //            self.scanFinish(url, nil);
        //        }
    }
}
- (void)drawScanView {
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight-150*HEIGHT_SIZE-kNavBarHeight);
    _scanRectView = [[RedxMMScanView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height) style:@""];
    [_scanRectView setScanType:self.scanType];
    [self.view addSubview:_scanRectView];
}
- (void)drawTitle
{
    if (!_tipTitle)
    {
        self.tipTitle = [[UILabel alloc]init];
        _tipTitle.bounds = CGRectMake(0, 0, 300, 50);
        _tipTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, self.view.center.y + self.view.frame.size.width/2 - 35);
        _tipTitle.font = [UIFont systemFontOfSize:13];
        _tipTitle.textAlignment = NSTextAlignmentCenter;
        _tipTitle.numberOfLines = 0;
        _tipTitle.text = @"将取景框对准二维码,即可自动扫描";
        _tipTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_tipTitle];
    }
    _tipTitle.layer.zPosition = 1;
    [self.view bringSubviewToFront:_tipTitle];
}
- (void)initTheShowDataloggerView{
    //    float Y1=15*HEIGHT_SIZE;
    //    float lableH=20*HEIGHT_SIZE;
    //    UILabel *alertLable=[self goToInitLable:CGRectMake(5*NOW_SIZE, Y1, ScreenWidth-10*NOW_SIZE, lableH) textName:root_datalogger_alert_671 textColor:[UIColor whiteColor] fontFloat:12.f AlignmentType:3 isAdjust:YES];
    //     [self.view addSubview:alertLable];
    //     float buttonH=30*HEIGHT_SIZE;
    //    float buttonImgH=20*HEIGHT_SIZE; float buttonImgW=buttonImgH;
    //      float K=buttonH*0.5;  float K2=5;
    //       CGSize size11 = [root_shiyitu_672 boundingRectWithSize:CGSizeMake(MAXFLOAT, buttonH) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12.f] forKey:NSFontAttributeName] context:nil].size;
    //     float buttonW=K+buttonImgW+K2+size11.width+K;
    //    if (buttonW>ScreenWidth) {
    //        buttonW=ScreenWidth;
    //    }
    //    UIButton *Btn=[self goToInitButton:CGRectMake((ScreenWidth-buttonW)*0.5, Y1+lableH+10, buttonW, buttonH) selectedImage:[UIImage imageNamed:@"shiyitu"] normalImage:[UIImage imageNamed:@"shiyitu"]];
    //    Btn.backgroundColor =COLOR(146, 143, 136, 1);
    //    [Btn setTitle:root_shiyitu_672 forState:UIControlStateNormal];
    //    Btn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    //    Btn.layer.cornerRadius = buttonH*0.5;
    //    Btn.tag=100;
    //    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    Btn.titleLabel.adjustsFontSizeToFitWidth=YES;
    //    [Btn addTarget:self action:@selector(goToDataloggerShowView) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:Btn];
}
- (void)goToDataloggerShowView{
    RedxdataloggerShowViewController *registerRoot=[[RedxdataloggerShowViewController alloc]init];
    registerRoot.title=root_shiyitu_672;
    [self.navigationController pushViewController:registerRoot animated:YES];
}
-(UILabel*)goToInitLable:(CGRect)lableFrame textName:(NSString*)textString textColor:(UIColor*)textColor fontFloat:(float)fontFloat AlignmentType:(int)AlignmentType isAdjust:(BOOL)isAdjust{
    UILabel *label= [[UILabel alloc] initWithFrame:lableFrame];
    label.text=textString;
    label.textColor=textColor;
    label.font = [UIFont systemFontOfSize:fontFloat];
    if (AlignmentType==1) {
        label.textAlignment = NSTextAlignmentLeft;
    }else if (AlignmentType==2) {
        label.textAlignment = NSTextAlignmentRight;
    }else{
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.adjustsFontSizeToFitWidth=isAdjust;
    return label;
}
-(UIButton*)goToInitButton:(CGRect)buttonFrame selectedImage:(UIImage*)selectedImage normalImage:(UIImage*)normalImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=buttonFrame;
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    return button;
}
- (void)drawBottomItems
{
    if (_toolsView) {
        return;
    }
    if(_scanTypeQrBtn){
        
        [_scanTypeQrBtn removeFromSuperview];
    }
    
    self.scanTypeQrBtn = [[UIButton alloc]init];
    _scanTypeQrBtn.frame = CGRectMake(kScreenWidth/2-15*HEIGHT_SIZE, CGRectGetMaxY(_scanRectView.frame)-10*HEIGHT_SIZE-40*HEIGHT_SIZE-20*HEIGHT_SIZE, 30*HEIGHT_SIZE,40*HEIGHT_SIZE);
    [_scanTypeQrBtn setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [_scanTypeQrBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scanTypeQrBtn setImage:IMAGE(@"DianTongOff") forState:UIControlStateNormal];
    [_scanTypeQrBtn setImage:IMAGE(@"DianTongOn") forState:UIControlStateSelected];
    [_scanTypeQrBtn setSelected:NO];
    [_scanTypeQrBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_scanTypeQrBtn];
    
    
    self.toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-170*HEIGHT_SIZE,
                                                             kScreenWidth,190*HEIGHT_SIZE)];
    _toolsView.layer.cornerRadius = 20*HEIGHT_SIZE;
    _toolsView.layer.masksToBounds = YES;
    _toolsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_toolsView];
    
    float buttonW=50;
    CGSize size = CGSizeMake(buttonW, buttonW);
    
    
    UIImageView *tipsIMGV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-25*HEIGHT_SIZE, 10*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE)];
    tipsIMGV.image = IMAGE(@"erweima");
    [_toolsView addSubview:tipsIMGV];
    
    UILabel *scanLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(tipsIMGV.frame), kScreenWidth-20*NOW_SIZE, 20*HEIGHT_SIZE)];
    scanLB.text = @"Scan Picture";
    scanLB.textAlignment = NSTextAlignmentCenter;
    scanLB.font = FontSize(13*HEIGHT_SIZE);
    scanLB.textColor = colorblack_154;
    [_toolsView addSubview:scanLB];
    
    //    WEPhotoScan
    
    UIButton *changeButton = [[UIButton alloc]init];
    changeButton.frame = CGRectMake(10*NOW_SIZE,CGRectGetMaxY(scanLB.frame)+20*HEIGHT_SIZE,kScreenWidth/2-10*NOW_SIZE-5*NOW_SIZE, 30*HEIGHT_SIZE);
    //    [changeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [changeButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
    [changeButton setImage:[UIImage imageNamed:@"WEeditIM"] forState:UIControlStateNormal];
    [changeButton setTitle:@"Manual Input" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(ManualInput) forControlEvents:UIControlEventTouchUpInside];
    changeButton.backgroundColor = backgroundNewColor;
    changeButton.layer.cornerRadius = 8*HEIGHT_SIZE;
    changeButton.layer.masksToBounds = YES;
    [_toolsView addSubview:changeButton];
    
    UIButton *photoButton = [[UIButton alloc]init];
    photoButton.frame = CGRectMake(CGRectGetMaxX(changeButton.frame)+5*NOW_SIZE,CGRectGetMaxY(scanLB.frame)+20*HEIGHT_SIZE,kScreenWidth/2-10*NOW_SIZE-5*NOW_SIZE, 30*HEIGHT_SIZE);
    //    [changeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [photoButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
    [photoButton setImage:[UIImage imageNamed:@"WEPhotoScan"] forState:UIControlStateNormal];
    [photoButton setTitle:@"Photo Album" forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    photoButton.backgroundColor = backgroundNewColor;
    photoButton.layer.cornerRadius = 8*HEIGHT_SIZE;
    photoButton.layer.masksToBounds = YES;
    [_toolsView addSubview:photoButton];
}
- (void)setNavItem:(MMScanType)type {
    //    if(type == MMScanTypeBarCode) {
    //        [self.navigationItem setRightBarButtonItem:nil];
    //    } else {
    //        if (_scanBarType==1) {
    //            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:root_MAX_504 style:UIBarButtonItemStylePlain target:self action:@selector(goToUsbTool)];
    //            [self.navigationItem setRightBarButtonItem:rightItem];
    //        }
    //        if (_scanBarType==2) {
    //            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:root_tiaoguo style:UIBarButtonItemStylePlain target:self action:@selector(goToUsbTool2)];
    //            [self.navigationItem setRightBarButtonItem:rightItem];
    //        }
    //    }
}

- (void)ManualInput{
    
    RedxNewAddCollector22VC *addvc = [[RedxNewAddCollector22VC alloc]init];
    addvc.stationId = _PlantID;
    [self.navigationController pushViewController:addvc animated:YES];
}

-(void)goToUsbTool{
    //        RedxtoolFirstView *rootView = [[RedxtoolFirstView alloc]init];
    //        if(_isOSS){
    //         rootView.isOSS=YES;
    //        }
    //    [self.navigationController pushViewController:rootView animated:YES];
}
-(void)goToUsbTool2{
    //    RedxquickRegister2ViewController *rootView = [[RedxquickRegister2ViewController alloc]init];
    //    [self.navigationController pushViewController:rootView animated:YES];
}
#pragma mark -底部功能项事件
- (void)changeButton:(UIButton *)button{
    if (delayQRAction) return;
    if (delayBarAction) return;
    button.selected = !button.selected;
    if (button.selected) {
        [self barBtnClicked];
    }else{
        [self qrBtnClicked];
    }
}
- (void)qrBtnClicked{
    if (delayQRAction) return;
    [_scanTypeBarBtn setSelected:NO];
    [self changeScanCodeType:MMScanTypeQrCode];
    delayQRAction = YES;
    [self performTaskWithTimeInterval:3.0f action:^{
        delayQRAction = NO;
    }];
}
- (void)barBtnClicked{
    if (delayBarAction) return;
    [_scanTypeQrBtn setSelected:NO];
    [self.scanRectView stopAnimating];
    [self changeScanCodeType:MMScanTypeBarCode];
    delayBarAction = YES;
    [self performTaskWithTimeInterval:3.0f action:^{
        delayBarAction = NO;
    }];
}
#pragma mark - 修改扫码类型 【二维码  || 条形码】
- (void)changeScanCodeType:(MMScanType)type {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.session stopRunning];
    });
    
    __weak typeof (self)weakSelf = self;
    CGSize scanSize = CGSizeFromString([self scanRectWithScale:1][1]);
    if (type == MMScanTypeBarCode) {
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                            AVMetadataObjectTypeCode128Code];
        _scanRect = CGRectFromString([weakSelf scanRectWithScale:3][0]);
        scanSize = CGSizeFromString([self scanRectWithScale:3][1]);
    } else {
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                            AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                            AVMetadataObjectTypeCode128Code];
        _scanRect = CGRectFromString([weakSelf scanRectWithScale:1][0]);
        scanSize = CGSizeFromString([self scanRectWithScale:1][1]);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.output.rectOfInterest = _scanRect;
        [weakSelf.scanRectView setScanType: type];
        _tipTitle.text = type == MMScanTypeQrCode ? @"将取景框对准二维码,即可自动扫描" : @"将取景框对准条码,即可自动扫描";
        [weakSelf.session startRunning];
    });
    [UIView animateWithDuration:0.3 animations:^{
        _tipTitle.center = CGPointMake(self.view.center.x, self.view.center.y + scanSize.height/2 + 25);
    }];
}
- (void)openPhoto
{
    if ([self isAvailablePhoto]){
        [self showProgressView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self hideProgressView];
        });
        [self openPhotoLibrary];
    }else{
        NSString *tipMessage = [NSString stringWithFormat:root_server_1271,appName];
        [self showError:tipMessage andTitle:root_server_1270];
    }
    
}
- (void)openPhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self recognizeQrCodeImage:image onFinish:^(NSString *result) {
        [self renderUrlStr:result];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 闪光灯开启与关闭
- (void)openFlash:(UIButton *)sender {
    sender.selected = !sender.selected;
    AVCaptureDevice *device =  [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash])
    {
        AVCaptureTorchMode torch = self.input.device.torchMode;
        switch (_input.device.torchMode) {
            case AVCaptureTorchModeAuto:
                break;
            case AVCaptureTorchModeOff:
                torch = AVCaptureTorchModeOn;
                break;
            case AVCaptureTorchModeOn:
                torch = AVCaptureTorchModeOff;
                break;
            default:
                break;
        }
        [_input.device lockForConfiguration:nil];
        _input.device.torchMode = torch;
        [_input.device unlockForConfiguration];
    }
}
#pragma mark - 相册与相机是否可用
- (BOOL)isAvailablePhoto
{
    PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
    if ( authorStatus == PHAuthorizationStatusDenied ) {
        return NO;
    }
    return YES;
}
- (BOOL)isAvailableCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == AVAuthorizationStatusRestricted ||
            authorizationStatus == AVAuthorizationStatusDenied) {
//            NSString *tipMessage = [NSString stringWithFormat:root_server_1269,appName];
//            [self showError:tipMessage andTitle:root_server_1268];
            
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"Camera permission required, please go to setting and enable usage." message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

            }]];
            [self presentViewController:alvc animated:YES completion:nil];
            
            return NO;
        }else{
            return  YES;
        }
    } else {
        return NO;
    }
}
#pragma mark - Error handle
- (void)showError:(NSString*)str {
    [self showError:str andTitle:@"Note"];
}
- (void)showError:(NSString*)str andTitle:(NSString *)title
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.session stopRunning];
    });
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = ({
        UIAlertAction *action = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.session startRunning];
            });
        }];
        action;
    });
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:NULL];
}
#pragma mark - 识别二维码
+ (void)recognizeQrCodeImage:(UIImage *)image onFinish:(void (^)(NSString *result))finish {
    [[[RedxMMScanViewController alloc] init] recognizeQrCodeImage:image onFinish:finish];
}
- (void)recognizeQrCodeImage:(UIImage *)image onFinish:(void (^)(NSString *result))finish {
    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 8.0 ) {
//        [self showError:@"只支持iOS8.0以上系统"];
        return;
    }
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >=1)
    {
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scanResult = feature.messageString;
        if (finish) {
            finish(scanResult);
        }
    } else {
        [self showError:@"No QR code found."];
    }
}
#pragma mark - 创建二维码/条形码
+ (UIImage*)createQRImageWithString:(NSString*)content QRSize:(CGSize)size
{
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *qrImage = qrFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
}
+ (UIImage* )createQRImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor
{
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bkColor.CGColor],
                             nil];
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
}
+ (UIImage *)createBarCodeImageWithString:(NSString *)content barSize:(CGSize)size
{
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *qrImage = filter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
}
+ (UIImage* )createBarCodeImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor
{
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    CIFilter *barFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [barFilter setValue:stringData forKey:@"inputMessage"];
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",barFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bkColor.CGColor],
                             nil];
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
}
- (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark - 延时操作器
- (void)performTaskWithTimeInterval:(NSTimeInterval)timeInterval action:(void (^)(void))action
{
    double delayInSeconds = timeInterval;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        action();
    });
}
@end
