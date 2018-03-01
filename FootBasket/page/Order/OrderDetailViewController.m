//
//  OrderDetailViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

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
    self.title = @"订单详情";
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-50) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    [self getorderdetail];
    
    
    buttonreceivedone = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonreceivedone.frame = CGRectMake(0, SCREEN_HEIGHT-50-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin, SCREEN_WIDTH, 50);
    [buttonreceivedone setTitle:@"确认收货" forState:UIControlStateNormal];
    buttonreceivedone.titleLabel.font = FONTN(15.0f);
    [buttonreceivedone setBackgroundColor:COLORNOW(250, 111, 73)];
    [buttonreceivedone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonreceivedone addTarget:self action:@selector(clickreceivedone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonreceivedone];
    
}

//确认收货
-(void)viewbottomSettlement:(CGRect)frame
{
    UIView *viewbottom = [[UIView alloc] initWithFrame:frame];
    viewbottom.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [viewbottom addSubview:imageline];
    
    UILabel *labelall = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 15, 35, 20)];
    labelall.textColor = COLORNOW(52, 52, 52);
    labelall.font = FONTN(15.0f);
    labelall.text = @"合计";
    [viewbottom addSubview:labelall];
    
    UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelall), 15, 85, 20)];
    labelmoney.textColor = COLORNOW(248, 88, 37);
    labelmoney.font = FONTN(15.0f);
    labelmoney.text = [NSString stringWithFormat:@"￥%@",[dicresponse objectForKey:@"realPayPrice"]];
    [viewbottom addSubview:labelmoney];
    
    UILabel *labelproductnum = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelall)-100, 15, 95, 20)];
    labelproductnum.textColor = COLORNOW(52, 52, 52);
    labelproductnum.font = FONTN(15.0f);
    labelproductnum.text = [NSString stringWithFormat:@"共计%ld款产品",[arraydata count]];
    [viewbottom addSubview:labelproductnum];
    
    UILabel *labelpay = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 85, 20)];
    labelpay.textColor = COLORNOW(248, 88, 37);
    labelpay.font = FONTN(15.0f);
    labelpay.text = [dicresponse objectForKey:@"displayIsPay"];
    [viewbottom addSubview:labelpay];
    
    
    tableview.tableFooterView = viewbottom;
}

//地址选择
-(UIView *)viewaddrcell:(CGRect)frame
{
    UIView *viewaddr = [[UIView alloc] initWithFrame:frame];
    viewaddr.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dicarrd = [dicresponse objectForKey:@"address"];
    UIImageView *imageaddricon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 14, 18)];
    imageaddricon.image = LOADIMAGE(@"地址icon", @"png");
    [viewaddr addSubview:imageaddricon];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(imageaddricon)+5, 8, SCREEN_WIDTH-100, 30)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.text = [NSString stringWithFormat:@"%@%@%@%@",[dicarrd objectForKey:@"province"],[dicarrd objectForKey:@"city"],[dicarrd objectForKey:@"county"],[dicarrd objectForKey:@"address"]];
    textfield.font = FONTN(15.0f);
    textfield.enabled = NO;
    textfield.textColor = COLORNOW(52, 52, 52);
    [viewaddr addSubview:textfield];
    
    UIImageView *arrawleft = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-17, 14, 7, 15)];
    arrawleft.image = LOADIMAGE(@"arrow_left", @"png");
    [viewaddr addSubview:arrawleft];
    
    UIImageView *imagebottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewHeight(viewaddr)-3, SCREEN_WIDTH, 3)];
    imagebottom.image = LOADIMAGE(@"彩色分割条", @"png");
    [viewaddr addSubview:imagebottom];
    
    return viewaddr;
}

//商品列表
//cell
-(UIView *)ViewCell:(CGRect)frame Dic:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    
    float noworginx = 10;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(noworginx, 10, 40, 40)];
    NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dic objectForKey:@"headPicture"]];
    [imageview setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview), XYViewWidth(view)-100, 20)];
    labelname.text = [dic objectForKey:@"name"];
    labelname.font = FONTN(16.0f);
    labelname.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelname];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname), XYViewWidth(view)-50, 20)];
    labelprice.text = [NSString stringWithFormat:@"单价:￥%@元 数量:%@",[dic objectForKey:@"salePrice"],[dic objectForKey:@"count"]];
    labelprice.font = FONTN(14.0f);
    labelprice.textColor = COLORNOW(122, 122, 122);
    [view addSubview:labelprice];
    
    NSString *strprice = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"sumPrice"]];
    CommonHeader *comheader = [CommonHeader new];
    CGSize size = [comheader CMGetlablesize:strprice Fwidth:150 Fheight:20 Sfont:FONTN(15.0f) Spaceing:3.0f];
    UILabel *labeltotalprice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-size.width-10, 20,size.width+10, 20)];
    labeltotalprice.text = strprice;
    labeltotalprice.font = FONTN(15.0f);
    labeltotalprice.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labeltotalprice];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline];
    
    return view;
}

//pay
-(UIView *)payWay:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    
    float widthnow = (SCREEN_WIDTH-60)/3;
    for(int i=0;i<3;i++)
    {
        PayButtonView *payway = [[PayButtonView alloc] initWithFrame:CGRectMake(10+(20+widthnow)*i, 5, widthnow, 40)];
        payway.delegate1 = self;
        payway.backgroundColor = [UIColor clearColor];
        payway.tag = EnDoneOrderPayWayImageTag+i;
        if(i==0)
            [payway initviewbutton:@"货到付款" Alignment:EnButtonTextLeft];
        else if(i==1)
            [payway initviewbutton:@"欠账订单" Alignment:EnButtonTextCenter];
        else if(i==2)
            [payway initviewbutton:@"到店取货" Alignment:EnButtonTextRight];
        [view addSubview:payway];
        [payway.buttonselect setHidden:YES];
        if([[dicresponse objectForKey:@"payChannel"] intValue]==i)
        {
            [payway updateimageselected];
        }
    }
    
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
}

#pragma mark - IBAction
-(void)returnback:(id)sender
{
    [PTLoadingHubView dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickreceivedone:(id)sender
{
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = [NSString stringWithFormat:@"请您在确认收到货的时候点击确认收货,请问是否确认收货"];
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确认收货", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self commitreceivedone];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 50;
    else if(indexPath.section == 1)
        return 60;
    else if(indexPath.section == 2)
        return 50;
    else if(indexPath.section == 3)
        return 50;
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else if(section == 1)
        return [arraydata count];
    else if(section == 2)
        return 1;
    else if(section == 3)
        return 3;
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 10;
    else if(section == 1)
        return 60;
    else if(section == 2)
        return 60;
    else if(section == 3)
        return 10;
    return 0.001;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if((section == 0)||(section == 3))
    {
        UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        imageviewline.backgroundColor = COLORNOW(240, 240, 240);
        return imageviewline;
    }
    else if(section == 1)
    {
        UIView *viewtime = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
        viewtime.backgroundColor = COLORNOW(240, 240, 240);
        
        UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
        imagebg.backgroundColor = [UIColor whiteColor];
        [viewtime addSubview:imagebg];
        
        UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 20)];
        labeltime.textColor = COLORNOW(52, 52, 52);
        labeltime.font = FONTN(15.0f);
        labeltime.text = @"送达时间";
        [viewtime addSubview:labeltime];
        
        UIButton *receivebuttontime  = [UIButton buttonWithType:UIButtonTypeCustom];
        receivebuttontime.frame = CGRectMake(SCREEN_WIDTH-155, 21, 130, 30);
        [receivebuttontime setTitle:[dicresponse objectForKey:@"deliveryTime"] forState:UIControlStateNormal];
        receivebuttontime.titleLabel.font = FONTN(15.0f);
        [receivebuttontime setTitleColor:COLORNOW(32, 188, 167) forState:UIControlStateNormal];
        receivebuttontime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [viewtime addSubview:receivebuttontime];
        
        UIImageView *arrawleft = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-17, 28, 7, 15)];
        arrawleft.image = LOADIMAGE(@"arrow_left", @"png");
        [viewtime addSubview:arrawleft];
        
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 0.7)];
        imageline.backgroundColor = COLORNOW(220, 220, 220);
        [viewtime addSubview:imageline];
        return viewtime;
    }
    else if(section == 2)
    {
        UIView *viewtime = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
        viewtime.backgroundColor = COLORNOW(240, 240, 240);
        
        UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
        imagebg.backgroundColor = [UIColor whiteColor];
        [viewtime addSubview:imagebg];
        
        UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 20)];
        labeltime.textColor = COLORNOW(52, 52, 52);
        labeltime.font = FONTN(15.0f);
        labeltime.text = @"付款方式";
        [viewtime addSubview:labeltime];
        
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 0.7)];
        imageline.backgroundColor = COLORNOW(220, 220, 220);
        [viewtime addSubview:imageline];
        
        
        return viewtime;
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
    
    cell.backgroundColor = [UIColor whiteColor];
    if(indexPath.section == 0)
    {
        UIView *viewaddr = [self viewaddrcell:CGRectMake(0,0, SCREEN_WIDTH, 50)];
        [cell.contentView addSubview:viewaddr];
    }
    else if(indexPath.section == 1)
    {
        NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
        UIView *viewcell = [self ViewCell:CGRectMake(0, 0, SCREEN_WIDTH, 60) Dic:dictemp IndexPath:indexPath];
        [cell.contentView addSubview:viewcell];
    }
    else if(indexPath.section == 2)
    {
        UIView *viewcell = [self payWay:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [cell.contentView addSubview:viewcell];
    }
    else if(indexPath.section == 3)
    {
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
        labelname.textColor = COLORNOW(52, 52, 52);
        labelname.font = FONTN(16.0f);
        [cell.contentView addSubview:labelname];
        
        UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 15, 90, 20)];
        labelprice.textColor = COLORNOW(52, 52, 52);
        labelprice.font = FONTN(14.0f);
        labelprice.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:labelprice];
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"商品金额";
                labelprice.text = [NSString stringWithFormat:@"￥%@",[dicresponse objectForKey:@"totalPrice"]];
                break;
            case 1:
                labelname.text = @"配送费";
                labelprice.text = [NSString stringWithFormat:@"￥%@",[dicresponse objectForKey:@"deliveryPrice"]];
                break;
            case 2:
                labelname.text = @"优惠券";
                labelprice.text = [NSString stringWithFormat:@"￥%@",[dicresponse objectForKey:@"couponPayPrice"]];
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 获取首页数据
-(void)getorderdetail
{
    OrderService *order = [OrderService new];
    [order sendOrderDetailRequest:_FCorderid App:app ReqUrl:RQMyOrderDetail successBlock:^(NSDictionary *dicData) {
        dicresponse = dicData;
        arraydata = [dicresponse objectForKey:@"products"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
        
        if([[dicresponse objectForKey:@"deliveryState"] intValue]==3)
        {
            buttonreceivedone.hidden = YES;
            tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight);
        }
        
        [self viewbottomSettlement:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    }];
}

-(void)commitreceivedone
{
    OrderService *order = [OrderService new];
    [order sendOrderDoneReceiveRequest:_FCorderid App:app ReqUrl:RQDoneReceiveOrder successBlock:^(NSDictionary *dicData) {
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
