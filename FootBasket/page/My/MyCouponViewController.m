//
//  MyCouponViewController.m
//  FootBasket
//
//  Created by xyy on 2018/3/2.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "MyCouponViewController.h"

@interface MyCouponViewController ()

@end

@implementation MyCouponViewController

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
    self.title = @"我的钱包";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    [self getmycouponlist:@"10"];
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getmycouponlist:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getmycouponlist:[NSString stringWithFormat:@"%ld",[arraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self headerview:nil];
}

-(void)headerview:(id)sender
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
    imagebg.backgroundColor = [UIColor whiteColor];
    [view addSubview:imagebg];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 70, 20)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.text = @"钱包余额:";
    labeltitle.font = FONTN(15.0f);
    labeltitle.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labeltitle];
    
    labelwalletvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labeltitle)+5, 20, 150, 20)];
    labelwalletvalue.backgroundColor = [UIColor clearColor];
    labelwalletvalue.text = @"";//[NSString stringWithFormat:@"￥%@",FCwallet];
    labelwalletvalue.font = FONTN(15.0f);
    labelwalletvalue.textColor = COLORNOW(255, 110, 64);
    [view addSubview:labelwalletvalue];
    
    tableview.tableHeaderView = view;
}

//cell
-(UIView *)ViewCell:(CGRect)frame Dic:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, XYViewHeight(view)-5)];
    imagebg.backgroundColor = [UIColor whiteColor];
    [view addSubview:imagebg];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 0.7)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline1];
    
    UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(10,XYViewTop(imageline1)-30, 250, 20)];
    labelcode.text = [NSString stringWithFormat:@"订单编号:%@",[dic objectForKey:@"orderNo"]];
    labelcode.font = FONTB(16.0f);
    labelcode.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelcode];
    
    UILabel *labelstate = [[UILabel alloc] initWithFrame:CGRectMake(XYViewWidth(view)-100,XYViewTop(imageline1)-30, 90, 20)];
    labelstate.text = [dic objectForKey:@"disDeliveryState"];
    labelstate.font = FONTN(16.0f);
    labelstate.textAlignment = NSTextAlignmentRight;
    labelstate.textColor = COLORNOW(255, 110, 64);
    [view addSubview:labelstate];
    
    NSArray *arrayproduct = [dic objectForKey:@"products"];
    float heightnow = XYViewBottom(imageline1);
    float widthnow = (SCREEN_WIDTH-90)/8;
    for(int i=0;i<[arrayproduct count];i++)
    {
        NSDictionary *dicproduct = [arrayproduct objectAtIndex:i];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10+(10+widthnow)*i,XYViewBottom(imageline1)+10, widthnow, widthnow)];
        NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dicproduct objectForKey:@"productBasic_headPicture"]];
        [imageview setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        [view addSubview:imageview];
    }
    
    heightnow = heightnow+widthnow+20;
    
    UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightnow, SCREEN_WIDTH, 0.7)];
    imageline2.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline2];
    
    NSString *price = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"realPay"]];
    CommonHeader *com = [CommonHeader new];
    CGSize size = [com CMGetlablesize:price Fwidth:200 Fheight:20 Sfont:FONTN(15.0f) Spaceing:1.0f];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size.width-10, XYViewBottom(imageline2)+10, size.width, 20)];
    labelprice.text = price;
    labelprice.font = FONTN(15.0f);
    labelprice.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelprice];
    
    UILabel *labeldes = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelprice)-135,XYViewTop(labelprice), 135, 20)];
    labeldes.text = [NSString stringWithFormat:@"共计%ld件商品 合计:",[(NSArray *)[dic objectForKey:@"products"] count]];
    labeldes.font = FONTN(15.0f);
    labeldes.textColor = COLORNOW(122, 122,122);
    [view addSubview:labeldes];
    
    UILabel *labelcouponprice = [[UILabel alloc] initWithFrame:CGRectMake(10, XYViewBottom(imageline2)+10, 150, 20)];
    labelcouponprice.text = [NSString stringWithFormat:@"优惠:￥%@元",[dic objectForKey:@"couponPay"]];
    labelcouponprice.font = FONTN(16.0f);
    labelcouponprice.textColor = COLORNOW(255, 110, 64);
    [view addSubview:labelcouponprice];

    return view;
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
}

#pragma mark - IBAction
-(void)returnback:(id)sender
{
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickaddnew:(id)sender
{
    MyNewAddrViewController *addnew = [[MyNewAddrViewController alloc] init];
    [self.navigationController pushViewController:addnew animated:YES];
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
    float widthnow = (SCREEN_WIDTH-90)/8;
    NSDictionary *dic = [arraydata objectAtIndex:indexPath.row];
    NSArray *arrayproduct = [dic objectForKey:@"products"];
    int row = (int)[arrayproduct count]==0?0:(int)[arrayproduct count]/8+1;
    DLog(@"widow====%f",85+((widthnow+10)*row+10));
    return 85+((widthnow+10)*row+10);
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
    
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    float widthnow = (SCREEN_WIDTH-90)/8;
    NSDictionary *dic = [arraydata objectAtIndex:indexPath.row];
    NSArray *arrayproduct = [dic objectForKey:@"products"];
    int row = (int)[arrayproduct count]==0?0:(int)[arrayproduct count]/8+1;
    UIView *view = [self ViewCell:CGRectMake(0, 0, SCREEN_WIDTH, 85+((widthnow+10)*row+10)) Dic:dictemp IndexPath:indexPath];
    [cell.contentView addSubview:view];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 接口
-(void)getmycouponlist:(NSString *)rows 
{
    OrderService *order = [OrderService new];
    [order sendMyCouponOrderListRequest:app.userinfo.userid Rows:rows App:app ReqUrl:RQMyCouponList successBlock:^(NSDictionary *dicData) {
        arraydata = [dicData objectForKey:@"rows"];
        FCwallet = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"wallet"]];
        labelwalletvalue.text = [NSString stringWithFormat:@"￥%@",FCwallet];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
        
        if([arraydata count]>10)
            tableview.mj_footer.hidden = NO;
        [tableview.mj_header endRefreshing];
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
