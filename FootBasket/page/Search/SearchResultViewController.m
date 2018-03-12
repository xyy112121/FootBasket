//
//  SearchResultViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/23.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

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
    self.title = @"搜索结果";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-50) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getsearchresultlist:_FCSearchStr Rows:[NSString stringWithFormat:@"%ld",[arraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self getsearchresultlist:_FCSearchStr Rows:@"10"];
}

-(UIView *)getcellView:(NSDictionary *)dic Frame:(CGRect)frame TagNow:(int)tagnow
{
    UIView *viewcell = [[UIView alloc] initWithFrame:frame];
    viewcell.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dic objectForKey:@"headPicture"]];
    [imageview setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [viewcell addSubview:imageview];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10, XYViewTop(imageview), XYViewWidth(viewcell)-110, 20)];
    labelname.text = [dic objectForKey:@"name"];
    labelname.font = FONTB(17.0f);
    [viewcell addSubview:labelname];
    
    UILabel *labelsummary = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, 100, 20)];
    labelsummary.text = [dic objectForKey:@"summary"];
    labelsummary.font = FONTN(14.0f);
    labelsummary.textColor = COLORNOW(172, 172, 172);
    [viewcell addSubview:labelsummary];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelsummary)+5, 100, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dic objectForKey:@"salePrice"],[dic objectForKey:@"displayUnit"]];
    labelprice.font = FONTN(14.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [viewcell addSubview:labelprice];
    
    UIButton *buttonshoppingcar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonshoppingcar.frame = CGRectMake(XYViewWidth(viewcell)-50,XYViewHeight(viewcell)-50, 40, 40);
    [buttonshoppingcar setImage:LOADIMAGE(@"加入购物车small", @"png") forState:UIControlStateNormal];
    buttonshoppingcar.tag = EnSearchProductListTag +tagnow;
    [buttonshoppingcar addTarget:self action:@selector(clickCategoryGoods:) forControlEvents:UIControlEventTouchUpInside];
    [viewcell addSubview:buttonshoppingcar];
    
    return viewcell;
}

#pragma mark - viewcontroller delegate
-(void)viewWillAppear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnSearchNavigationBgViewTag] removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO];
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
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)DGAddShoppingCar:(NSDictionary *)sender
{
    AddShoppingCarView *addshoppingcar = [[AddShoppingCarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin) DicRecommend:sender];
    [app.window addSubview:addshoppingcar];
    
}

-(void)clickCategoryGoods:(id)sender
{
    if([app.userinfo.userid length]==0)
    {
        LoginView *login = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        login.delegate1 = self;
        [app.window addSubview:login];
    }
    else
    {
        UIButton *button = (UIButton *)sender;
        int tagnow = (int)[button tag]-EnSearchProductListTag;
        NSDictionary *dic = [arraydata objectAtIndex:tagnow];
        [self DGAddShoppingCar:dic];
    }
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
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraydata count];
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
    
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    
    UIView *view = [self getcellView:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 100) TagNow:(int)indexPath.row];
    [cell.contentView addSubview:view];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    GoodsDetailViewController *goodsdetail = [[GoodsDetailViewController alloc] init];
    goodsdetail.FCGoodsId = [dictemp objectForKey:@"id"];
    [self.navigationController pushViewController:goodsdetail animated:YES];
}


#pragma mark - 接口
-(void)getsearchresultlist:(NSString *)searchtext Rows:(NSString *)rows
{
    SearchService *search = [SearchService new];
    [search sendSearchProductRequest:searchtext Rows:rows App:app ReqUrl:RQSearchProductList successBlock:^(NSDictionary *dicData) {
        arraydata = [dicData objectForKey:@"rows"];
        
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
        
        if([arraydata count]>10)
            tableview.mj_footer.hidden = NO;
        [tableview.mj_footer endRefreshing];
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
