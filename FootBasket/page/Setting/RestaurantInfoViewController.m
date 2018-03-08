//
//  RestaurantInfoViewController.m
//  FootBasket
//
//  Created by xyy on 2018/3/1.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RestaurantInfoViewController.h"

@interface RestaurantInfoViewController ()

@end

@implementation RestaurantInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.backgroundColor = COLORNOW(250, 250, 250);
    self.tabBarController.tabBar.tintColor =  COLORNOW(32, 188, 167);
    self.tabBarController.tabBar.barTintColor = COLORNOW(250, 250, 250);
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
    self.view.backgroundColor = COLORNOW(240, 240, 240);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.title = @"餐馆列表";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    UIButton *buttonaddnew = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonaddnew.frame = CGRectMake(0, SCREEN_HEIGHT-50-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin, SCREEN_WIDTH, 50);
    [buttonaddnew setImage:LOADIMAGE(@"添加icon", @"png") forState:UIControlStateNormal];
    [buttonaddnew setTitle:@"添加新店" forState:UIControlStateNormal];
    [buttonaddnew setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    buttonaddnew.titleLabel.font = FONTN(15.0f);
    [buttonaddnew setBackgroundColor:COLORNOW(32, 188, 167)];
    [buttonaddnew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonaddnew addTarget:self action:@selector(clickaddnewrestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonaddnew];
}

#pragma mark - viewcontroller delegate
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UIColor* color = [UIColor blackColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
    
    [self.navigationController setNavigationBarHidden:NO];
    [self getrestaurantlist];
}

#pragma mark - IBAction
-(void)returnback:(id)sender
{
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickaddnewrestaurant:(id)sender
{
    RestaurantAuthViewController *auth = [[RestaurantAuthViewController alloc] init];
    [self.navigationController pushViewController:auth animated:YES];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    imageline.backgroundColor = COLORNOW(240, 240, 240);
    return imageline;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = [arraydata objectAtIndex:indexPath.row];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10,(XYViewHeight(cell.contentView)-20)/2, 200, 20)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = COLORNOW(52, 52, 52);
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    [cell.contentView addSubview:labeltitle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [arraydata objectAtIndex:indexPath.row];
    RestaurantDetailViewController *auth = [[RestaurantDetailViewController alloc] init];
    auth.FCrestaurantid = [dic objectForKey:@"id"];
    [self.navigationController pushViewController:auth animated:YES];
}

#pragma mark - 接口
-(void)getrestaurantlist
{
    SettingService *setservice = [SettingService new];
    [setservice sendGetRestaurangListRequest:app.userinfo.userid App:app ReqUrl:RQRestaurantList successBlock:^(NSDictionary *dicData) {
        arraydata = [dicData objectForKey:@"rows"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
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
