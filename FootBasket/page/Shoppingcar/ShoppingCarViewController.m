//
//  ShoppingCarViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "ShoppingCarViewController.h"

@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

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
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, StatusBarHeight, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setTitle:@"删除"forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    [button setTitleColor:COLORNOW(52, 52, 52) forState:UIControlStateNormal];
    [button addTarget:self action: @selector(clickdelete:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = COLORNOW(245, 245, 245);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    arraydelete = [[NSMutableArray alloc] init];
    arrayproductnum = [[NSMutableArray alloc] init];
    selectdelete = EnShoppingCarNotSelect;
    selectall = EnNotSelect;
    self.title = @"购物车";
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-49-40) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];

    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    
    if(![app.userinfo.usertype isEqualToString:@"1"])
    {
        UIView *viewbottom = [self viewbottomSettlement:CGRectMake(0, SCREEN_HEIGHT-IPhone_SafeBottomMargin-49-StatusBarAndNavigationHeight-50, SCREEN_WIDTH, 50)];
        [self.view addSubview:viewbottom];
    }
}

//结算条
-(UIView *)viewbottomSettlement:(CGRect)frame
{
    UIView *viewbottom = [[UIView alloc] initWithFrame:frame];
    viewbottom.backgroundColor = [UIColor whiteColor];
    
    
    buttonselectall = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonselectall.frame = CGRectMake(0, 5, 40, 40);
    [buttonselectall setImage:LOADIMAGE(@"选区", @"png") forState:UIControlStateNormal];
    [buttonselectall addTarget:self action:@selector(clickselectalldelete:) forControlEvents:UIControlEventTouchUpInside];
    buttonselectall.hidden = YES;
    [viewbottom addSubview:buttonselectall];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100, 50);
    [button setTitle:@"去结算" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    button.backgroundColor = COLORNOW(32, 188, 167);
    [button addTarget:self action:@selector(clickSettlement:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewbottom addSubview:button];
    
    UILabel *labelall = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(button)-120, 15, 35, 20)];
    labelall.textColor = COLORNOW(52, 52, 52);
    labelall.font = FONTN(15.0f);
    labelall.text = @"合计";
    [viewbottom addSubview:labelall];
    
    labeltotalmoney = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelall), 15, 85, 20)];
    labeltotalmoney.textColor = COLORNOW(248, 88, 37);
    labeltotalmoney.font = FONTN(15.0f);
    labeltotalmoney.text = @"";
    [viewbottom addSubview:labeltotalmoney];
    
    
    labeltotalproduct = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 130, 20)];
    labeltotalproduct.textColor = COLORNOW(122, 122, 122);
    labeltotalproduct.font = FONTN(15.0f);
    labeltotalproduct.text = @"";
    [viewbottom addSubview:labeltotalproduct];
    
    
    return viewbottom;
}


//cell
-(UIView *)ViewCell:(CGRect)frame Dic:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    
    float noworginx = 10;
    
    if(selectdelete == EnShoppingCarSelected)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 40, XYViewHeight(view));
        [button setImage:LOADIMAGE(@"选区", @"png") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickselectdelete:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = indexpath.row+EnShopCarDeleteBtTag;
        for(int i=0;i<[arraydelete count];i++)
        {
            NSString *strid = [arraydelete objectAtIndex:i];
            if([[dic objectForKey:@"shoppingCartId"] isEqualToString:strid])
            {
                [button setImage:LOADIMAGE(@"选择框选中", @"png") forState:UIControlStateNormal];
            }
        }
        [view addSubview:button];
        noworginx = 40;
    }
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(noworginx, 10, 80, 80)];
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
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, XYViewWidth(view)-50, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元",[dic objectForKey:@"salePrice"]];
    labelprice.font = FONTN(15.0f);
    labelprice.textColor = COLORNOW(122, 122, 122);
    [view addSubview:labelprice];
    
    //增加
    UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonadd.frame = CGRectMake(SCREEN_WIDTH-50, (XYViewHeight(view)-40)/2, 40, 40);
    [buttonadd setImage:LOADIMAGE(@"addicon", @"png") forState:UIControlStateNormal];
    [buttonadd addTarget:self action:@selector(clickaddproduct:) forControlEvents:UIControlEventTouchUpInside];
    buttonadd.tag = indexpath.row+EnShopCarAddBtTag;
    [view addSubview:buttonadd];
    
    UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(buttonadd)-25, XYViewTop(buttonadd), 25, 40)];
    labelnum.text = @"1";
    for(int i=0;i<[arrayproductnum count];i++)
    {
        NSDictionary *dictemp = [arrayproductnum objectAtIndex:i];
        if([[dictemp objectForKey:@"shoppingCartId"] isEqualToString:[dic objectForKey:@"shoppingCartId"]])
        {
            labelnum.text = [dictemp objectForKey:@"count"];
        }
    }
    labelnum.textAlignment = NSTextAlignmentCenter;
    labelnum.font = FONTN(15.0f);
    labelnum.textColor = COLORNOW(52, 52, 52);
    labelnum.tag = indexpath.row+EnShopCarLabelNumTag;
    [view addSubview:labelnum];
    
    //减少
    UIButton *buttonreduce = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonreduce.frame = CGRectMake(XYViewL(labelnum)-40, XYViewTop(buttonadd), 40, 40);
    [buttonreduce setImage:LOADIMAGE(@"reduceicon", @"png") forState:UIControlStateNormal];
    [buttonreduce addTarget:self action:@selector(clickreduceproduct:) forControlEvents:UIControlEventTouchUpInside];
    buttonreduce.tag = indexpath.row+EnShopCarReduceBtTag;
    [view addSubview:buttonreduce];
    
    return view;
}

-(UIView *)adddeleteview:(CGRect)frame
{
    UIView *viewdelete = [[UIView alloc] initWithFrame:frame];
    viewdelete.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(XYViewWidth(viewdelete)-100, 0, 100, 50);
    [button setTitle:@"删除" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    button.backgroundColor = COLORNOW(226, 24, 28);
    [button addTarget:self action:@selector(deleteshopcarproduct:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewdelete addSubview:button];
    
    return viewdelete;
}

#pragma mark - IBACtion
-(void)clickdelete:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if(selectdelete == EnShoppingCarNotSelect)
    {
        [arraydelete removeAllObjects];
        selectdelete = EnShoppingCarSelected;
        buttonselectall.hidden = NO;
        [tableview reloadData];
        UIView *view = [self adddeleteview:CGRectMake(100,SCREEN_HEIGHT-IPhone_SafeBottomMargin-49-StatusBarAndNavigationHeight-50, SCREEN_WIDTH-100, 50)];
        view.tag = EnShoppingCarDeleteViewBgTag;
        [self.view addSubview:view];
        [button setTitle:@"确定" forState:UIControlStateNormal];
    }
    else
    {
        [[self.view viewWithTag:EnShoppingCarDeleteViewBgTag] removeFromSuperview];
        [arraydelete removeAllObjects];
        selectdelete = EnShoppingCarNotSelect;
        buttonselectall.hidden = YES;
        [tableview reloadData];
        [button setTitle:@"删除" forState:UIControlStateNormal];
    }
}

-(void)clickselectdelete:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag] - EnShopCarDeleteBtTag;
    NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
    int flag = 0;
    for(int i=0;i<[arraydelete count];i++)
    {
        NSString *strid = [arraydelete objectAtIndex:i];
        if([[dictemp objectForKey:@"shoppingCartId"] isEqualToString:strid])
        {
            [button setImage:LOADIMAGE(@"选区", @"png") forState:UIControlStateNormal];
            [arraydelete removeObject:strid];
            flag = 1;
            break;
        }
    }
    if(flag == 0)
    {
        [arraydelete addObject:[dictemp objectForKey:@"shoppingCartId"]];
        [button setImage:LOADIMAGE(@"选择框选中", @"png") forState:UIControlStateNormal];
    }
}

-(void)clickaddproduct:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag] - EnShopCarAddBtTag;
    
    UILabel *labelnum = [tableview viewWithTag:EnShopCarLabelNumTag+tagnow];
    int numnow = [labelnum.text intValue];
    if(numnow+1>99)
    {
        [MBProgressHUD showError:@"单一商品最大数量订购99件" toView:app.window];
    }
    else
    {
        labelnum.text = [NSString stringWithFormat:@"%d",numnow+1];
        NSMutableDictionary *dictemp = [arraydata objectAtIndex:tagnow];
        for(int i=0;i<[arrayproductnum count];i++)
        {
            NSMutableDictionary *dicnum= [arrayproductnum objectAtIndex:i];
            if([[dicnum objectForKey:@"shoppingCartId"] isEqualToString:[dictemp objectForKey:@"shoppingCartId"]])
            {
                [dicnum setObject:labelnum.text forKey:@"count"];
                
                NSDictionary *dicdata = [arraydata objectAtIndex:i];
                float productprice = [[dicdata objectForKey:@"salePrice"] floatValue];
                float totalprice = [[labeltotalmoney.text substringFromIndex:1] floatValue];
                totalprice = totalprice+productprice;
                [labeltotalmoney setText:[NSString stringWithFormat:@"￥%.2f",totalprice]];
                break;
            }
        }
        [dictemp setObject:labelnum.text forKey:@"productnum"];
        
    }
}

-(void)clickreduceproduct:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag] - EnShopCarReduceBtTag;
    UILabel *labelnum = [tableview viewWithTag:EnShopCarLabelNumTag+tagnow];
    
    int numnow = [labelnum.text intValue];
    if(numnow-1<1)
    {
        [MBProgressHUD showError:@"单一商品最小数量订购1件" toView:app.window];
    }
    else
    {
        labelnum.text = [NSString stringWithFormat:@"%d",numnow-1];
        NSMutableDictionary *dictemp = [arraydata objectAtIndex:tagnow];
        for(int i=0;i<[arrayproductnum count];i++)
        {
            NSMutableDictionary *dicnum= [arrayproductnum objectAtIndex:i];
            if([[dicnum objectForKey:@"shoppingCartId"] isEqualToString:[dictemp objectForKey:@"shoppingCartId"]])
            {
                [dicnum setObject:labelnum.text forKey:@"count"];
                
                NSDictionary *dicdata = [arraydata objectAtIndex:i];
                float productprice = [[dicdata objectForKey:@"salePrice"] floatValue];
                float totalprice = [[labeltotalmoney.text substringFromIndex:1] floatValue];
                totalprice = totalprice-productprice;
                [labeltotalmoney setText:[NSString stringWithFormat:@"￥%.2f",totalprice]];
                break;
            }
        }
        [dictemp setObject:labelnum.text forKey:@"productnum"];
       
    }
}

-(void)clickselectalldelete:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(selectall == EnNotSelect)
    {
        selectall = EnSelected;
        [button setImage:LOADIMAGE(@"选择框选中", @"png") forState:UIControlStateNormal];
         [arraydelete removeAllObjects];
        for(int i=0;i<[arraydata count];i++)
        {
            NSDictionary *dictemp = [arraydata objectAtIndex:i];
            [arraydelete addObject:[dictemp objectForKey:@"shoppingCartId"]];
            
            UIButton *buttondelete = [tableview viewWithTag:EnShopCarDeleteBtTag+i];
            [buttondelete setImage:LOADIMAGE(@"选择框选中", @"png") forState:UIControlStateNormal];
        }
    }
    else
    {
        selectall = EnNotSelect;
        [arraydelete removeAllObjects];
        [button setImage:LOADIMAGE(@"选区", @"png") forState:UIControlStateNormal];
        for(int i=0;i<[arraydata count];i++)
        {
            UIButton *buttondelete = [tableview viewWithTag:EnShopCarDeleteBtTag+i];
            [buttondelete setImage:LOADIMAGE(@"选区", @"png") forState:UIControlStateNormal];
        }
    }
}

-(void)clickSettlement:(id)sender
{
    if([arraydata count]>0)
    {
        DoneOrderViewController *doneorder = [[DoneOrderViewController alloc] init];
        doneorder.hidesBottomBarWhenPushed = YES;
        doneorder.arrayproductnum = arrayproductnum;
        [self.navigationController pushViewController:doneorder animated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"请先填写商品进购物车" toView:app.window];
    }
}

#pragma mark - viewcontroller delegate
-(void)viewWillAppear:(BOOL)animated
{
    [self getshoppingcarinterface];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UIColor* color = [UIColor blackColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
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
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
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
    return 10;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    imageviewline.backgroundColor = COLORNOW(245, 245, 245);
    return imageviewline;
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
    UIView *view = [self ViewCell:CGRectMake(0, 0, SCREEN_WIDTH, 100) Dic:dictemp IndexPath:indexPath];
    [cell.contentView addSubview:view];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 获取首页数据

-(void)deleteshopcarproduct:(id)sender
{
    ShoppingCarService *shoppingcar = [ShoppingCarService new];
    NSString *ids = @"";
    for(int i=0;i<[arraydelete count];i++)
    {
        NSString *strid = [arraydelete objectAtIndex:i];
        ids = [ids length]>0?[NSString stringWithFormat:@"%@,%@",ids,strid]:strid;
    }
    if([ids length]>0)
    {
        [shoppingcar sendShoppingCarDeleteRequest:ids App:app ReqUrl:RQDeleteShoppingCar successBlock:^(NSDictionary *dicData) {
            [self getshoppingcarinterface];
        }];
    }
    else
    {
        [MBProgressHUD showError:@"请选择要删除的商品" toView:app.window];
    }
}

-(void)getshoppingcarinterface
{
    ShoppingCarService *shoppingcar = [ShoppingCarService new];
    [shoppingcar sendShoppingCarRequest:app.userinfo.userid App:app ReqUrl:RQMyShoppingCar successBlock:^(NSDictionary *dicData) {
        arraydata = [NSMutableArray arrayWithArray:[dicData objectForKey:@"rows"]];
        [arrayproductnum removeAllObjects];
        float nowprice = 0;
        for(int i=0;i<[arraydata count];i++)
        {
            NSDictionary *dictemp = [arraydata objectAtIndex:i];
            NSMutableDictionary *dicnum = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[dictemp objectForKey:@"productNumber"]],@"count", [dictemp objectForKey:@"shoppingCartId"],@"shoppingCartId",[dictemp objectForKey:@"id"],@"productId",nil];
            [arrayproductnum addObject:dicnum];
            
            int productnum = [[dictemp objectForKey:@"productNumber"] intValue];
            float productprice = [[dictemp objectForKey:@"salePrice"] floatValue];
            nowprice = nowprice+productprice*productnum;
        }
        
        labeltotalmoney.text = [NSString stringWithFormat:@"￥%.2f",nowprice];
        labeltotalproduct.text = [NSString stringWithFormat:@"共计%ld款商品",[arraydata count]];
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
