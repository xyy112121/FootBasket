//
//  CategoryViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

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
    
    //添加分类
//    [self selectcategory];
    
    //添加左边分类菜单
//    float widthnow = (SCREEN_WIDTH-40)/4;
//    [self leftmenucategory:CGRectMake(0, 45, widthnow, SCREEN_HEIGHT-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin-49-45)];
    
    float widthnow = (SCREEN_WIDTH-40)/4;
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(widthnow+20, 45, SCREEN_WIDTH-(widthnow+20), SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-49-45) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableview];

    [self setExtraCellLineHidden:tableview];
    
    [self getCategoryMain];
}

-(void)selectcategory:(NSArray *)arraytemp
{
    UIView *viewcategory = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    viewcategory.backgroundColor = [UIColor whiteColor];
    
    float widthnow = (SCREEN_WIDTH-40)/4;
    imageselectcategory = [[UIImageView alloc] initWithFrame:CGRectMake(10, XYViewHeight(viewcategory)-3, widthnow-20, 3)];
    imageselectcategory.backgroundColor = COLORNOW(32, 188, 167);
    
    for(int i=0;i<[arraytemp count];i++)
    {
        NSDictionary *dictemp = [arraytemp objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(widthnow*i, 0, widthnow, 45);
        [button setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
        button.titleLabel.font = FONTN(15.0f);
        if(i==0)
            [button setTitleColor:COLORNOW(32, 188, 167) forState:UIControlStateNormal];
        else
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = EnCategoryTopBtTag+i;
        [button addTarget:self action:@selector(clickcategory:) forControlEvents:UIControlEventTouchUpInside];
        [viewcategory addSubview:button];
        
    }
    [viewcategory addSubview:imageselectcategory];
    [self.view addSubview:viewcategory];
}

-(void)leftmenucategory:(CGRect)frame Dic:(NSDictionary *)dic
{
    leftcategorymenu = [[CategoryLeftMenu alloc] initWithFrame:frame Dic:dic];
    leftcategorymenu.delegate1 = self;
    [self.view addSubview:leftcategorymenu];
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
    
    UILabel *labelsummary = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, XYViewWidth(viewcell)-100, 20)];
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
    [buttonshoppingcar addTarget:self action:@selector(clickCategoryGoods:)
                forControlEvents:UIControlEventTouchUpInside];
    buttonshoppingcar.tag = EnMyCategoryProductShopCarTag +tagnow;
    [viewcell addSubview:buttonshoppingcar];
    
    return viewcell;
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
    
    [hpnav removeFromSuperview];
    hpnav = nil;
    hpnav = [[HpNavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    hpnav.tag = EnHpNavigationBgTag;
    hpnav.delegate1 = self;
    [hpnav initViewCategory];
    [self.navigationController.navigationBar addSubview:hpnav];
}

#pragma mark - ActionDelegate
-(void)DGClickCategorySmall:(NSDictionary *)sender
{
    CategoryService *categoryservice = [CategoryService new];
    
    [categoryservice sendCategoryGoodsRequest:@"1" PageSize:@"10" SmallId:[sender objectForKey:@"id"] App:app ReqUrl:RQCategoryGood successBlock:^(NSDictionary *dicData) {
        
        arraydata = [dicData objectForKey:@"rows"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
    }];
}

-(void)DGCickSearchTextfield:(id)sender
{
    SearchViewController *searchview = [[SearchViewController alloc] init];
    UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchview];
    [self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGAddShoppingCar:(NSDictionary *)sender
{
    AddShoppingCarView *addshoppingcar = [[AddShoppingCarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) DicRecommend:sender];
    [app.window addSubview:addshoppingcar];
    
}

-(void)clickCategoryGoods:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnMyCategoryProductShopCarTag;
    NSDictionary *dic = [arraydata objectAtIndex:tagnow];
    [self DGAddShoppingCar:dic];
}

#pragma mark - IBAction
-(void)clickcategory:(id)sender
{
    UIButton *button = (UIButton *)sender;
    for(int i=0;i<4;i++)
    {
        UIButton *button = [self.view viewWithTag:EnCategoryTopBtTag+i];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    UIButton *buttonclick = (UIButton *)sender;
    imageselectcategory.frame = CGRectMake(XYViewL(buttonclick)+10, XYViewTop(imageselectcategory), XYViewWidth(imageselectcategory), XYViewHeight(imageselectcategory));
    [buttonclick setTitleColor:COLORNOW(32, 188, 167) forState:UIControlStateNormal];
    
    NSDictionary *dictemp = [arraymain objectAtIndex:button.tag-EnCategoryTopBtTag];
    [leftcategorymenu getCategorysmall:dictemp];
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
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    UIView *viewcell = [self getcellView:dictemp Frame:CGRectMake(0, 0, XYViewWidth(tableView), 100) TagNow:(int)indexPath.row];
    [cell.contentView addSubview:viewcell];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    GoodsDetailViewController *goodsdetail = [[GoodsDetailViewController alloc] init];
    goodsdetail.FCGoodsId = [dictemp objectForKey:@"id"];
    goodsdetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodsdetail animated:YES];
}

#pragma mark - 接口
-(void)getCategoryMain
{
    CategoryService *categoryservice = [CategoryService new];
    
    [categoryservice sendCategoryMainRequest:@"1" PageSize:@"10" App:app ReqUrl:RQCategoryMain successBlock:^(NSDictionary *dicData) {
        arraymain = [dicData objectForKey:@"rows"];
        if([arraymain count]>0)
        {
            [self selectcategory:arraymain];
            NSDictionary *dictemp = [arraymain objectAtIndex:0];
            float widthnow = (SCREEN_WIDTH-40)/4;
            [self leftmenucategory:CGRectMake(0, 45, widthnow+20, SCREEN_HEIGHT-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin-49-45) Dic:dictemp];
        }
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
