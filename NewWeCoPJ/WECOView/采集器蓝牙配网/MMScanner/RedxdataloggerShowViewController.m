#import "RedxdataloggerShowViewController.h"
@interface RedxdataloggerShowViewController ()
@end
@implementation RedxdataloggerShowViewController
- (void)viewDidLoad {
    [super viewDidLoad];
 UIScrollView*   _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.backgroundColor=COLOR(236, 239, 241, 1);
    [self.view addSubview:_scrollView];
    float imageH=(900/375.0)*ScreenWidth;
    UIImageView *imageOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10*HEIGHT_SIZE, ScreenWidth, imageH)];
    imageOne.image =[UIImage imageNamed:@"dataloggerShow.PNG"];
    [_scrollView addSubview:imageOne];
    _scrollView.contentSize=CGSizeMake(ScreenWidth, imageH+100*HEIGHT_SIZE);
}
@end
