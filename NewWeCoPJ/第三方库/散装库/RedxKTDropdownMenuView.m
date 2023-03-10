#import "RedxKTDropdownMenuView.h"
#import "Masonry.h"
static const CGFloat kKTDropdownMenuViewHeaderHeight = 0;
static const CGFloat kKTDropdownMenuViewAutoHideHeight = 44;
static CGFloat DDP_TABLEVIEW_HEIGHT = 0.f;
static CGFloat DDPMAX_TABLEVIEW_HEIGHT(){
    return [UIScreen mainScreen].bounds.size.height * 0.6f;
}
@interface RedxKTDropdownMenuView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, assign) BOOL isMenuShow;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *wrapperView;
@end
@implementation RedxKTDropdownMenuView
#pragma mark -- life cycle --
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame])
    {
        _width = 0.0;
        _animationDuration = 0.4;
        _backgroundAlpha = 0.3;
        _cellHeight = 44;
        _isMenuShow = NO;
        _selectedIndex = 0;
        _titles = titles;
        [self addTapGesture];
        self.userInteractionEnabled=YES;
        [self addSubview:self.titleButton];
        [self addSubview:self.arrowImageView];
        self.arrowImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap2:)];
        [_arrowImageView addGestureRecognizer:tapGesture1];
        [self.wrapperView addSubview:self.backgroundView];
        [self.wrapperView addSubview:self.tableView];
    }
    return self;
}
- (void)addTapGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.backgroundView addGestureRecognizer:tapGesture];
}
- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
          self.isMenuShow = NO;
    }
}
- (void)onTap2:(UITapGestureRecognizer *)gesture{
     self.isMenuShow = !self.isMenuShow;
}
- (void)didMoveToWindow
{
    [super didMoveToWindow];
    if (self.window)
    {
        [self.window addSubview:self.wrapperView];
        [self.titleButton mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
            make.center.equalTo(self);
            CGSize texsiz = [self getStringSize:16*HEIGHT_SIZE Wsize:(kScreenWidth-180*NOW_SIZE) Hsize:30*HEIGHT_SIZE stringName:self.titleButton.titleLabel.text];
            if (texsiz.width < self.width){
                self.titleButton.titleLabel.numberOfLines = 1;
                self.titleButton.titleLabel.adjustsFontSizeToFitWidth = YES;

            }else{
                self.titleButton.titleLabel.numberOfLines = 2;
                self.titleButton.titleLabel.adjustsFontSizeToFitWidth = NO;


            }
            make.width.mas_equalTo(texsiz.width);
            
        }];
        [self.arrowImageView mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
            make.left.equalTo(self.titleButton.mas_right).offset(0);
            make.centerY.equalTo(self.titleButton.mas_centerY);
        }];
        [self.wrapperView mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.window);
            make.top.equalTo(self.superview.mas_bottom);
        }];
        [self.backgroundView mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
            make.edges.equalTo(self.wrapperView);
        }];
        CGFloat tableCellsHeight = _cellHeight * _titles.count;
        [self.tableView mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
            make.centerX.equalTo(self.wrapperView.mas_centerX);
            if (self.width > 79.99999)
            {
                make.width.mas_equalTo(self.width);
            }
            else
            {
                make.width.equalTo(self.wrapperView.mas_width);
            }
            make.top.equalTo(self.wrapperView.mas_top).offset(-tableCellsHeight - kKTDropdownMenuViewHeaderHeight);
            make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + kKTDropdownMenuViewHeaderHeight);
        }];
        self.wrapperView.hidden = YES;
    }
    else
    {
        [self.wrapperView removeFromSuperview];
    }
}
#pragma mark -- UITableViewDataSource --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
    cell.tintColor = self.cellAccessoryCheckmarkColor;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.f];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.textColor = colorblack_102;
    cell.textLabel.numberOfLines = 2;
//    cell.textLabel.adjustsFontSizeToFitWidth=YES;
    return cell;
}
#pragma mark -- UITableViewDataDelegate --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedAtIndex)
    {
        self.selectedAtIndex((int)indexPath.row);
    }
    [self.titleButton mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
        make.center.equalTo(self);
        CGSize texsiz = [self getStringSize:16*HEIGHT_SIZE Wsize:(kScreenWidth-180*NOW_SIZE) Hsize:30*HEIGHT_SIZE stringName:self.titleButton.titleLabel.text];
        if (texsiz.width < self.width){
            self.titleButton.titleLabel.numberOfLines = 1;
            self.titleButton.titleLabel.adjustsFontSizeToFitWidth = YES;

        }else{
            self.titleButton.titleLabel.numberOfLines = 2;
            self.titleButton.titleLabel.adjustsFontSizeToFitWidth = NO;


        }
        make.width.mas_equalTo(texsiz.width);
        
    }];
    [self.arrowImageView mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
        make.left.equalTo(self.titleButton.mas_right).offset(0);
        make.centerY.equalTo(self.titleButton.mas_centerY);
    }];
}
#pragma mark -- handle actions --
- (void)handleTapOnTitleButton:(UIButton *)button
{
    self.isMenuShow = !self.isMenuShow;
}
- (void)orientChange:(NSNotification *)notif
{
    NSLog(@"change orientation");
}
#pragma mark -- helper methods --
- (void)showMenu
{
    self.titleButton.enabled = NO;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kKTDropdownMenuViewHeaderHeight)];
    headerView.backgroundColor = self.cellColor;
    self.tableView.tableHeaderView = headerView;
    [self.tableView layoutIfNeeded];
    [self.tableView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.top.equalTo(self.wrapperView.mas_top).offset(-kKTDropdownMenuViewHeaderHeight);
          make.bottom.equalTo(self.wrapperView.mas_bottom).offset(kKTDropdownMenuViewHeaderHeight);
    }];
    self.wrapperView.hidden = NO;
    self.backgroundView.alpha = 0.0;
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
                     }];
    [UIView animateWithDuration:self.animationDuration * 1.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.tableView layoutIfNeeded];
                         self.backgroundView.alpha = self.backgroundAlpha;
                         self.titleButton.enabled = YES;
                     } completion:nil];
}
- (void)hideMenu
{
    self.titleButton.enabled = NO;
    CGFloat tableCellsHeight = _cellHeight * _titles.count;
    [self.tableView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.top.equalTo(self.wrapperView.mas_top).offset(-tableCellsHeight - kKTDropdownMenuViewHeaderHeight);
        make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + kKTDropdownMenuViewHeaderHeight);
    }];
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
                     }];
    [UIView animateWithDuration:self.animationDuration * 1.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.tableView layoutIfNeeded];
                         self.backgroundView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         self.wrapperView.hidden = YES;
                         [self.tableView reloadData];
                         self.titleButton.enabled = YES;
                     }];
}
#pragma mark -- getter and setter --
- (UIColor *)cellColor
{
    if (!_cellColor)
    {
        _cellColor = [UIColor whiteColor];
    }
    return _cellColor;
}
@synthesize cellSeparatorColor = _cellSeparatorColor;
- (UIColor *)cellSeparatorColor
{
    if (!_cellSeparatorColor)
    {
        _cellSeparatorColor = [UIColor whiteColor];
    }
    return _cellSeparatorColor;
}
- (void)setCellSeparatorColor:(UIColor *)cellSeparatorColor
{
    if (_tableView)
    {
        _tableView.separatorColor = cellSeparatorColor;
    }
    _cellSeparatorColor = cellSeparatorColor;
}
- (UIColor *)cellAccessoryCheckmarkColor
{
    if (!_cellAccessoryCheckmarkColor)
    {
        _cellAccessoryCheckmarkColor = [UIColor whiteColor];
    }
    return _cellAccessoryCheckmarkColor;
}
@synthesize textColor = _textColor;
- (UIColor *)textColor
{
    if (!_textColor)
    {
        _textColor = [UIColor whiteColor];
    }
    return _textColor;
}
- (void)setTextColor:(UIColor *)textColor
{
    if (_titleButton)
    {
        [_titleButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    _textColor = textColor;
}
@synthesize textFont = _textFont;
- (UIFont *)textFont
{
    if(!_textFont)
    {
        _textFont = [UIFont systemFontOfSize:17];
    }
    return _textFont;
}
- (void)setTextFont:(UIFont *)textFont
{
    if (_titleButton)
    {
        [_titleButton.titleLabel setFont:textFont];;
    }
    _textFont = textFont;
}
- (UIButton *)titleButton
{
    if (!_titleButton)
    {
        _titleButton = [[UIButton alloc] init];
        [_titleButton setTitle:[self.titles objectAtIndex:0] forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(handleTapOnTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton.titleLabel setFont:self.textFont];
        _titleButton.titleLabel.numberOfLines = 2;
//        _titleButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_titleButton setTitleColor:self.textColor forState:UIControlStateNormal];
    }
    return _titleButton;
}
- (UIImageView *)arrowImageView
{
    if (!_arrowImageView)
    {
        UIImage *image = [UIImage imageNamed:@"downHead"];
        _arrowImageView = [[UIImageView alloc] initWithImage:image];
        _arrowImageView.userInteractionEnabled=YES;
    }
    return _arrowImageView;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = self.cellSeparatorColor;
        [_tableView.layer setMasksToBounds:YES];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    }
    return _tableView;
}
- (UIView *)wrapperView
{
    if (!_wrapperView)
    {
        _wrapperView = [[UIView alloc] init];
        _wrapperView.clipsToBounds = YES;
    }
    return _wrapperView;
}
- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = self.backgroundAlpha;
    }
    return _backgroundView;
}
- (void)setIsMenuShow:(BOOL)isMenuShow
{
    if (_isMenuShow != isMenuShow)
    {
        _isMenuShow = isMenuShow;
        NSUInteger count = DDPMAX_TABLEVIEW_HEIGHT()/self.cellHeight;
        if (count > self.titles.count) {
            DDP_TABLEVIEW_HEIGHT = self.cellHeight * self.titles.count;
            self.tableView.scrollEnabled = NO;
        }else{
            DDP_TABLEVIEW_HEIGHT = self.cellHeight * count;
            self.tableView.scrollEnabled = YES;
        }
        if (isMenuShow)
        {
            [self showMenu];
        }
        else
        {
            [self hideMenu];
        }
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex)
    {
        _selectedIndex = selectedIndex;
        [_titleButton setTitle:[_titles objectAtIndex:selectedIndex] forState:UIControlStateNormal];
    }
    self.isMenuShow = NO;
}
- (void)setWidth:(CGFloat)width
{
    if (width < 80.0)
    {
        NSLog(@"width should be set larger than 80, otherwise it will be set to be equal to window width");
        return;
    }
    _width = width;
}
-(CGSize)getStringSize:(float)fontSize Wsize:(float)Wsize Hsize:(float)Hsize stringName:(NSString*)stringName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [stringName boundingRectWithSize:CGSizeMake(Wsize, Hsize) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}
@end
