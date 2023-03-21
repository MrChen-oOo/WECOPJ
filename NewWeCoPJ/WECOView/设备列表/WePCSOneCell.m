//
//  WePCSOneCell.m
//  NewWeCoPJ
//
//  Created by 啊清 on 2023/3/9.
//

#import "WePCSOneCell.h"

@implementation WePCSOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
   
//        [self createCellUI];
    }
    
    return self;
}

- (void)createCellUI{
    
    
    
    
    
    UIScrollView *bgscro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
    
    [self.contentView addSubview:bgscro];


    for (int M = 0; M < _AllNameArr.count; M++) {
        
        NSArray *nameArr2 = _AllNameArr[M];
        NSArray *keyArr2 = _AllKeyArr[M];

        
        UIView *oneBGView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*M, 0, kScreenWidth, bgscro.xmg_height)];
        [bgscro addSubview:oneBGView];
        
        for (int i = 0; i < nameArr2.count; i ++) {
            
            int t = i/2;
            int L = i%2;
            
            //CGRectGetMaxY(titlb.frame)+
            UIView *oneview = [[UIView alloc]initWithFrame:CGRectMake(20*NOW_SIZE+((kScreenWidth-60*NOW_SIZE)/2 + 20*NOW_SIZE)*L, 10*HEIGHT_SIZE+70*HEIGHT_SIZE*t, (kScreenWidth-60*NOW_SIZE)/2, 70*HEIGHT_SIZE)];//   [self goToInitView:CGRectMake(20*NOW_SIZE+((kScreenWidth-60*NOW_SIZE)/2 + 20*NOW_SIZE)*L, 10*HEIGHT_SIZE+70*HEIGHT_SIZE*t, (kScreenWidth-60*NOW_SIZE)/2, 70*HEIGHT_SIZE) backgroundColor:WhiteColor];
            oneview.backgroundColor = WhiteColor;
            [oneBGView addSubview:oneview];
            
            UILabel *oneLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,oneview.xmg_width, 30*HEIGHT_SIZE)];
            oneLB.adjustsFontSizeToFitWidth = YES;
            oneLB.font = FontSize(14*HEIGHT_SIZE);
            oneLB.textColor = colorblack_102;
            oneLB.textAlignment = NSTextAlignmentCenter;
            oneLB.text = nameArr2[i];
            oneLB.numberOfLines = 0;
            [oneview addSubview:oneLB];
            
            UILabel *valueLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneLB.frame),oneview.xmg_width, 30*HEIGHT_SIZE)];
            valueLB.adjustsFontSizeToFitWidth = YES;
            valueLB.font = FontSize(14*HEIGHT_SIZE);
            valueLB.textColor = colorBlack;
            valueLB.textAlignment = NSTextAlignmentCenter;
            if (keyArr2.count > i) {
                NSString *keystr2 = keyArr2[i];
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
    

    
    UIView *pointvie = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-(10*HEIGHT_SIZE*_AllNameArr.count+5*(_AllNameArr.count + 1))/2, self.frame.size.height-15*HEIGHT_SIZE, (10*HEIGHT_SIZE*_AllNameArr.count+5*(_AllNameArr.count + 1))/2,10*HEIGHT_SIZE)];
    [self.contentView addSubview:pointvie];
    
    for (int i = 0; i < _AllNameArr.count; i++) {
        
        UIView *pointbtn = [[UIView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 0, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE)];
        pointbtn.layer.cornerRadius = 5*HEIGHT_SIZE;
        pointbtn.layer.masksToBounds = YES;
        pointbtn.backgroundColor = colorBlack;
        [pointvie addSubview:pointbtn];
        if (i == 0) {
            pointbtn.backgroundColor = backgroundNewColor;

            self.onevie = pointbtn;
        }
        if (i == 1) {
            pointbtn.backgroundColor = backgroundNewColor;

            self.twovie = pointbtn;
        }
        if (i == 2) {
            pointbtn.backgroundColor = backgroundNewColor;

            self.threevie = pointbtn;
        }
        
    }
    
    
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if(offsetX < kScreenWidth){
        
        _onevie.backgroundColor = colorBlack;
        _twovie.backgroundColor = backgroundNewColor;
        _threevie.backgroundColor = backgroundNewColor;
        self.ScrollOffSetBlock(0);


    }else if(offsetX >= kScreenWidth && offsetX < 2*kScreenWidth){
        
        _onevie.backgroundColor = backgroundNewColor;
        _twovie.backgroundColor = colorBlack;
        _threevie.backgroundColor = backgroundNewColor;
        self.ScrollOffSetBlock(1);

    }else{
        
        _onevie.backgroundColor = backgroundNewColor;
        _twovie.backgroundColor = backgroundNewColor;
        _threevie.backgroundColor = colorBlack;
        self.ScrollOffSetBlock(2);

    }
    
}

@end
