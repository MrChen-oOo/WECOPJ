//
//  WeStationSetVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/3.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeStationSetVC.h"
#import "RedxAnotherSearchViewController.h"
#import "CGXPickerView.h"
@interface WeStationSetVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property (nonatomic, strong)UIScrollView *bgscrollv;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong)UIImageView *planimgv;
@property (nonatomic, strong)NSMutableArray *provinceArray;
@property (nonatomic, strong)NSMutableArray *cityArr;

@property (nonatomic, strong)NSData *imgData;
@property (nonatomic, strong)NSDictionary *plantDic;
@property (nonatomic, strong)UILabel *tipsLB;
@property (nonatomic, strong)NSMutableArray * timeZoneArray;
@property (nonatomic, strong)NSMutableArray * timeZoneNameArray;
@property (nonatomic, assign)BOOL isINVC;

@end

@implementation WeStationSetVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    _isINVC = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = root_Add_Plant;
    
    [self getPickerData];
    
    [self createSetUI];
    if([_EditType isEqualToString:@"1"] || !kStringIsEmpty(_plantID)){
        [self getPlantDetail];
        self.title = home_EditPlant;
        
    }
    // Do any additional setup after loading the view.
}

- (void)createSetUI{
    
    _bgscrollv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    UITapGestureRecognizer *bgclick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoardSet)];
    [_bgscrollv addGestureRecognizer:bgclick];
    [self.view addSubview:_bgscrollv];
    
    NSArray *setnameArr = @[home_StationSet1,
                            home_StationSet2,
//                            home_StationSet3,
    ];
    NSArray *ploaceArr = @[home_StaPlaco1,
                           home_StaPlaco2,
//                           home_StaPlaco3,
    ];
    _timeZoneArray=[NSMutableArray arrayWithObjects:@"0",@"0.5",@"1",@"1.5",@"2",@"2.5",@"3",@"3.5",@"4",@"4.5",@"5",@"5.5",@"6",@"6.5",@"7",@"7.5",@"8",@"8.5",@"9",@"9.5",@"10",@"10.5",@"11",@"11.5",@"12",@"12.5",@"-0.5",@"-1",@"-1.5",@"-2",@"-2.5",@"-3",@"-3.5",@"-4",@"-4.5",@"-5",@"-5.5",@"-6",@"-6.5",@"-7",@"-7.5",@"-8",@"-8.5",@"-9",@"-9.5",@"-10",@"-10.5",@"-11",@"-11.5",@"-12", nil];
    _timeZoneNameArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < _timeZoneArray.count; i++) {
        
        float onezone = [_timeZoneArray[i] floatValue];
        if(onezone >= 0){
            
            [_timeZoneNameArray addObject:[NSString stringWithFormat:@"GMT+%@",_timeZoneArray[i]]];
        }else{
            [_timeZoneNameArray addObject:[NSString stringWithFormat:@"GMT%@",_timeZoneArray[i]]];

            
        }
        
    }

    for (int i = 0; i < setnameArr.count; i ++) {
        UITextField *onetf = [[UITextField alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE+40*HEIGHT_SIZE*i, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE)];
        onetf.placeholder = ploaceArr[i];
        onetf.tag = 100+i;
        onetf.delegate = self;
        onetf.returnKeyType = UIReturnKeyDone;
        [_bgscrollv addSubview:onetf];
        
        
        
        CGSize strSize = [self getStringSize:14*HEIGHT_SIZE Wsize:150*NOW_SIZE Hsize:40*HEIGHT_SIZE stringName:setnameArr[i]];
        UIView *rigvie = [self goToInitView:CGRectMake(0, 0, strSize.width+10*NOW_SIZE, 40*HEIGHT_SIZE) backgroundColor:WhiteColor];
        
        UILabel *leftlb = [self goToInitLable:CGRectMake(0, 0, strSize.width, 40*HEIGHT_SIZE) textName:setnameArr[i] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        [rigvie addSubview:leftlb];
        onetf.leftView = rigvie;
        onetf.leftViewMode = UITextFieldViewModeAlways;
        
    }
    
    UIView *linev = [self goToInitView:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE+40*HEIGHT_SIZE*setnameArr.count+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 1*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    [_bgscrollv addSubview:linev];
    
    UILabel *adreelb = [self goToInitLable:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(linev.frame), kScreenWidth-30*NOW_SIZE, 40*HEIGHT_SIZE) textName:home_StaAddress textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [_bgscrollv addSubview:adreelb];
    
    UITextField *Nattf = [[UITextField alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(adreelb.frame)+10*HEIGHT_SIZE, (kScreenWidth-30*NOW_SIZE)/2, 40*HEIGHT_SIZE)];
//            onetf.textAlignment = NSTextAlignmentCenter;
    Nattf.backgroundColor = WhiteColor;
    Nattf.tag = 200;
    Nattf.placeholder = home_Country;
    Nattf.returnKeyType = UIReturnKeyDone;
    Nattf.delegate = self;
    Nattf.textAlignment = NSTextAlignmentCenter;
    [_bgscrollv addSubview:Nattf];
    
    if([_EditType isEqualToString:@"0"]){
        
        Nattf.text = [RedxUserInfo defaultUserInfo].country;
    }
    
    UIView *leftView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,15*HEIGHT_SIZE,40*HEIGHT_SIZE)];
    UIImageView *downimg = [self goToInitImageView:CGRectMake((15*HEIGHT_SIZE-10*HEIGHT_SIZE)/2,40*HEIGHT_SIZE/2-10*HEIGHT_SIZE/2, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE) imageString:@"wifiListdown"];
    downimg.userInteractionEnabled = YES;
    downimg.contentMode = UIViewContentModeScaleAspectFill;
//    downimg.contentMode = UIViewContentModeScaleAspectFit;

    [leftView3 addSubview:downimg];
    Nattf.rightViewMode = UITextFieldViewModeAlways;
    Nattf.rightView = leftView3;
    
    UITextField *CityTF = [[UITextField alloc]initWithFrame:CGRectMake(10*NOW_SIZE+CGRectGetMaxX(Nattf.frame), CGRectGetMaxY(adreelb.frame)+10*HEIGHT_SIZE, (kScreenWidth-30*NOW_SIZE)/2, 40*HEIGHT_SIZE)];
//            onetf.textAlignment = NSTextAlignmentCenter;
    CityTF.backgroundColor = WhiteColor;
    CityTF.tag = 201;
    CityTF.placeholder = home_StaState;
    CityTF.returnKeyType = UIReturnKeyDone;
    CityTF.delegate = self;
    CityTF.textAlignment = NSTextAlignmentCenter;
    [_bgscrollv addSubview:CityTF];
    
    UIView *leftView4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,15*HEIGHT_SIZE,40*HEIGHT_SIZE)];
    UIImageView *downimg2 = [self goToInitImageView:CGRectMake((15*HEIGHT_SIZE-10*HEIGHT_SIZE)/2,40*HEIGHT_SIZE/2-10*HEIGHT_SIZE/2, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE) imageString:@"wifiListdown"];
    downimg2.userInteractionEnabled = YES;
    downimg2.contentMode = UIViewContentModeScaleAspectFill;

    [leftView4 addSubview:downimg2];
    CityTF.rightViewMode = UITextFieldViewModeAlways;
    CityTF.rightView = leftView4;
    
    
    UITextView *detailTF = [[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(Nattf.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 80*HEIGHT_SIZE)];
//            onetf.textAlignment = NSTextAlignmentCenter;
    detailTF.backgroundColor = backgroundNewColor;
    detailTF.tag = 202;
//    detailTF.placeholder = @"Enter the plant detail address";
//    detailTF.returnKeyType = UIReturnKeyDone;
    detailTF.delegate = self;
    detailTF.layer.cornerRadius = 8*HEIGHT_SIZE;
    detailTF.font = FontSize(16*HEIGHT_SIZE);
    detailTF.layer.masksToBounds = YES;
    
    [_bgscrollv addSubview:detailTF];
    
    UILabel *TVtipslb = [self goToInitLable:CGRectMake(10*NOW_SIZE,5*HEIGHT_SIZE, detailTF.xmg_width-20*NOW_SIZE, 40*HEIGHT_SIZE) textName:home_DetailAddress textColor:colorblack_186 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [detailTF addSubview:TVtipslb];
    _tipsLB = TVtipslb;
    
//    UIView *leftView5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,40*HEIGHT_SIZE,40*HEIGHT_SIZE)];
    
    
//    UIButton *closeBtn = [self goToInitButton:CGRectMake(5*HEIGHT_SIZE, 5*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) TypeNum:1 fontSize:15*HEIGHT_SIZE titleString:@"X" selImgString:@"" norImgString:@""];
//    [closeBtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
//    [closeBtn addTarget:self action:@selector(closeAddress) forControlEvents:UIControlEventTouchUpInside];
//
//    [leftView5 addSubview:closeBtn];
//    detailTF.rightViewMode = UITextFieldViewModeAlways;
//    detailTF.rightView = leftView5;
    
    
    UIView *linev2 = [self goToInitView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(detailTF.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 1*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    [_bgscrollv addSubview:linev2];
    
    CGSize strSize22 = [self getStringSize:14*HEIGHT_SIZE Wsize:150*NOW_SIZE Hsize:40*HEIGHT_SIZE stringName:home_FoundRevenge];

    UILabel *Foundlb = [self goToInitLable:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(linev2.frame)+10*HEIGHT_SIZE, strSize22.width+10*NOW_SIZE, 40*HEIGHT_SIZE) textName:home_FoundRevenge textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [_bgscrollv addSubview:Foundlb];
    
    
    UITextField *dollarTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-10*NOW_SIZE-15*HEIGHT_SIZE-80*NOW_SIZE, CGRectGetMaxY(linev2.frame)+10*HEIGHT_SIZE, 80*NOW_SIZE+15*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
//            onetf.textAlignment = NSTextAlignmentCenter;
    dollarTF.backgroundColor = WhiteColor;
    dollarTF.tag = 203;
    dollarTF.text = @"USD";
    dollarTF.returnKeyType = UIReturnKeyDone;
    dollarTF.delegate = self;
    dollarTF.textAlignment = NSTextAlignmentCenter;
    [_bgscrollv addSubview:dollarTF];
    
    UIView *leftView6 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,15*HEIGHT_SIZE,40*HEIGHT_SIZE)];
    UIImageView *downimg4 = [self goToInitImageView:CGRectMake((15*HEIGHT_SIZE-10*HEIGHT_SIZE)/2,40*HEIGHT_SIZE/2-10*HEIGHT_SIZE/2, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE) imageString:@"wifiListdown"];
    downimg4.userInteractionEnabled = YES;
    downimg4.contentMode = UIViewContentModeScaleAspectFit;

    [leftView6 addSubview:downimg4];
    dollarTF.rightViewMode = UITextFieldViewModeAlways;
    dollarTF.rightView = leftView6;
    
    //时区
    UILabel *zonelb = [self goToInitLable:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(Foundlb.frame), strSize22.width+10*NOW_SIZE, 40*HEIGHT_SIZE) textName:home_Statimezong textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [_bgscrollv addSubview:zonelb];
    
    
    UITextField *zoneTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-10*NOW_SIZE-15*HEIGHT_SIZE-80*NOW_SIZE, CGRectGetMaxY(Foundlb.frame), 80*NOW_SIZE+15*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
//            onetf.textAlignment = NSTextAlignmentCenter;
    zoneTF.backgroundColor = WhiteColor;
    zoneTF.tag = 204;
    zoneTF.text = @"8";
    zoneTF.returnKeyType = UIReturnKeyDone;
    zoneTF.delegate = self;
    zoneTF.textAlignment = NSTextAlignmentCenter;
    [_bgscrollv addSubview:zoneTF];
    NSString *zoneStr = [RedxUserInfo defaultUserInfo].timezone;
    if(!kStringIsEmpty(zoneStr)){
        
        zoneTF.text = zoneStr;

    }
    
    UIView *leftView10 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,15*HEIGHT_SIZE,40*HEIGHT_SIZE)];
    UIImageView *downimg10 = [self goToInitImageView:CGRectMake((15*HEIGHT_SIZE-10*HEIGHT_SIZE)/2,40*HEIGHT_SIZE/2-10*HEIGHT_SIZE/2, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE) imageString:@"wifiListdown"];
    downimg10.userInteractionEnabled = YES;
    downimg10.contentMode = UIViewContentModeScaleAspectFit;

    [leftView10 addSubview:downimg10];
    zoneTF.rightViewMode = UITextFieldViewModeAlways;
    zoneTF.rightView = leftView10;
    
    
    
    CGSize strSize33 = [self getStringSize:14*HEIGHT_SIZE Wsize:150*NOW_SIZE Hsize:40*HEIGHT_SIZE stringName:home_StaPicture];

    UILabel *Picturelb = [self goToInitLable:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(zonelb.frame), strSize33.width+10*NOW_SIZE, 40*HEIGHT_SIZE) textName:home_StaPicture textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [_bgscrollv addSubview:Picturelb];
    
    UIButton *upBtn = [self goToInitButton:CGRectMake(kScreenWidth-10*NOW_SIZE-90*NOW_SIZE, CGRectGetMaxY(zonelb.frame), 90*NOW_SIZE, 40*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:home_StaUploadPicture selImgString:@"" norImgString:@""];
    [upBtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
    upBtn.backgroundColor = backgroundNewColor;
    upBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_bgscrollv addSubview:upBtn];
    [upBtn addTarget:self action:@selector(upPictureClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *planimgv = [self goToInitImageView:CGRectMake(kScreenWidth/2-50*HEIGHT_SIZE, CGRectGetMaxY(Picturelb.frame)+10*HEIGHT_SIZE, 100*HEIGHT_SIZE, 100*HEIGHT_SIZE) imageString:@""];
    planimgv.layer.cornerRadius = 10*HEIGHT_SIZE;
    planimgv.layer.masksToBounds = YES;
    [_bgscrollv addSubview:planimgv];
    _planimgv = planimgv;
    
    UIButton *saveBtn = [self goToInitButton:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(planimgv.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:root_baocun selImgString:@"" norImgString:@""];
    saveBtn.backgroundColor = buttonColor;
    saveBtn.layer.cornerRadius = 10*HEIGHT_SIZE;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgscrollv addSubview:saveBtn];
    
    if([_EditType isEqualToString:@"1"]){
        
        UIButton *detleBtn = [self goToInitButton:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(saveBtn.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:home_Delete selImgString:@"" norImgString:@""];
      
        detleBtn.backgroundColor = WhiteColor;
        detleBtn.layer.cornerRadius = 10*HEIGHT_SIZE;
        detleBtn.layer.masksToBounds = YES;
        detleBtn.layer.borderColor = buttonColor.CGColor;
        detleBtn.layer.borderWidth = 1*HEIGHT_SIZE;
        [detleBtn setTitleColor:buttonColor forState:UIControlStateNormal];
        [detleBtn addTarget:self action:@selector(deteleClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgscrollv addSubview:detleBtn];
    }
    
    
    _bgscrollv.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(saveBtn.frame)+240*HEIGHT_SIZE);
    
}

//- (void)closeAddress{
//
//    UITextField *detailTF = [_bgscrollv viewWithTag:202];
//    detailTF.text = @"";
//
//}

- (void)upPictureClick{
    
    [self pickUpImage];
}

- (void)deteleClick{
    
    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@?",root_oss_523_ShanChuDianZhan] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
    [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deletePlant];

    }]];
    [self presentViewController:alvc animated:YES completion:nil];
}
//
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    _tipsLB.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if(textView.text.length == 0){
        
        _tipsLB.hidden = NO;
    }
}
- (void)textFieldDidChangeSelection:(UITextField *)textField{
    
    if(textField.tag == 100){
        
        if(textField.text.length > 25){
            
            [self showToastViewWithTitle:@"Up to 25 characters can be entered"];
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 25)];
            return;
        }
    }
}
//
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_bgscrollv endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //选择日期
    if(textField.tag == 101){
        [self.view endEditing:YES];

        [CGXPickerView showDatePickerWithTitle:root_xuanzeshijian DateType:UIDatePickerModeDate DefaultSelValue:textField.text MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            textField.text = selectValue;
            
        }];
        
        return NO;
    }
    
    
    //nation
    if(textField.tag == 200){
        [self.view endEditing:YES];
        if(_provinceArray.count > 0){
            
            if(!_isINVC){
                _isINVC = YES;
                
                RedxAnotherSearchViewController *another = [RedxAnotherSearchViewController new];
                [another didSelectedItem:^(NSString *item) {
                    textField.text = item;
                    [self.cityArr removeAllObjects];
                    UITextField *citytf = [self.view viewWithTag:201];
                    citytf.text = @"";
                    
                }];
                another.title =root_xuanzhe_country;
                another.dataSource=_provinceArray;
                [self.navigationController pushViewController:another animated:YES];
            }
            
        }else{
            
            [self getPickerData];
        }
        return NO;
    }
    //city
    if(textField.tag == 201){
        [self.view endEditing:YES];

        UITextField *countf = [self.view viewWithTag:200];
        if(countf.text.length == 0){
            
            [self showToastViewWithTitle:home_Stacountry];
            return NO;
        }
        if(_cityArr.count > 0){
            
            if(!_isINVC){
                _isINVC = YES;

                RedxAnotherSearchViewController *another = [RedxAnotherSearchViewController new];
                [another didSelectedItem:^(NSString *item) {
                    textField.text = item;
                }];
                another.title =root_xaunzechengshi;
                another.dataSource=_cityArr;
                [self.navigationController pushViewController:another animated:YES];
            }
            
            
        }else{
            [self getCityData:countf.text];

            
        }
        return NO;

    }
    //dollar
    if(textField.tag == 203){
        [self.view endEditing:YES];

        [ZJBLStoreShopTypeAlert showWithTitle:root_Plant_550 titles:@[@"USD",@"CNY",@"JPY",@"EUR",@"GBP"] selectIndex:^(NSInteger selectIndex) {
            
            
        } selectValue:^(NSString *selectValue) {
            textField.text = selectValue;

        } showCloseButton:YES];
        return NO;

    }
    //zone
    if(textField.tag == 204){
        [self.view endEditing:YES];

        [CGXPickerView showStringPickerWithTitle:root_shurushiqu DataSource:_timeZoneNameArray DefaultSelValue:textField.text IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
            
            textField.text = selectValue;
        }];
        return NO;

    }
    
    return YES;
}

- (void)saveClick{
    
    [self addPlant];
}

- (void)pickUpImage{
    
    [self showProgressView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideProgressView];

    });

    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.photoLibraryImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    _imgData = imageData;
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    [ud setObject:imageData forKey:@"userPic"];
    _planimgv.image = image;
    [self hideProgressView];

}



- (void)addPlant{
    
    UITextField *stanametf = [self.view viewWithTag:100];
    UITextField *datetf = [self.view viewWithTag:101];
    UITextField *codetf = [self.view viewWithTag:102];

    UITextField *countrytf = [self.view viewWithTag:200];
    UITextField *citytf = [self.view viewWithTag:201];
    UITextView *addresstf = [self.view viewWithTag:202];
    UITextField *incomeUnittf = [self.view viewWithTag:203];
    UITextField *zonetf = [self.view viewWithTag:204];


    
    if(stanametf.text.length == 0){
        
        [self showToastViewWithTitle:home_StaPlaco1];
        return;
    }
    if(datetf.text.length == 0){
        
        [self showToastViewWithTitle:home_StaPlaco2];
        return;
    }
    if(countrytf.text.length == 0){
        
        [self showToastViewWithTitle:home_Stacountry];
        return;
    }
//    if(citytf.text.length == 0){
//
//        [self showToastViewWithTitle:home_StaCity];
//        return;
//    }
    if(addresstf.text.length == 0){
        
        [self showToastViewWithTitle:home_StaAddresst];
        return;
    }
    if(incomeUnittf.text.length == 0){
        
        [self showToastViewWithTitle:root_xuanzehuobi];
        return;
    }
    if(zonetf.text.length == 0){
        
        [self showToastViewWithTitle:root_shurushiqu];
        return;
    }
    if(_planimgv.image == nil){
        
        [self showToastViewWithTitle:root_ME_shangchuan_tupian];

        return;
    }
    
    NSString *timezonestr = zonetf.text;
    if([timezonestr containsString:@"GMT"]){
        
        NSArray *remogmtArr = [timezonestr componentsSeparatedByString:@"GMT"];
        if(remogmtArr.count > 1){
            
            timezonestr = remogmtArr[1];
        }
    }
    
    NSDictionary *pramDic = @{@"plantName":stanametf.text,@"installationDate":datetf.text,@"country":countrytf.text,@"city":citytf.text,@"address":addresstf.text,@"incomeUnit":incomeUnittf.text,@"timeZone":timezonestr};
    
    NSString *urlstr = @"/v1/plant/addPlant";
    if([_EditType isEqualToString:@"1"]){
        urlstr = @"/v1/plant/editPlant";
        pramDic = @{@"plantName":stanametf.text,@"installationDate":datetf.text,@"country":countrytf.text,@"city":citytf.text,@"address":addresstf.text,@"incomeUnit":incomeUnittf.text,@"plantId":_plantID,@"timeZone":timezonestr};
    }
    
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    if (_planimgv.image) {
        NSData *imageData = UIImageJPEGRepresentation(_planimgv.image, 0.5);
        [dataImageDict setObject:imageData forKey:@"plantImg"];
    }
  
    [self showProgressView];//_deviceNetDic
    
    [RedxBaseRequest uplodImageWithMethod:HEAD_URL paramars:pramDic paramarsSite:urlstr dataImageDict:dataImageDict sucessBlock:^(id content) {
        [self hideProgressView];
        NSDictionary *jsondic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *codestr = [NSString stringWithFormat:@"%@",jsondic[@"result"]];
        NSString *msg = [NSString stringWithFormat:@"%@",jsondic[@"msg"]];
        NSString *objstr = [NSString stringWithFormat:@"%@",jsondic[@"obj"]];
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",msg]];

        if ([codestr isEqualToString:@"0"]) {
           
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } failure:^(NSError *error) {
        
        [self showToastViewWithTitle:root_MAX_368];
        
        [self hideProgressView];
    }];
    

}


//获取的国家
- (void)getPickerData{
    
    _provinceArray=[NSMutableArray array];
    [self showProgressView];//@"admin":@"admin"
    [RedxBaseRequest myHttpPost:@"/v1/user/getCountryList" parameters:@{} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (datadic) {
            
            id objdic = datadic[@"obj"];
            if([objdic isKindOfClass:[NSArray class]]){
                
                NSArray *dataArr= (NSArray *)datadic[@"obj"];//[NSArray arrayWithArray:content];
                if (dataArr.count>0) {
                    
                    NSArray *countrysArr = dataArr;
                    for (int i=0; i<countrysArr.count; i++) {
                        NSString *DY=[NSString stringWithFormat:@"%@",countrysArr[i]];
                        [ _provinceArray addObject:DY];
                    }
                    [_provinceArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                        NSString *str1=(NSString *)obj1;
                        NSString *str2=(NSString *)obj2;
                        return [str1 compare:str2];
                    }];
    //                [self.provinceArray insertObject:@"*Australia*" atIndex:0];
    //                [self.provinceArray insertObject:@"*中国*" atIndex:0];
                    
                }
            }
            
            
        }


    } failure:^(NSError *error) {
        [self hideProgressView];
    
    }];
}
//获取的国家城市
- (void)getCityData:(NSString *)cityStr{
    
    _cityArr=[NSMutableArray array];
    [self showProgressView];//@"admin":@"admin"
    [RedxBaseRequest myHttpPost:@"/v1/user/getCountryCityList" parameters:@{@"country":cityStr} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (datadic) {
            
            id objdic = datadic[@"obj"];
            if([objdic isKindOfClass:[NSArray class]]){
                NSArray *dataArr= (NSArray *)objdic;//[NSArray arrayWithArray:content];
                if (dataArr.count>0) {
                    NSArray *countrysArr = dataArr;
                    for (int i=0; i<countrysArr.count; i++) {
                        NSDictionary *onedic = countrysArr[i];
                        NSString *DY=[NSString stringWithFormat:@"%@",onedic[@"city"]];
                        [ _cityArr addObject:DY];
                    }
                    [_cityArr sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                        NSString *str1=(NSString *)obj1;
                        NSString *str2=(NSString *)obj2;
                        return [str1 compare:str2];
                    }];
                    
                    
                    RedxAnotherSearchViewController *another = [RedxAnotherSearchViewController new];
                    [another didSelectedItem:^(NSString *item) {
                        
                        UITextField *cityTF = [self.view viewWithTag:201];
                        cityTF.text = item;
                    }];
                    another.title =root_xaunzechengshi;
                    another.dataSource=_cityArr;
                    [self.navigationController pushViewController:another animated:YES];
                    
    //                [self.provinceArray insertObject:@"*Australia*" atIndex:0];
    //                [self.provinceArray insertObject:@"*中国*" atIndex:0];
                    
                }
            }
            
            
        }


    } failure:^(NSError *error) {
        [self hideProgressView];
    
    }];
}


//获取电站详情
- (void)getPlantDetail{
    
    _plantDic = [[NSDictionary alloc]init];
    [self showProgressView];//@"admin":@"admin"
    [RedxBaseRequest myHttpPost:@"/v1/plant/getPlantInfo" parameters:@{@"plantId":_plantID} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (datadic) {
            NSString *codestr = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            id objData= datadic[@"obj"];//[NSArray arrayWithArray:content];

            if([codestr isEqualToString:@"0"]){
                
                if([objData isKindOfClass:[NSDictionary class]]){
                    
                    NSDictionary *onedic = (NSDictionary *)objData;
                    self.plantDic = onedic;
                    
                    
                    UITextField *stanametf = [self.view viewWithTag:100];
                    UITextField *datetf = [self.view viewWithTag:101];
//                    UITextField *codetf = [self.view viewWithTag:102];

                    UITextField *countrytf = [self.view viewWithTag:200];
                    UITextField *citytf = [self.view viewWithTag:201];
                    UITextView *addresstf = [self.view viewWithTag:202];
                    UITextField *incomeUnittf = [self.view viewWithTag:203];
                    UITextField *timezonetf = [self.view viewWithTag:204];

                    stanametf.text = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];
                    datetf.text = [NSString stringWithFormat:@"%@",onedic[@"installationData"]];
                    countrytf.text = [NSString stringWithFormat:@"%@",onedic[@"country"]];
                    citytf.text = [NSString stringWithFormat:@"%@",onedic[@"city"]];
                    NSString *timezongStr = [NSString stringWithFormat:@"%@",onedic[@"timeZone"]];
                    if(!kStringIsEmpty(timezongStr)){
                        if([timezongStr floatValue] >= 0){
                            
                            timezonetf.text = [NSString stringWithFormat:@"GMT+%@",timezongStr];

                        }else{
                            timezonetf.text = [NSString stringWithFormat:@"GMT%@",timezongStr];

                        }

                    }
                    NSString *adressStr = [NSString stringWithFormat:@"%@",onedic[@"address"]];
                    if(!kStringIsEmpty(adressStr)){
                        addresstf.text = adressStr;
                        _tipsLB.hidden = YES;
                    }else{
                        _tipsLB.hidden = NO;
                    }
                    
                    incomeUnittf.text = [NSString stringWithFormat:@"%@",onedic[@"incomeUnit"]];
                    NSString *imgurlstr = [NSString stringWithFormat:@"%@",onedic[@"plantPicturePathText"]];

                    [_planimgv sd_setImageWithURL:[NSURL URLWithString:imgurlstr] placeholderImage:IMAGE(@"WedefaultPlantIMG")];
                    
                }
            }

            
            
        }


    } failure:^(NSError *error) {
        [self hideProgressView];
    
    }];
}

//删除电站
- (void)deletePlant{
    
    [self showProgressView];//@"admin":@"admin"
    [RedxBaseRequest myHttpPost:@"/v1/plant/delPlant" parameters:@{@"plantId":_plantID} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (datadic) {
            NSString *codestr = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msgstr = [NSString stringWithFormat:@"%@",datadic[@"msg"]];

            [self showToastViewWithTitle:msgstr];
            if([codestr isEqualToString:@"0"]){
                
                [self.navigationController popViewControllerAnimated:YES];
            }

            
            
        }


    } failure:^(NSError *error) {
        [self hideProgressView];
    
    }];
}

- (void)hideKeyBoardSet{
    
    [self.view endEditing:YES];
}
@end
