//
//  DeliveryViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "DeliveryViewController.h"

@interface DeliveryViewController ()

@end

@implementation DeliveryViewController

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
    self.title = @"送货单";
    deliverystate = @"";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-40) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    [self getmydeliverylist];
    
    [self initheaderview];
}

-(void)initheaderview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    float widthnow = SCREEN_WIDTH/3;
    
    for(int i=0;i<3;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(widthnow*i,0, widthnow, 40);
        if(i==0)
        {
            [button setTitle:@"全部" forState:UIControlStateNormal];
        }
        else if(i==1)
        {
            [button setTitle:@"未送货" forState:UIControlStateNormal];
        }
        else if(i==2)
        {
            [button setTitle:@"已送货" forState:UIControlStateNormal];
        }
        button.titleLabel.font = FONTN(15.0f);
        [button setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickdeliverystate:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+EnMyOrderListStateBtTag;
        [view addSubview:button];
    }
    float spacenow = 20;
    selectline = [[UIImageView alloc] initWithFrame:CGRectMake(spacenow, XYViewHeight(view)-3, widthnow-40, 3)];
    selectline.backgroundColor = COLORNOW(32, 188, 167);
    [view addSubview:selectline];
    
    [self.view addSubview:view];
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
    labelcode.text = [NSString stringWithFormat:@"订单编号:%@",[dic objectForKey:@"order_orderNo"]];
    labelcode.font = FONTB(16.0f);
    labelcode.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelcode];
    
    UILabel *labelstate = [[UILabel alloc] initWithFrame:CGRectMake(XYViewWidth(view)-100,XYViewTop(imageline1)-30, 90, 20)];
    labelstate.text = [dic objectForKey:@"order_disDeliveryStateForDeliveryUser"];
    labelstate.font = FONTN(16.0f);
    labelstate.textAlignment = NSTextAlignmentRight;
    labelstate.textColor = COLORNOW(255, 110, 64);
    [view addSubview:labelstate];
    
    UILabel *labelreceiveuser = [[UILabel alloc] initWithFrame:CGRectMake(10,XYViewTop(imageline1)+10, 60, 20)];
    labelreceiveuser.text = @"收货人:";
    labelreceiveuser.font = FONTB(16.0f);
    labelreceiveuser.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelreceiveuser];
    
    UILabel *labelreceiveuservalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelreceiveuser),XYViewTop(imageline1)+10, 250, 20)];
    labelreceiveuservalue.text = [dic objectForKey:@"order_userAddress_userName"];
    labelreceiveuservalue.font = FONTN(15.0f);
    labelreceiveuservalue.textColor = COLORNOW(152, 152, 152);
    [view addSubview:labelreceiveuservalue];
    
    NSString *strtel = [dic objectForKey:@"order_userAddress_mobile"];
    CommonHeader *com = [CommonHeader new];
    CGSize sizetel = [com CMGetlablesize:strtel Fwidth:120 Fheight:20 Sfont:FONTN(15.0f) Spaceing:2.0f];
    
    UILabel *labelreceivetelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-sizetel.width-10,XYViewTop(imageline1)+10, sizetel.width, sizetel.height)];
    labelreceivetelvalue.text = [dic objectForKey:@"order_userAddress_mobile"];
    labelreceivetelvalue.font = FONTN(15.0f);
    labelreceivetelvalue.textAlignment = NSTextAlignmentRight;
    labelreceivetelvalue.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelreceivetelvalue];
    
    UILabel *labelreceivetel = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelreceivetelvalue)-50,XYViewTop(imageline1)+10,50, 20)];
    labelreceivetel.text = @"电话:";
    labelreceivetel.font = FONTB(16.0f);
    labelreceivetel.textAlignment = NSTextAlignmentRight;
    labelreceivetel.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelreceivetel];
    
    UILabel *labeladdress = [[UILabel alloc] initWithFrame:CGRectMake(10, XYViewBottom(labelreceivetel)+5,75, 20)];
    labeladdress.text = @"收货地址:";
    labeladdress.font = FONTB(16.0f);
    labeladdress.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labeladdress];
    
    NSString *straddress = [NSString stringWithFormat:@"%@%@%@%@",[dic objectForKey:@"order_userAddress_province"],[dic objectForKey:@"order_userAddress_city"],[dic objectForKey:@"order_userAddress_county"],[dic objectForKey:@"order_userAddress_address"]];
    CGSize size = [com CMGetlablesize:straddress Fwidth:SCREEN_WIDTH-90 Fheight:40 Sfont:FONTN(15.0f) Spaceing:2.0f];
    
    UILabel *labeladdressvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labeladdress),XYViewTop(labeladdress), size.width, size.height)];
    labeladdressvalue.text = straddress;
    labeladdressvalue.font = FONTN(15.0f);
    labeladdressvalue.numberOfLines = 0;
    labeladdressvalue.textColor = COLORNOW(122, 122,122);
    [view addSubview:labeladdressvalue];
    
    UILabel *labelsendtime = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeladdress), XYViewBottom(labeladdress)+20,105, 20)];
    labelsendtime.text = @"要求送达时间:";
    labelsendtime.font = FONTB(16.0f);
    labelsendtime.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelsendtime];
    
    UILabel *labelsendtimevalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelsendtime), XYViewTop(labelsendtime),150, 20)];
    labelsendtimevalue.text = [dic objectForKey:@"deliveryTime"];
    labelsendtimevalue.font = FONTB(16.0f);
    labelsendtimevalue.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelsendtimevalue];
    
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
    [PTLoadingHubView dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdeliverystate:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag] - EnMyOrderListStateBtTag;
    selectline.frame = CGRectMake(XYViewL(button)+20, XYViewTop(selectline), XYViewWidth(selectline), XYViewHeight(selectline));
    
    if(tagnow == 0)
        deliverystate = @"";
    else if(tagnow == 1)
        deliverystate = @"2";
    else
        deliverystate = @"3";
    [self getmydeliverylist];
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
    return 145;
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
    UIView *view = [self ViewCell:CGRectMake(0, 0, SCREEN_WIDTH, 145) Dic:dictemp IndexPath:indexPath];
    [cell.contentView addSubview:view];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    DeliveryDetailViewController *orderdetail = [[DeliveryDetailViewController alloc] init];
    orderdetail.FCorderid = [dictemp objectForKey:@"order_id"];
    [self.navigationController pushViewController:orderdetail animated:YES];
}

#pragma mark - 接口
-(void)getmydeliverylist
{
    DeliveryService *delivery = [DeliveryService new];
    [delivery sendDeliveryListRequest:app.userinfo.userid DeliveryState:deliverystate App:app ReqUrl:RQDeliveryList successBlock:^(NSDictionary *dicData) {
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
