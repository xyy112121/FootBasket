//
//  DoneOrderViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "DoneOrderViewController.h"

@interface DoneOrderViewController ()

@end

@implementation DoneOrderViewController

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
    self.title = @"确认订单";
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-50) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    [self gotoSettlement];
    [self initviewfoot];
}

-(void)initviewfoot
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    viewbg.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewbg];
    
    UILabel *labeltips = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 50)];
    labeltips.text = @"温馨提示: 本店购物订单金额超过36元的西山区和高新区用户,我们将为您送货到家,由于食材需要从仓库中提取并且为您精心准备,请您提前一个小时下单！谢谢！";
    labeltips.textColor = COLORNOW(180, 180, 180);
    labeltips.font = FONTN(13.0f);
    labeltips.numberOfLines = 3;
    [view addSubview:labeltips];
    
    tableview.tableFooterView = view;
}

//结算条
-(UIView *)viewbottomSettlement:(CGRect)frame
{
    UIView *viewbottom = [[UIView alloc] initWithFrame:frame];
    viewbottom.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100, 50);
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    button.backgroundColor = COLORNOW(250, 111, 73);
    [button addTarget:self action:@selector(clickcommitorder:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewbottom addSubview:button];
    
    UILabel *labelall = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(button)-110, 15, 35, 20)];
    labelall.textColor = COLORNOW(52, 52, 52);
    labelall.font = FONTN(15.0f);
    labelall.text = @"合计";
    [viewbottom addSubview:labelall];
    
    UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelall), 15, 75, 20)];
    labelmoney.textColor = COLORNOW(248, 88, 37);
    labelmoney.font = FONTN(15.0f);
    labelmoney.text = [NSString stringWithFormat:@"￥%@",[dicresponse objectForKey:@"realPayPrice"]];
    [viewbottom addSubview:labelmoney];
    
    UILabel *labelproductnum = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelall)-105, 15, 100, 20)];
    labelproductnum.textColor = COLORNOW(52, 52, 52);
    labelproductnum.font = FONTN(15.0f);
    labelproductnum.text = [NSString stringWithFormat:@"共计:%ld款产品",[arraydata count]];
    [viewbottom addSubview:labelproductnum];
    return viewbottom;
}

//地址选择
-(UIView *)viewaddrcell:(CGRect)frame DicAddr:(NSDictionary *)dicaddr
{
    UIView *viewaddr = [[UIView alloc] initWithFrame:frame];
    viewaddr.backgroundColor = [UIColor whiteColor];
    
    //NSDictionary *dicarrd = [dicresponse objectForKey:@"address"];
    selectaddrid = [dicaddr objectForKey:@"id"];
    UIImageView *imageaddricon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 24, 14, 18)];
    imageaddricon.image = LOADIMAGE(@"地址icon", @"png");
    [viewaddr addSubview:imageaddricon];
    if([selectaddrid length]==0)
    {
        
    }
    else
    {
        
        
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageaddricon)+5, 7, 100, 20)];
        labelname.text = [dicaddr objectForKey:@"userName"];
        labelname.font = FONTN(15.0f);
        [viewaddr addSubview:labelname];
        
        UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(XYViewWidth(viewaddr)-170, 7, 140, 20)];
        labeltel.text = [dicaddr objectForKey:@"mobile"];
        labeltel.textAlignment = NSTextAlignmentRight;
        labeltel.font = FONTN(15.0f);
        [viewaddr addSubview:labeltel];
        
        UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageaddricon)+5, XYViewBottom(labelname), SCREEN_WIDTH-60, 35)];
        labeladdr.backgroundColor = [UIColor clearColor];
        labeladdr.text = [NSString stringWithFormat:@"%@%@%@%@",[dicaddr objectForKey:@"province"],[dicaddr objectForKey:@"city"],[dicaddr objectForKey:@"county"],[dicaddr objectForKey:@"address"]];
        labeladdr.font = FONTN(15.0f);
        labeladdr.numberOfLines = 2;
        labeladdr.textColor = COLORNOW(52, 52, 52);
        [viewaddr addSubview:labeladdr];
        
        
        
        
    }
    
    UIImageView *arrawleft = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-17, 24, 7, 15)];
    arrawleft.image = LOADIMAGE(@"arrow_left", @"png");
    [viewaddr addSubview:arrawleft];
    
    UIImageView *imagebottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewHeight(viewaddr)-3, SCREEN_WIDTH, 3)];
    imagebottom.image = LOADIMAGE(@"彩色分割条", @"png");
    [viewaddr addSubview:imagebottom];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = viewaddr.bounds;
    [button addTarget:self action:@selector(gotoselectaddrlist:) forControlEvents:UIControlEventTouchUpInside];
    [viewaddr addSubview:button];
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
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickcommitorder:(id)sender
{
    if([selectaddrid length]==0)
    {
        [MBProgressHUD showError:@"请选择收货地址" toView:app.window];
        return;
    }
    else if([payway length]==0)
    {
        [MBProgressHUD showError:@"请选择付款方式" toView:app.window];
        return;
    }
    else if([receivetime length]==0)
    {
        [MBProgressHUD showError:@"请选择送达时间" toView:app.window];
        return;
    }
    else if(([[dicselectaddr objectForKey:@"county"] rangeOfString:@"西山区"].location == NSNotFound)&&([[dicselectaddr objectForKey:@"county"] rangeOfString:@"高新区"].location == NSNotFound)&&([[dicresponse objectForKey:@"realPayPrice"] floatValue]<500))
    {
        [self popAlertSheetView:@"对不起,我们当前区的配送设施正在紧张的建设之中,暂时不能下单,给你带来的不便,敬请谅解"];
        return ;
    }
    else
    {
        NSString *title = NSLocalizedString(@"提示", nil);
        NSString *message = [NSString stringWithFormat:@"你实际需要支付%@元\n是否确定提交订单",[dicresponse objectForKey:@"realPayPrice"]];
        NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self commitselforder];
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)clickreceiveTime:(id)sender
{
        DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
//        self.datePickerView = pickerView;
        pickerView.delegate = self;
        pickerView.pickerViewMode = DatePickerViewDateTimeMode;
        [self.view addSubview:pickerView];
        [pickerView showDateTimePickerView];
}

-(void)gotoselectaddrlist:(id)sender
{
    MyAddrListViewController *myaddr = [[MyAddrListViewController alloc] init];
    myaddr.fromflag = @"1";
    myaddr.delegate1 = self;
    [self.navigationController pushViewController:myaddr animated:YES];
}

#pragma mark - delegate
    
- (void)didClickFinishDateTimePickerView:(NSString *)date
{
    receivetime = date;
    receivetime = [NSString stringWithFormat:@"%@:00",receivetime];
    CommonHeader *com = [CommonHeader new];
    NSString *cha = [com CMIntervalFromLastDate:receivetime toTheDate:[com CMReturnnowdate:@"yyyy-MM-dd HH:mm:ss"]];
    DLog(@"cha=====%@",cha);
    if([cha intValue]<7200)
    {
        [self popAlertSheetView:@"对不起,由于我们需要备货,为你送达货物的时候必须大于2小时,为您带来的不便,敬请谅解！"];
        
    }
    else
    {
        [receivebuttontime setTitle:date forState:UIControlStateNormal];
    }
}

#pragma mark - popalertview
-(void)popAlertSheetView:(NSString *)popstr
{
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = popstr;
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    // Add the actions.
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Actiondelegate
-(void)DGClickPayWay:(id)sender TitleName:(UILabel *)titlename
{
    PayButtonView *payway1 = [tableview viewWithTag:EnDoneOrderPayWayImageTag];
    PayButtonView *payway2 = [tableview viewWithTag:EnDoneOrderPayWayImageTag+1];
    PayButtonView *payway3 = [tableview viewWithTag:EnDoneOrderPayWayImageTag+2];
    [payway1 updateimageselect];
    [payway2 updateimageselect];
    [payway3 updateimageselect];
    if([titlename.text isEqualToString:@"货到付款"])
        payway = @"0";
    else if([titlename.text isEqualToString:@"欠账订单"])
        payway = @"1";
    else if([titlename.text isEqualToString:@"取店取货"])
        payway = @"2";
    UIImageView *imageview = (UIImageView *)sender;
    imageview.image = LOADIMAGE(@"选择框选中", @"png");
}

-(void)DGClickOrderAddress:(NSDictionary *)sender
{
    dicselectaddr = sender;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
        return 70;
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
        
        receivebuttontime  = [UIButton buttonWithType:UIButtonTypeCustom];
        receivebuttontime.frame = CGRectMake(SCREEN_WIDTH-155, 21, 130, 30);
        [receivebuttontime setTitle:@"请选择送达时间" forState:UIControlStateNormal];
        receivebuttontime.titleLabel.font = FONTN(15.0f);
        [receivebuttontime setTitleColor:COLORNOW(32, 188, 167) forState:UIControlStateNormal];
        [receivebuttontime addTarget:self action:@selector(clickreceiveTime:) forControlEvents:UIControlEventTouchUpInside];
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
        UIView *viewaddr = [self viewaddrcell:CGRectMake(0,0, SCREEN_WIDTH, 70) DicAddr:dicselectaddr];
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
//结算
-(void)gotoSettlement
{
    ShoppingCarService *shoppingcar = [ShoppingCarService new];
    
    CommonHeader *com = [CommonHeader new];
    NSString *jsonnum = [com CMDataToJson:_arrayproductnum];
    DLog(@"jsonnum===%@",jsonnum);
    [shoppingcar sendShoppingCarSettlementRequest:jsonnum Userid:app.userinfo.userid App:app ReqUrl:RQShoppingCarSettlement successBlock:^(NSDictionary *dicData) {
        
        dicresponse = dicData;
        dicselectaddr = [dicresponse objectForKey:@"address"];
        arraydata = [dicresponse objectForKey:@"products"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
        
        UIView *viewbottom = [self viewbottomSettlement:CGRectMake(0, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-50, SCREEN_WIDTH, 50)];
        [self.view addSubview:viewbottom];
    }];
}

//提交订单
-(void)commitselforder
{
    ShoppingCarService *shoppingcar = [ShoppingCarService new];
    
    CommonHeader *com = [CommonHeader new];
    NSString *jsonnum = [com CMDataToJson:_arrayproductnum];
    DLog(@"jsonnum===%@",jsonnum);
    [shoppingcar sendCommitOrderRequest:jsonnum Userid:app.userinfo.userid AddrId:selectaddrid PayWay:payway DeliveryTime:receivetime App:app ReqUrl:RQCommitOrder successBlock:^(NSDictionary *dicData) {
        
 //       [self.navigationController popToRootViewControllerAnimated:YES];
        
        NSString *title = NSLocalizedString(@"提示", nil);
        NSString *message = [dicData objectForKey:@"resultInfo"];
//        NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the actions.
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        // Add the actions.
//        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
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
