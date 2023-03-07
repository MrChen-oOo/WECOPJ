//
//  langShowView.m
//  ShinePhone
//
//  Created by CBQ on 2022/4/26.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "langShowView.h"
#import "NTVLocalized.h"
@implementation langShowView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *bgclick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgclick)];
        bgclick.delegate = self;
        [self addGestureRecognizer:bgclick];
//        [self showView];
    }
    
    return self;
}
- (void)bgclick{
    
    [self removeFromSuperview];
}
- (void)showView{
//    _dataArr = @[@"默认（随系统语言）",@"中文",@"繁體中文",@"English",@"Italian",@"Polish",@"Dutch",@"German",@"Hungarian(Hungary)",@"Portuguese(Portugal)",@"Spanish",@"Korean",@"French",@"Czech"];
//    _keyArr = @[@[@""],@[@"zh-Hans"],@[@"zh-Hant"],@[@"en"],@[@"it"],@[@"pl"],@[@"nl"],@[@"de-CN"],@[@"hu"],@[@"pt"],@[@"es"],@[@"ko"],@[@"fr"],@[@"cs"]];
//    _keyArr22 = @[@"",@"zh-Hans",@"zh-Hant",@"en",@"it",@"pl",@"nl",@"de-CN",@"hu",@"pt",@"es",@"ko",@"fr",@"cs"];

    
    UITableView *tablev = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth-10*NOW_SIZE-100*NOW_SIZE, _tabvY, 100*NOW_SIZE, 4*30*HEIGHT_SIZE) style:UITableViewStylePlain];
    tablev.delegate = self;
    tablev.dataSource = self;
    [self addSubview:tablev];
    tablev.layer.cornerRadius = 10*HEIGHT_SIZE;
    tablev.layer.masksToBounds = YES;
    tablev.layer.borderWidth = 1*NOW_SIZE;
    tablev.layer.borderColor = colorblack_102.CGColor;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"langCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = FontSize(11*HEIGHT_SIZE);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    
    if (indexPath.row == 0) {

        [self resetSystemLanguage];
    }else{
        if (indexPath.row < _keyArr.count) {
            [[NSUserDefaults standardUserDefaults] setValue:_keyArr[indexPath.row] forKey:@"AppleLanguages"];
//            [[NSUserDefaults standardUserDefaults] setValue:_keyArr22[indexPath.row] forKey:@"LocalLanguageKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NTVLocalized sharedInstance] setLanguage:_keyArr22[indexPath.row]];

        }

    }
    self.selectBlock(_dataArr[indexPath.row]);
    [self removeFromSuperview];
}
/**
 重置系统语言
 */
- (void)resetSystemLanguage {
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"AppleLanguages"];
    [[NTVLocalized sharedInstance] systemLanguage];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"appLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//手机语言传给服务器
-(NSString*)getTheLaugrage{

    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *languageType = @"1";
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
    }else if([currentLanguage hasPrefix:@"ko"]) { //韩语
        languageType=@"15";
    }else if([currentLanguage hasPrefix:@"ro"]) { //罗马尼亚
        languageType=@"16";
    }
  
    return languageType;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

        if ([NSStringFromClass([touch.view class])                                                               isEqualToString:@"UITableViewCellContentView"]) {

       //判断如果点击的是tableView的cell，就把手势给关闭了

        return NO;

        //关闭手势

        }

    //否则手势存在

    return YES;

}
@end
