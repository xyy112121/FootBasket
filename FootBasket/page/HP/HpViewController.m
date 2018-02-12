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
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor =  COLORNOW(32, 188, 167);
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
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
    
    
}

//精品推荐
-(UIView *)RecommendGoods:(CGRect)frame RecommendData:(NSArray *)arrayrecommend
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 5, 20)];
    imageviewline.backgroundColor = COLORNOW(32, 188, 167);
    [view addSubview:imageviewline];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageviewline)+5, XYViewTop(imageviewline), 100, 20)];
    label.text = @"精品推荐";
    [view addSubview:label];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-10, XYViewHeight(view)-60)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    [view addSubview:scrollview];
    
    for(int i=0;i<[arrayrecommend count];i++)
    {
        NSDictionary *dictemp = [arrayrecommend objectAtIndex:i];
        RecommendGoodsCell *cell = [[RecommendGoodsCell alloc] initWithFrame:CGRectMake(260*i,0, 250, 100) DicRecommend:dictemp];
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
    [view addSubview:labelname];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, XYViewWidth(view)-50, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dic objectForKey:@"salePrice"],[dic objectForKey:@"displayUnit"]];
    labelprice.font = FONTN(15.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [view addSubview:labelprice];
    
    UIButton *buttonshoppingcar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonshoppingcar.frame = CGRectMake(XYViewWidth(view)-40,XYViewHeight(view)-35, 40, 40);
    [buttonshoppingcar setImage:LOADIMAGE(@"加入购物车small", @"png") forState:UIControlStateNormal];
    buttonshoppingcar.backgroundColor = [UIColor clearColor];
    buttonshoppingcar.tag = EnHpDiscountShopCarBtTag+tagnow;
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

#pragma mark - ActionDelegate
-(void)DGLoginSuccess:(id)sender
{
    [self gethpinterface];
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
    
    if(app.userinfo.userid)
    {
        [self gethpinterface];
    }
    else
    {
        LoginView *login = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        login.delegate1 = self;
        [app.window addSubview:login];
    }
    
    [hpnav removeFromSuperview];
    hpnav = nil;
    hpnav = [[HpNavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    hpnav.tag = EnHpNavigationBgTag;
    [hpnav initViewHP];
    [self.navigationController.navigationBar addSubview:hpnav];
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
    [discount sendRecommendRequest:@"1" PageSize:@"10" App:app ReqUrl:RQRecommend successBlock:^(NSDictionary *dicData) {
        
        NSArray *recommendarraydata = [dicData objectForKey:@"rows"];
        UIView *viewrecommend = [self RecommendGoods:CGRectMake(0, 0, SCREEN_WIDTH, 160) RecommendData:recommendarraydata];
        [tableview setTableHeaderView:viewrecommend];
        DLog(@"dicdata====%@",dicData);
    }];
    
    //特惠商品
    [discount sendDiscountRequest:@"1" PageSize:@"10" App:app ReqUrl:RQDiscount successBlock:^(NSDictionary *dicData) {

        tableview.delegate = self;
        tableview.dataSource = self;
        arraydata = [dicData objectForKey:@"rows"];
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
