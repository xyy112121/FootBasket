//
//  HpViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "HpViewController.h"

@interface HpViewController ()

@end

@implementation HpViewController

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
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = COLORNOW(245, 245, 245);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-49) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf gethpinterface];
    }];
    
    [self getNewVersion];
    [self getHpDiscory];
//    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf getmyfansperson:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
//    }];
//    // 默认先隐藏footer
//    tableview.mj_footer.hidden = YES;
    
    //    NSFileManager *filemanger = [NSFileManager defaultManager];
    
    
}

//精品推荐
-(UIView *)RecommendGoods:(CGRect)frame RecommendData:(NSArray *)arrayrecommend
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, frame.size.height-10)];
    imagebg.backgroundColor = [UIColor whiteColor];
    [view addSubview:imagebg];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 5, 20)];
    imageviewline.backgroundColor = COLORNOW(32, 188, 167);
    [view addSubview:imageviewline];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageviewline)+5, XYViewTop(imageviewline), 100, 20)];
    label.text = @"精品推荐";
    [view addSubview:label];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-10, XYViewHeight(view)-60)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    [view addSubview:scrollview];
    
    for(int i=0;i<[arrayrecommend count];i++)
    {
        NSDictionary *dictemp = [arrayrecommend objectAtIndex:i];
        RecommendGoodsCell *cell = [[RecommendGoodsCell alloc] initWithFrame:CGRectMake(260*i,0, 250, 100) DicRecommend:dictemp];
        cell.delegate1 = self;
        [scrollview addSubview:cell];
    }
    scrollview.contentSize = CGSizeMake(260*[arrayrecommend count], 100);
    
    return view;
    
}

//商品特惠
-(UIView *)SpecialDiscountGoods:(CGRect)frame Dic:(NSDictionary *)dic TagNow:(int)tagnow
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XYViewWidth(view), XYViewWidth(view))];
    imageview.image = LOADIMAGE(@"图层20", @"png");
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dic objectForKey:@"headPicture"]];
    [imageview setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
    UITapGestureRecognizer *recongizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickgoodsdetail:)];
    imageview.userInteractionEnabled = YES;
    imageview.tag = EnHpDiscountImageViewTag+tagnow;
    [imageview addGestureRecognizer:recongizer];
    [view addSubview:imageview];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,XYViewBottom(imageview)+5, XYViewWidth(view)-10, 20)];
    labelname.text = [dic objectForKey:@"name"];
    labelname.font = FONTN(16.0f);
    labelname.adjustsFontSizeToFitWidth = YES;
    [view addSubview:labelname];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, XYViewWidth(view)-50, 20)];
    if([app.userinfo.usertype isEqualToString:@"2"])
        labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dic objectForKey:@"merchantPrice"],[dic objectForKey:@"displayUnit"]];
    else
        labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dic objectForKey:@"salePrice"],[dic objectForKey:@"displayUnit"]];
    labelprice.font = FONTN(15.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [view addSubview:labelprice];
    
    UIButton *buttonshoppingcar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonshoppingcar.frame = CGRectMake(XYViewWidth(view)-40,XYViewHeight(view)-35, 40, 40);
    [buttonshoppingcar setImage:LOADIMAGE(@"加入购物车small", @"png") forState:UIControlStateNormal];
    buttonshoppingcar.backgroundColor = [UIColor clearColor];
    buttonshoppingcar.tag = EnHpDiscountShopCarBtTag+tagnow;
    [buttonshoppingcar addTarget:self action:@selector(clickDiscountgoods:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttonshoppingcar];
    
    return view;
    
}

#pragma mark - IBACtion
-(void)clickgoodsdetail:(UITapGestureRecognizer *)sender
{
    UIView *view = sender.view;
    NSDictionary *dictemp = [arraydata objectAtIndex:view.tag-EnHpDiscountImageViewTag];
    GoodsDetailViewController *goodsdetail = [[GoodsDetailViewController alloc] init];
    goodsdetail.FCGoodsId = [dictemp objectForKey:@"id"];
    goodsdetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodsdetail animated:YES];
}

-(void)clickDiscountgoods:(id)sender
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
        int tagnow = (int)[button tag]-EnHpDiscountShopCarBtTag;
        NSDictionary *dic = [arraydata objectAtIndex:tagnow];
        [self DGAddShoppingCar:dic];
    }
}


#pragma mark - ActionDelegate
-(void)DGLoginSuccess:(id)sender
{
    [self gethpinterface];
}

-(void)DGTouristsLoginSuccess:(id)sender
{
    [self gethpinterface];
}

-(void)DGCickSearchTextfield:(id)sender
{
    SearchViewController *searchview = [[SearchViewController alloc] init];
    UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchview];
    [self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGClickRecommendDetail:(NSDictionary *)sender
{
    GoodsDetailViewController *goodsdetail = [[GoodsDetailViewController alloc] init];
    goodsdetail.FCGoodsId = [sender objectForKey:@"id"];
    goodsdetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodsdetail animated:YES];
}

-(void)DGAddShoppingCar:(NSDictionary *)sender
{
    if([app.userinfo.userid length]==0)
    {
        LoginView *login = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        login.delegate1 = self;
        [app.window addSubview:login];
    }
    else
    {
        AddShoppingCarView *addshoppingcar = [[AddShoppingCarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin) DicRecommend:sender];
        [app.window addSubview:addshoppingcar];
    }
}

-(void)DGClickHpDiscovery:(id)sender
{
    if ([FCDiscoryUrl rangeOfString:@"http"].location != NSNotFound)
    {
        WkWebviewViewController *wkwebview = [[WkWebviewViewController alloc] init];
        wkwebview.hidesBottomBarWhenPushed = YES;
       
        wkwebview.FCDiscoveryUrl = FCDiscoryUrl;
        [self.navigationController pushViewController:wkwebview animated:YES];
    }
}

#pragma mark - viewcontroller delegate
-(void)viewWillAppear:(BOOL)animated
{
//    [self getuserinfo];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UIColor* color = [UIColor blackColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
    
    if(app.userinfo.userid)
    {
        [self gethpinterface];
    }
    else if(([app.userinfo.userid length]==0)&&((![app.userinfo.usertype isEqualToString:@"tourists"])))
    {
        LoginView *login = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        login.delegate1 = self;
        [app.window addSubview:login];
    }
    
    [hpnav removeFromSuperview];
    hpnav = nil;
    hpnav = [[HpNavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    hpnav.delegate1 = self;
    hpnav.tag = EnHpNavigationBgTag;
    [hpnav initViewHP];
    [self.navigationController.navigationBar addSubview:hpnav];
    
    if([app.FCDisplayShoppingCar isEqualToString:@"1"])
    {
        [self.tabBarController setSelectedIndex:2];
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
    float widthnow = (SCREEN_WIDTH-30)/2;
    return widthnow+65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraydata count]==0?0:([arraydata count]+1)/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = COLORNOW(245, 245, 245);
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, (SCREEN_WIDTH-120)/2, 1)];
    imageviewline.backgroundColor = COLORNOW(200, 200, 200);
    [view addSubview:imageviewline];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageviewline), 15, 100, 20)];
    label.text = @"特惠商品";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(label), 25, (SCREEN_WIDTH-120)/2, 1)];
    imageviewline1.backgroundColor = COLORNOW(200, 200, 200);
    [view addSubview:imageviewline1];
    
    return view;
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
    
    float widthnow = (SCREEN_WIDTH-30)/2;
    if([arraydata count]>indexPath.row*2)
    {
        NSDictionary *dictemp1 = [arraydata objectAtIndex:indexPath.row*2];
        UIView *discount1 = [self SpecialDiscountGoods:CGRectMake(10, 10, widthnow, widthnow+55) Dic:dictemp1 TagNow:(int)indexPath.row*2];
        [cell.contentView addSubview:discount1];
    }
    
    if([arraydata count]>indexPath.row*2+1)
    {
        NSDictionary *dictemp2 = [arraydata objectAtIndex:indexPath.row*2+1];
        UIView *discount2 = [self SpecialDiscountGoods:CGRectMake(SCREEN_WIDTH/2+5, 10, widthnow, widthnow+55) Dic:dictemp2 TagNow:(int)indexPath.row*2+1];
        [cell.contentView addSubview:discount2];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - 获取首页数据
-(void)gethpinterface
{
    HpService *discount = [HpService new];
    //推荐商品
    [discount sendRecommendRequest:@"1" PageSize:@"20" App:app ReqUrl:RQRecommend successBlock:^(NSDictionary *dicData) {
        
        [tableview.mj_header endRefreshing];
        NSArray *recommendarraydata = [dicData objectForKey:@"rows"];
        UIView *viewrecommend = [self RecommendGoods:CGRectMake(0, 0, SCREEN_WIDTH, 170) RecommendData:recommendarraydata];
        [tableview setTableHeaderView:viewrecommend];
        DLog(@"dicdata====%@",dicData);
    }];
    
    //特惠商品
    [discount sendDiscountRequest:@"1" PageSize:@"20" App:app ReqUrl:RQDiscount successBlock:^(NSDictionary *dicData) {
        [tableview.mj_header endRefreshing];
        tableview.delegate = self;
        tableview.dataSource = self;
        arraydata = [dicData objectForKey:@"rows"];
        [tableview reloadData];
    }];
    
}

-(void)getNewVersion
{
    LoginService *loginservice = [LoginService new];
    [loginservice sendGetVersionrequest:@"ios" App:app ReqUrl:RQGetVersion successBlock:^(NSDictionary *dicData) {
        DLog(@"dicdata=====%@",dicData);
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
        
        NSDictionary *dictemp = [dicData objectForKey:@"version"];
        if([dictemp count]>0)
        {
            
            NSString *serversion = [dictemp objectForKey:@"version"];
            if(![serversion isEqualToString:currentVersion])
            {
                
                [self popAlertSheetView:@"有新版本,你需要更新吗?"];
            }
        }

        
    }];
}

-(void)getHpDiscory
{
    HpService *discory = [HpService new];
    [discory sendGetDiscoryRequest:app ReqUrl:RQGetHpDiscory successBlock:^(NSDictionary *dicData) {
        NSDictionary *dic = [dicData objectForKey:@"discovery"];
        if([[dic objectForKey:@"isDiscovery"] isEqualToString:@"true"])
        {
            hpnav.buttondiscovery.hidden = NO;
            FCDiscoryUrl = [dic objectForKey:@"url"];
        }
        else
        {
            hpnav.buttondiscovery.hidden = YES;
        }
    }];
}

#pragma mark - popalertview
-(void)popAlertSheetView:(NSString *)popstr
{
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = popstr;
    NSString *canelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *canelAction = [UIAlertAction actionWithTitle:canelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSString *postUrl = @"https://itunes.apple.com/us/app/菜篮子食材/id1357517793?l=zh&ls=1&mt=8";
        postUrl = [postUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  //      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl]];
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:postUrl] options:@{} completionHandler:nil];
        DLog(@"posturl===%@",postUrl);
        
    }];
    
    // Add the actions.
    [alertController addAction:otherAction];
    [alertController addAction:canelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)getuserinfo
{
    SettingService *setservice = [SettingService new];
    
    [setservice sendGetUserInfoRequest:app.userinfo.userid App:app ReqUrl:RQMyUserCenter successBlock:^(NSDictionary *dicData) {
        NSDictionary *dicuser = [dicData objectForKey:@"user"];
        app.userinfo.usertype = [dicuser objectForKey:@"userType"];
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
