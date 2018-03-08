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
    
    if(![app.userinfo.usertype isEqualToString:@"1"])
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
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
    imageviewline.backgroundColor = COLORNOW(210, 210, 210);
    [viewbottom addSubview:imageviewline];
    
    UIImageView *imageviewshopcar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 24, 21)];
    imageviewshopcar.image = LOADIMAGE(@"购物车选择后", @"png");
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickshopcar:)];
    imageviewshopcar.userInteractionEnabled = YES;
    [imageviewshopcar addGestureRecognizer:recognizer];
    [viewbottom addSubview:imageviewshopcar];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100, 40);
    [button setTitle:@"加入购物车" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    button.backgroundColor = COLORNOW(32, 188, 167);
    [button addTarget:self action:@selector(clickaddtarget:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewbottom addSubview:button];
    
}

-(UIView *)popbuyproductview:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(view));
    button.backgroundColor = [UIColor blackColor];
    button.alpha = 0.2;
    [button addTarget:self action:@selector(removepopbuyview:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *viewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewHeight(view)-200, XYViewWidth(button), 200)];
    viewbg.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewbg];
    
    NSDictionary *dictemp;
    if([arrayfocus count]>0)
        dictemp = [arrayfocus objectAtIndex:0];
    NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dictemp objectForKey:@"picture_pictureUrl"]];
    UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(10, XYViewTop(viewbg)+10, 80, 80)];
    [imagepic setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
    imagepic.layer.cornerRadius = 3.0f;
    imagepic.clipsToBounds = YES;
    [view addSubview:imagepic];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imagepic)+10,XYViewBottom(imagepic)-40, 200, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dicproduct objectForKey:@"salePrice"],[dicproduct objectForKey:@"displayUnit"]];
    labelprice.font = FONTN(15.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [view addSubview:labelprice];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelprice), XYViewBottom(labelprice), 200, 20)];
    labelName.text = [dicproduct objectForKey:@"name"];
    labelName.font = FONTN(15.0f);
    labelName.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelName];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagepic), XYViewBottom(imagepic)+30, 50, 20)];
    labeltitle.text = @"数量";
    labeltitle.font = FONTN(15.0f);
    labeltitle.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labeltitle];
    
    //减少
    UIButton *buttonreduce = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonreduce.frame = CGRectMake(XYViewR(imagepic)+10, XYViewTop(labeltitle)-10, 40, 40);
    [buttonreduce setImage:LOADIMAGE(@"reduceicon", @"png") forState:UIControlStateNormal];
    [buttonreduce addTarget:self action:@selector(clickreduceproduct:) forControlEvents:UIControlEventTouchUpInside];
    buttonreduce.tag = EnShopCarReduceBtTag;
    [view addSubview:buttonreduce];
    
    UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(buttonreduce), XYViewTop(buttonreduce), 25, 40)];
    labelnum.text = @"1";
    labelnum.textAlignment = NSTextAlignmentCenter;
    labelnum.font = FONTN(15.0f);
    labelnum.textColor = COLORNOW(52, 52, 52);
    labelnum.tag = EnShopCarLabelNumTag;
    [view addSubview:labelnum];
    
    //增加
    UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonadd.frame = CGRectMake(XYViewR(labelnum), XYViewTop(buttonreduce), 40, 40);
    [buttonadd setImage:LOADIMAGE(@"addicon", @"png") forState:UIControlStateNormal];
    [buttonadd addTarget:self action:@selector(clickaddproduct:) forControlEvents:UIControlEventTouchUpInside];
    buttonadd.tag = EnShopCarAddBtTag;
    [view addSubview:buttonadd];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewHeight(view)-40, SCREEN_WIDTH, 0.7)];
    imageviewline.backgroundColor = COLORNOW(210, 210, 210);
    [view addSubview:imageviewline];
    
    UIImageView *imageviewshopcar = [[UIImageView alloc] initWithFrame:CGRectMake(10, XYViewBottom(imageviewline)+9, 24, 21)];
    imageviewshopcar.image = LOADIMAGE(@"购物车选择后", @"png");
    [view addSubview:imageviewshopcar];
    
    UIButton *buttonaddshopcar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonaddshopcar.frame = CGRectMake(SCREEN_WIDTH-130, XYViewBottom(imageviewline), 130, 40);
    [buttonaddshopcar setTitle:@"立即加入购物车" forState:UIControlStateNormal];
    buttonaddshopcar.titleLabel.font = FONTN(15.0f);
    buttonaddshopcar.backgroundColor = COLORNOW(32, 188, 167);
    [buttonaddshopcar addTarget:self action:@selector(clickaddshoppingcar:) forControlEvents:UIControlEventTouchUpInside];
    [buttonaddshopcar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:buttonaddshopcar];
    
    return view;
}


-(UIView *)getsectiononecellview:(NSDictionary *)dic Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,10, SCREEN_WIDTH-20, 20)];
    labelname.text = [dic objectForKey:@"name"];
    labelname.font = FONTB(17.0f);
    labelname.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelname];
    
    UILabel *labelsummary = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname),XYViewBottom(labelname)+5, SCREEN_WIDTH-20, 20)];
    labelsummary.text = [dic objectForKey:@"summary"];
    labelsummary.font = FONTN(14.0f);
    labelsummary.textColor = COLORNOW(152, 152, 152);
    [view addSubview:labelsummary];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelsummary)+5, 100, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dic objectForKey:@"salePrice"],[dic objectForKey:@"displayUnit"]];
    labelprice.font = FONTN(14.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [view addSubview:labelprice];
    
    return view;
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
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickaddtarget:(id)sender
{
    viewpopbuy =  [self popbuyproductview:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin)];
    [self.view addSubview:viewpopbuy];
   
}

-(void)clickaddshoppingcar:(id)sender
{
    UILabel *labelnum = [viewpopbuy viewWithTag:EnShopCarLabelNumTag];
    [self addshoppingcar:_FCGoodsId UserId:app.userinfo.userid ProductNumber:labelnum.text];
    
    [self removepopbuyview:nil];
}

-(void)removepopbuyview:(id)sender
{
    [viewpopbuy removeFromSuperview];
    viewpopbuy = nil;
}

-(void)clickaddproduct:(id)sender
{
    UILabel *labelnum = [viewpopbuy viewWithTag:EnShopCarLabelNumTag];
    
    int numnow = [labelnum.text intValue];
    if(numnow+1>99)
    {
        [MBProgressHUD showError:@"单一商品最大数量订购99件" toView:app.window];
    }
    else
    {
        labelnum.text = [NSString stringWithFormat:@"%d",numnow+1];
    }
}

-(void)clickreduceproduct:(id)sender
{
    UILabel *labelnum = [viewpopbuy viewWithTag:EnShopCarLabelNumTag];
    
    int numnow = [labelnum.text intValue];
    if(numnow-1<1)
    {
        [MBProgressHUD showError:@"单一商品最小数量订购1件" toView:app.window];
    }
    else
    {
        labelnum.text = [NSString stringWithFormat:@"%d",numnow-1];
    }
}

-(void)clickshopcar:(id)sender
{
    app.FCDisplayShoppingCar = @"1";
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    if([arrayattributes count]>0)
        return 2;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 90;
    return 46;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
        return [arrayattributes count]>0?[arrayattributes count]+1:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
        return 10;
    else
        return 0.01;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        imageline.backgroundColor = COLORNOW(235, 235, 235);
        return imageline;
    }
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

    
    if(indexPath.section == 0)
    {
        UIView *view = [self getsectiononecellview:dicproduct Frame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        [cell.contentView addSubview:view];
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10,100,20)];
            labeltitle.text = @"规格";
            labeltitle.font = FONTB(17.0f);
            labeltitle.textColor = COLORNOW(52, 52, 52);
            [cell.contentView addSubview:labeltitle];
        }
        else
        {
            NSDictionary *dictemp = [arrayattributes objectAtIndex:indexPath.row-1];
            
            UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10,130,20)];
            labeltitle.text = [dictemp objectForKey:@"productAttribute_name"];
            labeltitle.font = FONTB(15.0f);
            labeltitle.textColor = COLORNOW(52, 52, 52);
            [cell.contentView addSubview:labeltitle];
            
            UILabel *labelvale = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100,10,90,20)];
            labelvale.text = [dictemp objectForKey:@"basicValue"];
            labelvale.font = FONTB(15.0f);
            labelvale.textAlignment = NSTextAlignmentRight;
            labelvale.textColor = COLORNOW(152, 152, 152);
            [cell.contentView addSubview:labelvale];
            
        }
        
        
    }
    
    
    
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


-(void)addshoppingcar:(NSString *)goodsid UserId:(NSString *)userid ProductNumber:(NSString *)productnumber
{
    GoodsDetailService *goodsdetail = [GoodsDetailService new];
    [goodsdetail sendaddShoppingCarRequest:goodsid UserId:userid ProductNumber:productnumber App:app ReqUrl:RQAddShoppingCar successBlock:^(NSDictionary *dicData) {
       
        [MBProgressHUD showSuccess:[dicData objectForKey:@"resultInfo"] toView:app.window];
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
