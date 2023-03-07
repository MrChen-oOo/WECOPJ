
#import "WeProtocolVC.h"

@interface WeProtocolVC ()<WKNavigationDelegate>
{
    NSInteger number;
}
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UITextView *detail;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WeProtocolVC
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Privacy_Policy;
    [self initUI];
}

-(void)initUI{
    
    
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - kNavBarHeight)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,0);
    [self.view addSubview:_scrollView];
    
    _title1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE, 300*NOW_SIZE,35*HEIGHT_SIZE )];
    _title1.text=Privacy_Policy;
    _title1.textAlignment=NSTextAlignmentCenter;
    _title1.textColor=COLOR(0, 0, 0, 1);
    _title1.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    [_scrollView addSubview:_title1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,15*HEIGHT_SIZE+30*HEIGHT_SIZE, 300*NOW_SIZE,1*HEIGHT_SIZE )];
    line3.backgroundColor=[UIColor grayColor];
    [_scrollView addSubview:line3];
    
    _detail=[[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,50*HEIGHT_SIZE, 300*NOW_SIZE,1200*HEIGHT_SIZE )];
    
    _detail.textAlignment=NSTextAlignmentJustified;
    _detail.textColor=COLOR(60, 60, 60, 1);
    _detail.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    _detail.editable = NO;
    [_scrollView addSubview:_detail];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    
    
    [self getContentHTML]; // 接口获取html
    
    
    _detail.text=_detailText;
}


// 从服务器请求html地址
- (void)getContentHTML{
    NSString *lang=[self getlanguages];
    
    //    [self showProgressView];
    NSString *urlstr = @"";
    //    if ([_typestr isEqualToString:@"0"]) {//协议
    urlstr = [NSString stringWithFormat:@"%@/resources/app/userterms_en.html",HEAD_URL];//@"http://47.57.12.171:8080/resources/app/userterms_en.html";
    
    NSURL *url = [NSURL URLWithString:urlstr];
    self->number = 0;
    self->_scrollView.hidden = YES;
    
    self->_webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kBottomBarHeight-NaviHeight)];
    self->_webView.navigationDelegate = self;
    self->_webView.opaque = NO;
    self->_webView.backgroundColor = [UIColor whiteColor];
    if (@available(ios 11.0, *)){
        self->_webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self->_webView];
    
    // 跳转网页
    [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.f]];
    
    
    
    
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self showProgressView];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self hideProgressView];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败");
    [self hideProgressView];
    number ++;
    if (number > 3) { // 尝试加载三次， 如果都失败则跳转回前一个页面
        [self showToastViewWithTitle:root_Networking]; // 加载超时
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self getContentHTML];
}

- (NSString *)getlanguages{
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *languageType = @"1";
    //    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
    //        languageType=@"0";
    //    }else if ([currentLanguage hasPrefix:@"en"]) {
    //        languageType=@"1";
    //    }else{
    //        languageType=@"2";
    //    }
    if ([currentLanguage hasPrefix:@"zh-Hans"]) { // 中文
        languageType=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) { // English
        languageType=@"1";
    }else if([currentLanguage hasPrefix:@"fr"]) { // Francais  法语
        languageType=@"2";
    }else if([currentLanguage hasPrefix:@"ja"]) { // 日本語
        languageType=@"3";
    }else if([currentLanguage hasPrefix:@"it"]) { // In Italiano  意大利
        languageType=@"4";
    }else if([currentLanguage hasPrefix:@"nl"]) { // Nederland  荷兰
        languageType=@"5";
    }else if([currentLanguage hasPrefix:@"tk"]) { // Turkce 土耳其
        languageType=@"6";
    }else if([currentLanguage hasPrefix:@"pl"]) { // Polish 波兰
        languageType=@"7";
    }else if([currentLanguage hasPrefix:@"el"]) { // Greek  希腊
        languageType=@"8";
    }else if([currentLanguage hasPrefix:@"de-CN"]) { // German 德语
        languageType=@"9";
    }else if([currentLanguage hasPrefix:@"pt"]) { // Portugues 葡萄牙
        languageType=@"10";
    }else if([currentLanguage hasPrefix:@"es"]) { // Spanish 西班牙
        languageType=@"11";
    }else if([currentLanguage hasPrefix:@"vi"]) { // Vietnamese 越南
        languageType=@"12";
    }else if([currentLanguage hasPrefix:@"hu"]) { // Hungarin 匈牙利
        languageType=@"13";
    }else if([currentLanguage hasPrefix:@"zh-Hant"]) { // 繁体中文
        languageType=@"14";
    }
    
    return languageType;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
