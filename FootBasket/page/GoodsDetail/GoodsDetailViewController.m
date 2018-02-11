//
//  GoodsDetailViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/9.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor =  COLORNOW(32, 188, 167);
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    [self initview];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:LOADIMAGE(@"arrow_R", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = COLORNOW(245, 245, 245);
    self.title = @"商品详情";
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    [self getGoodsDetail:_FCGoodsId];
    
    [self initbottomview];
    
}

-(void)initheaderview:(NSArray *)arraysrc
{
    FocusNewsView *focusnew = [[FocusNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) Focus:arraysrc];
    tableview.tableHeaderView = focusnew;
}

-(void)initbottomview
{
    UIView *viewbottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin-40, SCREEN_WIDTH, 40)];
    viewbottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewbottom];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100, 40);
    [button setTitle:@"加入购物车" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    button.backgroundColor = COLORNOW(32, 188, 167);
    [button addTarget:self action:@selector(clickaddtarget:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewbottom addSubview:button];
    
    
    
}

#pragma mark - viewcontroller delegate
-(void)viewWillAppear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationBgTag] removeFromSuperview];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UIColor* color = [UIColor blackColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark - IBAction
-(void)returnback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickaddtarget:(id)sender
{
    [self addshoppingcar:_FCGoodsId UserId:app.userinfo.userid];
}

#pragma mark - tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 5;
    else
        return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = @"123";
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 获取商品详情
//获取商品详情
-(void)getGoodsDetail:(NSString *)goodsid
{
    GoodsDetailService *goodsdetail = [GoodsDetailService new];
    [goodsdetail sendGoodsDetailRequest:goodsid App:app ReqUrl:RQGoodsDetail successBlock:^(NSDictionary *dicData) {
       
        arrayfocus = [dicData objectForKey:@"pictures"];
        [self initheaderview:arrayfocus];
        arrayattributes = [dicData objectForKey:@"attributes"];
        dicproduct = [dicData objectForKey:@"productBasic"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
    }];
}


-(void)addshoppingcar:(NSString *)goodsid UserId:(NSString *)userid
{
    GoodsDetailService *goodsdetail = [GoodsDetailService new];
    [goodsdetail sendaddShoppingCarRequest:goodsid UserId:userid App:app ReqUrl:RQAddShoppingCar successBlock:^(NSDictionary *dicData) {
       
        
    }];
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
