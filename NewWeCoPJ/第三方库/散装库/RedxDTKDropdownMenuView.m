#import "RedxDTKDropdownMenuView.h"
#import "Masonry.h"
#define menuWeakSelf(menuWeakSelf)  __weak __typeof(&*self)menuWeakSelf = self;
#define DTKMenuSrcName(file) [@"RedxDTKDropdownMenuView.bundle" stringByAppendingPathComponent:file]
#define DTKMenuFrameworkSrcName(file) [@"Frameworks/RedxDTKDropdownMenuView.framework/RedxDTKDropdownMenuView.bundle" stringByAppendingPathComponent:file]
static CGFloat DDPMAX_TABLEVIEW_HEIGHT(){
    return [UIScreen mainScreen].bounds.size.height * 0.6f;
}
static CGFloat DDP_TABLEVIEW_HEIGHT = 0.f;
static const CGFloat DDP_PADDING = 5.f;
@interface UIViewController (topest)
- (UIViewController *)topestViewController;
@end
@implementation UIViewController (topest)
- (UIViewController *)topestViewController
{
    if (self.presentedViewController)
    {
        return [self.presentedViewController topestViewController];
    }
    if ([self isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tab = (UITabBarController *)self;
        return [[tab selectedViewController] topestViewController];
    }
    if ([self isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)self;
        return [[nav visibleViewController] topestViewController];
    }
    return self;
}
@end
@implementation DTKDropdownButton
- (void)setHighlighted:(BOOL)highlighted{};
@end
@interface RedxDTKDropdownMenuView()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (strong, nonatomic) NSArray *items;
@property (assign ,nonatomic) BOOL isMenuShow;
@property (strong ,nonatomic) UIImageView *arrowImageView;
@property (strong, nonatomic) UIImageView *tableViewTopArrow;
@property (strong ,nonatomic) UITableView *tableView;
@property (strong ,nonatomic) UIView *backgroundView;
@property (strong ,nonatomic) UIView *wrapperView;
@property (assign, nonatomic) DTKDropDownType dropDownType;
@property (copy, nonatomic) NSString *icon;
@end
@implementation RedxDTKDropdownMenuView
@synthesize textFont = _textFont;
@synthesize titleFont = _titleFont;
@synthesize textColor = _textColor;
@synthesize titleColor = _titleColor;
@synthesize cellColor = _cellColor;
@synthesize cellSeparatorColor = _cellSeparatorColor;
@synthesize dropWidth = _dropWidth;
+ (instancetype)dropdownMenuViewWithType:(DTKDropDownType)dropDownType frame:(CGRect)frame dropdownItems:(NSArray *)dropdownItems icon:(NSString *)icon
{
    RedxDTKDropdownMenuView *menuView = [[RedxDTKDropdownMenuView alloc]initWithFrame:frame];
    menuView.layer.frame=frame;
    menuView.dropDownType = dropDownType;
   [menuView updateMainConstraints];
    menuView.items = dropdownItems;
    menuView.isMenuShow = NO;
    menuView.selectedIndex = 0;
    menuView.icon = icon;
    menuView.userInteractionEnabled=YES;
    return menuView;
}
+ (instancetype)dropdownMenuViewForNavbarTitleViewWithFrame:(CGRect )frame dropdownItems:(NSArray *)dropdownItems
{
    return [RedxDTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeTitle frame:frame dropdownItems:dropdownItems icon:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)addTapGesture:(UIView *)view
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [view addGestureRecognizer:tapGesture];
}
- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        self.isMenuShow = NO;
    }
}
- (void)addArrowTapGesture:(UIView *)view
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onArrowTap:)];
    [view addGestureRecognizer:tapGesture];
}
- (void)onArrowTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        self.isMenuShow = YES;
    }
}
- (void)addBarItemTap:(UIView *)view
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(barItemTap:)];
    [view addGestureRecognizer:tapGesture];
}
- (void)barItemTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        self.isMenuShow = !self.isMenuShow;
    }
}
- (void)updateMainConstraints
{
    if (self.dropDownType == dropDownTypeTitle) {
        [self.titleButton mas_updateConstraints:^(RedxMASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }else{
        [self.titleButton mas_updateConstraints:^(RedxMASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            if (self.dropDownType == dropDownTypeLeftItem) {
                make.leading.equalTo(self.mas_leading);
            }else{
                make.trailing.equalTo(self.mas_trailing);
            }
        }];
        [self addBarItemTap:self];
    }
    [self.arrowImageView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.left.equalTo(self.titleButton.mas_right).offset(5*NOW_SIZE);
        make.centerY.equalTo(self.titleButton.mas_centerY);
    }];
}
- (void)addWindowsSubviewsConstraints
{
    UINavigationController *nav = nil;
    if (self.currentNav) {
        nav = self.currentNav;
    }else{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        nav = [keyWindow.rootViewController topestViewController].navigationController;
    }
    UINavigationBar *navBar = nav.navigationBar;
    [nav.view addSubview:self.wrapperView];
    [self.wrapperView addSubview:self.backgroundView];
    [self.wrapperView addSubview:self.tableViewTopArrow];
    [self.wrapperView addSubview:self.tableView];
    menuWeakSelf(menuWeakSelf)
    [self.wrapperView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.edges.equalTo(nav.view);
    }];
    [self.backgroundView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.edges.equalTo(menuWeakSelf.wrapperView);
    }];
    [self.tableViewTopArrow mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.top.equalTo(navBar.mas_bottom);
        if (self.dropDownType == dropDownTypeTitle) {
            make.centerX.equalTo(self.mas_centerX);
        }else{
            if (deviceSystemVersion>=11.0) {
            }else{
                 make.centerX.equalTo(menuWeakSelf.titleButton.mas_centerX);
            }
        }
    }];
    NSUInteger count = DDPMAX_TABLEVIEW_HEIGHT()/self.cellHeight;
    if (count > self.items.count) {
        DDP_TABLEVIEW_HEIGHT = self.cellHeight * self.items.count;
        self.tableView.scrollEnabled = NO;
    }else{
        DDP_TABLEVIEW_HEIGHT = self.cellHeight * count;
        self.tableView.scrollEnabled = YES;
    }
    [self.tableView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.width.mas_equalTo(self.dropWidth);
        make.height.mas_equalTo(0.f);
        make.top.equalTo(self.tableViewTopArrow.mas_bottom);
        switch (menuWeakSelf.dropDownType) {
            case dropDownTypeTitle:
            {
                make.centerX.equalTo(menuWeakSelf.tableViewTopArrow.mas_centerX);
            }
                break;
            case dropDownTypeLeftItem:
            {
                make.left.equalTo(menuWeakSelf.wrapperView.mas_left).offset(DDP_PADDING);
            }
                break;
            case dropDownTypeRightItem:
            {
                make.right.equalTo(menuWeakSelf.wrapperView.mas_right).offset(-DDP_PADDING);
            }
                break;
            default:
                break;
        }
    }];
    self.wrapperView.hidden = YES;
}
- (void)showMenu
{
    [self addWindowsSubviewsConstraints];
    self.titleButton.enabled = NO;
    [self.tableView layoutIfNeeded];
    [self.tableView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.height.mas_equalTo(DDP_TABLEVIEW_HEIGHT);
    }];
    self.wrapperView.hidden = NO;
    self.backgroundView.alpha = 0.0;
    menuWeakSelf(menuWeakSelf)
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         menuWeakSelf.arrowImageView.transform = CGAffineTransformRotate(menuWeakSelf.arrowImageView.transform, M_PI);
                     }];
    [UIView animateWithDuration:self.animationDuration * 1.5f
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [menuWeakSelf.tableView layoutIfNeeded];
                         [menuWeakSelf.tableView reloadData];
                         menuWeakSelf.backgroundView.alpha = self.backgroundAlpha;
                         menuWeakSelf.titleButton.enabled = YES;
                     } completion:nil];
}
- (void)hideMenu
{
    if (!_wrapperView) {
        return;
    }
    [self.tableView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.height.mas_equalTo(0.f);
    }];
    [self.tableViewTopArrow mas_updateConstraints:^(RedxMASConstraintMaker *make) {
        make.height.mas_equalTo(0.f);
    }];
    self.titleButton.alpha = 1.f;
    menuWeakSelf(menuWeakSelf)
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         menuWeakSelf.arrowImageView.transform = CGAffineTransformIdentity;
                     }];
    [UIView animateWithDuration:self.animationDuration * 1.5f
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [menuWeakSelf.tableView layoutIfNeeded];
                         [menuWeakSelf.tableViewTopArrow layoutIfNeeded];
                         menuWeakSelf.backgroundView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         menuWeakSelf.wrapperView.hidden = YES;
                         [_tableView removeFromSuperview];
                         [_tableViewTopArrow removeFromSuperview];
                         [_backgroundView removeFromSuperview];
                         [_wrapperView removeFromSuperview];
                         _tableView = nil;
                         _tableViewTopArrow = nil;
                         _backgroundView = nil;
                         _wrapperView = nil;
                     }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RedxDTKDropdownMenuViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RedxDTKDropdownMenuViewCell"];
    }
    DTKDropdownItem *item = self.items[indexPath.row];
    cell.textLabel.text = item.title;
    if (item.iconName.length) {
        [cell.imageView setImage:[UIImage imageNamed:item.iconName]];
    }
    if (self.selectedIndex == indexPath.row&&self.showAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.tintColor = self.cellAccessoryCheckmarkColor;
    cell.backgroundColor = self.cellColor;
    cell.textLabel.font = self.textFont;
    cell.textLabel.adjustsFontSizeToFitWidth=YES;
    cell.textLabel.textColor = self.textColor;
    if (self.dropDownType == dropDownTypeTitle) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DTKDropdownItem *item = self.items[indexPath.row];
    self.selectedIndex = indexPath.row;
    if (item.callBack) {
        item.callBack(indexPath.row,item.info);
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
#pragma mark -- handle actions --
- (void)handleTapOnTitleButton:(DTKDropdownButton *)button
{
    self.isMenuShow = !self.isMenuShow;
}
-(void)pullTheTableView{
        self.isMenuShow = !self.isMenuShow;
}
#pragma mark - setter
- (void)setCellColor:(UIColor *)cellColor
{
    if (_tableViewTopArrow) {
       [_tableViewTopArrow setTintColor:cellColor];
    }
    _cellColor = cellColor;
}
- (void)setCellSeparatorColor:(UIColor *)cellSeparatorColor
{
    if (_tableView)
    {
        _tableView.separatorColor = cellSeparatorColor;
    }
    _cellSeparatorColor = cellSeparatorColor;
}
- (void)setTitleColor:(UIColor *)titleColor
{
    if (_titleButton) {
        [_titleButton setTitleColor:titleColor forState:UIControlStateNormal];
    }
    _titleColor = titleColor;
}
- (void)setTitleFont:(UIFont *)titleFont
{
    if (_titleButton) {
        [_titleButton.titleLabel setFont:titleFont];
    }
    _titleFont = titleFont;
}
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
}
- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
}
- (void)setDropWidth:(CGFloat)dropWidth
{
    if (_dropWidth!=dropWidth) {
        _dropWidth = dropWidth;
        [self.tableView mas_updateConstraints:^(RedxMASConstraintMaker *make) {
            make.width.mas_equalTo(_dropWidth);
        }];
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if (self.dropDownType == dropDownTypeTitle) {
        DTKDropdownItem *item = self.items[_selectedIndex];
        [self.titleButton setTitle:item.title forState:UIControlStateNormal];
        CGFloat titleWidth = [item.title sizeWithAttributes:@{NSFontAttributeName:self.titleFont}].width;
        if (titleWidth > self.frame.size.width) {
            [self.titleButton mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
                make.center.equalTo(self);
                make.width.mas_equalTo(self.frame.size.width);
            }];
        }else{
            [self.titleButton mas_remakeConstraints:^(RedxMASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        }
    }
    self.isMenuShow = NO;
}
- (void)setIcon:(NSString *)icon
{
    if (![_icon isEqualToString:icon]) {
        _icon = icon;
        if (self.dropDownType != dropDownTypeTitle) {
            [self.titleButton setImage:[UIImage imageNamed:_icon] forState:UIControlStateNormal];
            [self.titleButton setImage:[UIImage imageNamed:_icon] forState:UIControlStateSelected];
        }
    }
}
- (void)setDropDownType:(DTKDropDownType)dropDownType
{
    _dropDownType = dropDownType;
    self.arrowImageView.hidden = (_dropDownType != dropDownTypeTitle);
}
- (void)setIsMenuShow:(BOOL)isMenuShow
{
    if (_isMenuShow != isMenuShow) {
        _isMenuShow = isMenuShow;
        if (_isMenuShow) {
            [self showMenu];
        }else{
            [self hideMenu];
        }
    }
}
#pragma mark - getter
- (DTKDropdownButton *)titleButton
{
    if (!_titleButton)
    {
        _titleButton = [[DTKDropdownButton alloc] init];
        DTKDropdownItem *item = self.items[0];
        [_titleButton setTitle:item.title forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(handleTapOnTitleButton:) forControlEvents:UIControlEventTouchDown];
        [_titleButton.titleLabel setFont:self.titleFont];
        [_titleButton setTitleColor:self.titleColor forState:UIControlStateNormal];
        _titleButton.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;
        [self addSubview:_titleButton];
    }
    return _titleButton;
}
- (UIImageView *)arrowImageView
{
    if (!_arrowImageView)
    {
        UIImage *image = [UIImage imageNamed:@"plant_title_drop"];
        _arrowImageView = [[UIImageView alloc] initWithImage:image];
        _arrowImageView.frame=CGRectMake(self.bounds.size.width-10*NOW_SIZE, 2*HEIGHT_SIZE, 10*NOW_SIZE, 10*HEIGHT_SIZE);
        [self addSubview:_arrowImageView];
        _arrowImageView.userInteractionEnabled = YES;
        [self addArrowTapGesture:_arrowImageView];
    }
    return _arrowImageView;
}
- (UIImageView *)tableViewTopArrow
{
    if (!_tableViewTopArrow) {
        UIImage *tempImage = [UIImage imageNamed:DTKMenuSrcName(@"2triangular.png")];
        UIImage *image=[tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _tableViewTopArrow = [[UIImageView alloc] initWithImage:image];
        [_tableViewTopArrow setTintColor:self.cellColor];
    }
    return _tableViewTopArrow;
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
        [_tableView.layer setCornerRadius:6.f];
    }
    return _tableView;
}
- (UIView *)wrapperView
{
    if (!_wrapperView)
    {
        _wrapperView = [[UIView alloc]init];
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
        [self addTapGesture:_backgroundView];
    }
    return _backgroundView;
}
#pragma mark - getter 初始化属性
- (CGFloat)backgroundAlpha
{
    if (!_backgroundAlpha * 10) {
        return 0.3f;
    }
    return _backgroundAlpha;
}
- (UIFont *)textFont
{
    if (!_textFont) {
        return [UIFont systemFontOfSize:17.f];
    }
    return _textFont;
}
- (UIColor *)textColor
{
    if (!_textColor) {
        return [UIColor whiteColor];
    }
    return _textColor;
}
- (CGFloat)animationDuration
{
    if (!_animationDuration * 100) {
        return 0.4f;
    }
    return _animationDuration;
}
- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        return 40*HEIGHT_SIZE;
    }
    return _cellHeight;
}
- (UIColor *)cellAccessoryCheckmarkColor
{
    if (!_cellAccessoryCheckmarkColor) {
        return [UIColor whiteColor];
    }
    return _cellAccessoryCheckmarkColor;
}
- (UIColor *)cellSeparatorColor
{
    if (!_cellSeparatorColor) {
        return [UIColor whiteColor];
    }
    return _cellSeparatorColor;
}
- (UIColor *)cellColor
{
    if (!_cellColor) {
        return [UIColor whiteColor];
    }
    return _cellColor;
}
- (UIFont *)titleFont
{
    if (!_titleFont) {
        return [UIFont systemFontOfSize:17.f];
    }
    return _titleFont;
}
- (UIColor *)titleColor
{
    if (!_titleColor) {
        return [UIColor whiteColor];
    }
    return _titleColor;
}
- (CGFloat)dropWidth
{
    if (_dropWidth < 80*NOW_SIZE) {
        return 80*NOW_SIZE;
    }
    return _dropWidth;
}
@end
@implementation DTKDropdownItem
+ (instancetype)Item
{
    return [[self alloc]init];
}
+ (instancetype)itemWithTitle:(NSString *)title callBack:(dropMenuCallBack)callBack
{
    return [self itemWithTitle:title iconName:nil callBack:callBack];
}
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)iconName callBack:(dropMenuCallBack)callBack
{
    DTKDropdownItem *item = [DTKDropdownItem Item];
    item.title = title;
    item.iconName = iconName;
    item.callBack = callBack;
    return item;
}
@end
