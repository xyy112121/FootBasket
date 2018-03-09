//
//  MyViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

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
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-49) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
    
    [self setExtraCellLineHidden:tableview];

    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, StatusBarHeight, 50, 40)];
    [button setTitle:@"设置"forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    button.titleLabel.font = FONTN(15.0f);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action: @selector(gotosetting:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)initheaderview
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 290)];
    viewheader.backgroundColor = [UIColor whiteColor];

//    UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
//    imageviewbg.backgroundColor = [UIColor whiteColor];
//    [viewheader addSubview:imageviewbg];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    imageview.image = LOADIMAGE(@"top-bg", @"png");
    [viewheader addSubview:imageview];
    
    buttonheader = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonheader.frame = CGRectMake(0, 0, 56, 56);
    buttonheader.layer.cornerRadius = 28.0f;
    buttonheader.clipsToBounds = YES;
    buttonheader.layer.borderColor = [UIColor whiteColor].CGColor;
    buttonheader.layer.borderWidth = 2.0f;
    buttonheader.imageView.contentMode = UIViewContentModeScaleAspectFill;
    buttonheader.imageView.clipsToBounds = YES;
    [buttonheader setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URLPicHeader,app.userinfo.userheader]] placeholderImage:LOADIMAGE(@"个人头像", @"png")];
    buttonheader.center = CGPointMake(SCREEN_WIDTH/2, 80);
    [viewheader addSubview:buttonheader];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, XYViewBottom(buttonheader)+5,150, 20)];
    labelname.text = app.userinfo.usernickname;
    labelname.backgroundColor = [UIColor clearColor];
    labelname.font = FONTN(15.0f);
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor whiteColor];
    [viewheader addSubview:labelname];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 1)];
    imageviewline.backgroundColor = COLORNOW(240, 240, 240);
    [viewheader addSubview:imageviewline];
    
    UIButton *buttonorder = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonorder.frame = CGRectMake(SCREEN_WIDTH-100, XYViewTop(imageviewline)-35, 80, 30);
    [buttonorder setTitleColor:COLORNOW(172, 172, 172) forState:UIControlStateNormal];
    [buttonorder setTitle:@"全部订单" forState:UIControlStateNormal];
    buttonorder.backgroundColor = [UIColor clearColor];
    [buttonorder setImage:LOADIMAGE(@"arrow_left", @"png") forState:UIControlStateNormal];
    buttonorder.titleLabel.font = FONTN(15.0f);
    [buttonorder setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -130)];
    [buttonorder setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [viewheader addSubview:buttonorder];
    
    //待收货
    float nowwidth = (SCREEN_WIDTH-120)/4;
    if([app.userinfo.usertype isEqualToString:@"0"])
    {
        UIButton *imagewaitreceive = [UIButton buttonWithType:UIButtonTypeCustom];
        imagewaitreceive.frame = CGRectMake(30, XYViewBottom(imageviewline)+5, nowwidth, 50);
        imagewaitreceive.backgroundColor = [UIColor clearColor];
        [imagewaitreceive setImage:LOADIMAGE(@"待收货", @"png") forState:UIControlStateNormal];
        [imagewaitreceive addTarget:self action:@selector(clickwaitorderlist:) forControlEvents:UIControlEventTouchUpInside];
        [viewheader addSubview:imagewaitreceive];
        
        UILabel *labelleft = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagewaitreceive), XYViewBottom(imagewaitreceive)-5, XYViewWidth(imagewaitreceive), 20)];
        labelleft.text = @"待收货";
        labelleft.backgroundColor = [UIColor clearColor];
        labelleft.font = FONTN(15.0f);
        labelleft.textAlignment = NSTextAlignmentCenter;
        labelleft.textColor = COLORNOW(51, 51, 51);
        [viewheader addSubview:labelleft];
        
        //已收货
        UIButton *imagereceived = [UIButton buttonWithType:UIButtonTypeCustom];
        imagereceived.frame = CGRectMake(30+XYViewR(imagewaitreceive), XYViewTop(imagewaitreceive), nowwidth, 50);
        imagereceived.backgroundColor = [UIColor clearColor];
        [imagereceived setImage:LOADIMAGE(@"已收货", @"png") forState:UIControlStateNormal];
        [imagereceived addTarget:self action:@selector(clickreceiveorderlist:) forControlEvents:UIControlEventTouchUpInside];
        
        [viewheader addSubview:imagereceived];
        
        UILabel *labelmiddle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagereceived), XYViewBottom(imagereceived)-5, XYViewWidth(imagereceived), 20)];
        labelmiddle.text = @"已收货";
        labelmiddle.backgroundColor = [UIColor clearColor];
        labelmiddle.font = FONTN(15.0f);
        labelmiddle.textAlignment = NSTextAlignmentCenter;
        labelmiddle.textColor = COLORNOW(51, 51, 51);
        [viewheader addSubview:labelmiddle];
        
        //我的优惠
        UIButton *imagecoupon = [UIButton buttonWithType:UIButtonTypeCustom];
        imagecoupon.frame = CGRectMake(30+XYViewR(imagereceived), XYViewTop(imagereceived), nowwidth, 50);
        imagecoupon.backgroundColor = [UIColor clearColor];
        [imagecoupon setImage:LOADIMAGE(@"优惠券", @"png") forState:UIControlStateNormal];
        [imagecoupon addTarget:self action:@selector(clickmycoupon:) forControlEvents:UIControlEventTouchUpInside];
        [viewheader addSubview:imagecoupon];
        
        UILabel *labelcoupon = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagecoupon)-10, XYViewBottom(imagecoupon)-5, XYViewWidth(imagecoupon)+20, 20)];
        labelcoupon.text = @"我的钱包";
        labelcoupon.backgroundColor = [UIColor clearColor];
        labelcoupon.font = FONTN(15.0f);
        labelcoupon.textAlignment = NSTextAlignmentCenter;
        labelcoupon.textColor = COLORNOW(51, 51, 51);
        [viewheader addSubview:labelcoupon];
    }
    //送货单
    else if([app.userinfo.usertype isEqualToString:@"1"])
    {
        UIButton *imagedelivery = [UIButton buttonWithType:UIButtonTypeCustom];
        imagedelivery.frame = CGRectMake(30, XYViewBottom(imageviewline)+5, nowwidth, 50);
        imagedelivery.backgroundColor = [UIColor clearColor];
        [imagedelivery setImage:LOADIMAGE(@"待发货", @"png") forState:UIControlStateNormal];
        [imagedelivery addTarget:self action:@selector(clickdelivery:) forControlEvents:UIControlEventTouchUpInside];
        [viewheader addSubview:imagedelivery];
        
        UILabel *labeldelivery = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagedelivery)-10, XYViewBottom(imagedelivery)-5, XYViewWidth(imagedelivery)+20, 20)];
        labeldelivery.text = @"送货单";
        labeldelivery.backgroundColor = [UIColor clearColor];
        labeldelivery.font = FONTN(15.0f);
        labeldelivery.textAlignment = NSTextAlignmentCenter;
        labeldelivery.textColor = COLORNOW(51, 51, 51);
        [viewheader addSubview:labeldelivery];
    }
    tableview.tableHeaderView = viewheader;
}

-(void)contactCustomer
{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *showAllInfoAction = [UIAlertAction actionWithTitle:@"客服A" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableString *str2=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15812002697"];
        
        NSLog(@"%@",str2);
        
        UIWebView * callWebview = [[UIWebView alloc] init];
        
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str2]]];
        
        [self.view addSubview:callWebview];
        
    }];
    UIAlertAction *pickAction = [UIAlertAction actionWithTitle:@"客服B" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableString *str2=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15398679337"];
        
        NSLog(@"%@",str2);
        
        UIWebView * callWebview = [[UIWebView alloc] init];
        
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str2]]];
        
        [self.view addSubview:callWebview];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:showAllInfoAction];
    [actionSheetController addAction:pickAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

#pragma mark - IBAction
-(void)gotosetting:(id)sender
{
    SettingViewController *settingview = [[SettingViewController alloc] init];
    settingview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingview animated:YES];
}

-(void)clickwaitorderlist:(id)sender
{
    UserOrderViewController *userorder = [[UserOrderViewController alloc] init];
    userorder.hidesBottomBarWhenPushed = YES;
    userorder.orderstate = @"2";
    [self.navigationController pushViewController:userorder animated:YES];
}

-(void)clickreceiveorderlist:(id)sender
{
    UserOrderViewController *userorder = [[UserOrderViewController alloc] init];
    userorder.hidesBottomBarWhenPushed = YES;
    userorder.orderstate = @"3";
    [self.navigationController pushViewController:userorder animated:YES];
}

-(void)clickdelivery:(id)sender
{
    DeliveryViewController *delivery = [[DeliveryViewController alloc] init];
    delivery.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:delivery animated:YES];
}

-(void)clickmycoupon:(id)sender
{
    MyCouponViewController *mycoupon = [[MyCouponViewController alloc] init];
    mycoupon.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mycoupon animated:YES];
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
    
    [self.navigationController setNavigationBarHidden:YES];
    if([app.userinfo.userheader length]>0)
        [buttonheader setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLPicHeader,app.userinfo.userheader]] placeholderImage:LOADIMAGE(@"个人头像", @"png")];
    
    [self initheaderview];
    [tableview reloadData];
    NSFileManager *filemanger = [NSFileManager defaultManager];
    if(![filemanger fileExistsAtPath:Cache_UserInfo])
    {
        [self.tabBarController setSelectedIndex:0];
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
    if([app.userinfo.usertype isEqualToString:@"1"])
        return 2;
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([app.userinfo.usertype isEqualToString:@"1"])
    {
        if(section == 0)
            return 1;
    }
    else
    {
        if(section == 0)
            return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 10)];
    imageviewline.backgroundColor = COLORNOW(240, 240, 240);
    return imageviewline;
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
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [cell.contentView addSubview:imageview];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10, 10, 100, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.font = FONTN(15.0f);
    labelname.textColor = COLORNOW(51, 51, 51);
    [cell.contentView addSubview:labelname];
    
    if([app.userinfo.usertype isEqualToString:@"0"])
    {
        switch (indexPath.section)
        {
            case 0:
                switch (indexPath.row)
                {
                    case 0:
                        imageview.image = LOADIMAGE(@"关于我们ICON", @"png");
                        labelname.text = @"关于我们";
                        break;
                    case 1:
                        imageview.image = LOADIMAGE(@"收货地址icon", @"png");
                        labelname.text = @"我的收货地址";
                        break;
                }
                break;
//            case 1:
//                imageview.image = LOADIMAGE(@"礼物", @"png");
//                labelname.text = @"邀请有礼";
//                break;
            case 1:
                imageview.image = LOADIMAGE(@"电话", @"png");
                labelname.text = @"联系客服";
                break;

        }
    }
    else if([app.userinfo.usertype isEqualToString:@"1"])
    {
        switch (indexPath.section)
        {
            case 0:
                imageview.image = LOADIMAGE(@"关于我们ICON", @"png");
                labelname.text = @"关于我们";
                break;
            case 1:
                imageview.image = LOADIMAGE(@"电话", @"png");
                labelname.text = @"联系客服";
                break;
                
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([app.userinfo.usertype isEqualToString:@"0"])
    {
        MyAddrListViewController *myaddrlist;
        AboutMeViewController *aboutme;
        switch (indexPath.section)
        {
            case 0:
                switch (indexPath.row)
                {
                    case 0:
                        aboutme = [[AboutMeViewController alloc] init];
                        aboutme.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:aboutme animated:YES];
                        break;
                    case 1:
                        myaddrlist = [[MyAddrListViewController alloc] init];
                        myaddrlist.hidesBottomBarWhenPushed = YES;
                        myaddrlist.fromflag = @"2";
                        [self.navigationController pushViewController:myaddrlist animated:YES];
                        break;
                }
                break;
            case 1:
                [self contactCustomer];
                break;
                
        }
    }
    else if([app.userinfo.usertype isEqualToString:@"1"])
    {
        switch (indexPath.section)
        {
            case 0:
                break;
            case 1:
                [self contactCustomer];
                break;
                
        }
    }
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
