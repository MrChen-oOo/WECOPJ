//
//  BDCMassageCell.m
//  LocalDebug
//
//  Created by CBQ on 2021/7/12.
//

#import "BDCMassageCell.h"

@implementation BDCMassageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        
    }
    
    return self;
}
- (void)reloadBDCMessageCell{
    
    if (_bgview) {
        
        [_bgview removeFromSuperview];
    }
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth - 40*NOW_SIZE, 70*HEIGHT_SIZE)];
    bgview.backgroundColor = WhiteColor;
//    bgview.layer.cornerRadius = 10*HEIGHT_SIZE;
//    bgview.layer.masksToBounds = YES;
    [self.contentView addSubview:bgview];
    _bgview = bgview;

    UILabel *oneLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
    oneLB.adjustsFontSizeToFitWidth = YES;
    oneLB.font = FontSize(14*HEIGHT_SIZE);
    oneLB.textColor = colorblack_102;
    oneLB.textAlignment = NSTextAlignmentCenter;

    if(_NameSource.count > 0){
        oneLB.text = _NameSource[0];

    }
    oneLB.numberOfLines = 0;
    [bgview addSubview:oneLB];
    
    UILabel *valueLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneLB.frame),bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
    valueLB.adjustsFontSizeToFitWidth = YES;
    valueLB.font = FontSize(14*HEIGHT_SIZE);
    valueLB.textColor = colorBlack;
    valueLB.textAlignment = NSTextAlignmentCenter;
    if(_dataSource.count >0){
        NSString *keystr = _dataSource[0];
        
        NSString *valustr = [NSString stringWithFormat:@"%@",_deviceAllDic[keystr]];
        if(kStringIsEmpty(valustr)){
            valustr = @"--";
        }
        
        valueLB.text = valustr;

    }
    valueLB.numberOfLines = 0;
    [bgview addSubview:valueLB];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(valueLB.frame)+9*HEIGHT_SIZE, valueLB.xmg_width, 1*HEIGHT_SIZE)];
    linev.backgroundColor = colorblack_186;
    [bgview addSubview:linev];
    
    if(_NameSource.count > 1){

        UILabel *twoLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oneLB.frame)+20*NOW_SIZE, 0,bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
        twoLB.adjustsFontSizeToFitWidth = YES;
        twoLB.font = FontSize(14*HEIGHT_SIZE);
        twoLB.textColor = colorblack_102;
        twoLB.textAlignment = NSTextAlignmentCenter;
        twoLB.text = _NameSource[1];
        twoLB.numberOfLines = 0;
        [bgview addSubview:twoLB];
        
        UILabel *valueLB2 = [[UILabel alloc]initWithFrame:CGRectMake(twoLB.xmg_x, CGRectGetMaxY(twoLB.frame),bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
        valueLB2.adjustsFontSizeToFitWidth = YES;
        valueLB2.font = FontSize(14*HEIGHT_SIZE);
        valueLB2.textColor = colorBlack;
        valueLB2.textAlignment = NSTextAlignmentCenter;

        if(_dataSource.count > 1){
    //        valueLB2.text = _dataSource[1];
            NSString *keystr2 = _dataSource[1];
            NSString *valustr2 = [NSString stringWithFormat:@"%@",_deviceAllDic[keystr2]];

            if(kStringIsEmpty(valustr2)){
                valustr2 = @"--";
            }
            valueLB2.text = valustr2;//[NSString stringWithFormat:@"%@",_deviceAllDic[keystr2]];
        }
        valueLB2.numberOfLines = 0;
        [bgview addSubview:valueLB2];
        
        UIView *linev2 = [[UIView alloc]initWithFrame:CGRectMake(twoLB.xmg_x, CGRectGetMaxY(valueLB2.frame)+9*HEIGHT_SIZE, valueLB2.xmg_width, 1*HEIGHT_SIZE)];
        linev2.backgroundColor = colorblack_186;

        [bgview addSubview:linev2];
    }
    
    
    
    
    
}


- (void)createCellUI{
    
    
    
    
    CGFloat bgheig = 80*HEIGHT_SIZE;
    if (_AllNameArr.count > 0) {
        NSArray *onearr = _AllNameArr[0];
        
        bgheig = 80*HEIGHT_SIZE*onearr.count;
    }
    
    
    
    UIScrollView *bgscro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, bgheig)];
    bgscro.pagingEnabled = YES;
    bgscro.showsVerticalScrollIndicator = NO;
    bgscro.showsHorizontalScrollIndicator = NO;
    bgscro.delegate = self;
    [self.contentView addSubview:bgscro];
    


    for (int M = 0; M < _AllNameArr.count; M++) {
        
        NSArray *nameArr2 = _AllNameArr[M];
        NSArray *keyArr2 = _AllKeyArr[M];

        
        UIView *oneBGView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*M, 0, kScreenWidth, bgscro.xmg_height)];
        [bgscro addSubview:oneBGView];
        bgscro.contentSize = CGSizeMake(kScreenWidth*(M+1), bgscro.xmg_height);
        
        for (int i = 0; i < nameArr2.count; i ++) {
            
            NSArray *NameLArr2 = nameArr2[i];
            NSArray *KeyLArr22 = keyArr2[i];

            for (int L = 0;L < NameLArr2.count ; L++) {
                //CGRectGetMaxY(titlb.frame)+
                UIView *oneview = [[UIView alloc]initWithFrame:CGRectMake(20*NOW_SIZE+((kScreenWidth-60*NOW_SIZE)/2 + 20*NOW_SIZE)*L, 10*HEIGHT_SIZE+70*HEIGHT_SIZE*i, (kScreenWidth-60*NOW_SIZE)/2, 70*HEIGHT_SIZE)];//   [self goToInitView:CGRectMake(20*NOW_SIZE+((kScreenWidth-60*NOW_SIZE)/2 + 20*NOW_SIZE)*L, 10*HEIGHT_SIZE+70*HEIGHT_SIZE*t, (kScreenWidth-60*NOW_SIZE)/2, 70*HEIGHT_SIZE) backgroundColor:WhiteColor];
                oneview.backgroundColor = WhiteColor;
                [oneBGView addSubview:oneview];
                
                UILabel *oneLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,oneview.xmg_width, 30*HEIGHT_SIZE)];
                oneLB.adjustsFontSizeToFitWidth = YES;
                oneLB.font = FontSize(14*HEIGHT_SIZE);
                oneLB.textColor = colorblack_102;
                oneLB.textAlignment = NSTextAlignmentCenter;
                oneLB.text = NameLArr2[L];
                oneLB.numberOfLines = 0;
                [oneview addSubview:oneLB];
                
                UILabel *valueLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneLB.frame),oneview.xmg_width, 30*HEIGHT_SIZE)];
                valueLB.adjustsFontSizeToFitWidth = YES;
                valueLB.font = FontSize(14*HEIGHT_SIZE);
                valueLB.textColor = colorBlack;
                valueLB.textAlignment = NSTextAlignmentCenter;
                if (KeyLArr22.count > L) {
                    NSString *keystr2 = KeyLArr22[L];
                    NSString *valustr2 = [NSString stringWithFormat:@"%@",_AllValueDic[keystr2]];

                    if(kStringIsEmpty(valustr2)){
                        valustr2 = @"--";
                    }
                    valueLB.text = valustr2;

                }
                valueLB.numberOfLines = 0;
                valueLB.tag = 100+i;
                [oneview addSubview:valueLB];
                
                UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(valueLB.frame)+9*HEIGHT_SIZE, valueLB.xmg_width, 1*HEIGHT_SIZE)];
                linev.backgroundColor = colorblack_186;
                [oneview addSubview:linev];
            }
            
        }
    }
    

    NSArray *onaaa = _AllNameArr[0];
    UIView *pointvie = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-(10*HEIGHT_SIZE*_AllNameArr.count+5*NOW_SIZE*(_AllNameArr.count + 1))/2, (10*HEIGHT_SIZE+70*HEIGHT_SIZE)*onaaa.count-20*HEIGHT_SIZE, 10*HEIGHT_SIZE*_AllNameArr.count+5*NOW_SIZE*(_AllNameArr.count + 1),10*HEIGHT_SIZE)];
//    pointvie.backgroundColor = colorBlack;
    [self.contentView addSubview:pointvie];
    
    for (int i = 0; i < _AllNameArr.count; i++) {
        
        UIView *pointbtn = [[UIView alloc]initWithFrame:CGRectMake(5*NOW_SIZE+(10*HEIGHT_SIZE+5*NOW_SIZE)*i, 0, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE)];
        pointbtn.layer.cornerRadius = 5*HEIGHT_SIZE;
        pointbtn.layer.masksToBounds = YES;
        pointbtn.tag = 2000+i;
        pointbtn.backgroundColor = backgroundNewColor;
        [pointvie addSubview:pointbtn];
        if (i == 0) {
            pointbtn.backgroundColor = colorBlack;

        }
        
        
    }
    
    
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    int allvtag = offsetX/kScreenWidth;
    
    for (int i = 0; i < _AllNameArr.count; i++) {
        UIView *oneview = [self viewWithTag:2000+i];
        if (i == allvtag) {
            oneview.backgroundColor = colorBlack;
          
        }else{
            oneview.backgroundColor = backgroundNewColor;
        }
        

    }
    self.ScrollOffSetBlock(allvtag);

    
    
}
@end
