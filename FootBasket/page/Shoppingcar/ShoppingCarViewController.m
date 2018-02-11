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
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    [self getshoppingcarinterface];
    
}



//cell
-(UIView *)ViewCell:(CGRect)frame Dic:(NSDictionary *)dic
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XYViewWidth(view), XYViewWidth(view))];
    imageview.image = LOADIMAGE(@"图层20", @"png");
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dic objectForKey:@"productBasic_headPicture"]];
    [imageview setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
    [view addSubview:imageview];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,XYViewBottom(imageview)+5, XYViewWidth(view)-10, 20)];
    labelname.text = [dic objectForKey:@"productBasic_name"];
    labelname.font = FONTN(16.0f);
    [view addSubview:labelname];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, XYViewWidth(view)-50, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dic objectForKey:@"productBasic_salePrice"],[dic objectForKey:@"productBasic_displayUnit"]];
    labelprice.font = FONTN(15.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [view addSubview:labelprice];
    
    UIButton *buttonshoppingcar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonshoppingcar.frame = CGRectMake(XYViewWidth(view)-40,XYViewHeight(view)-35, 40, 40);
    [buttonshoppingcar setImage:LOADIMAGE(@"加入购物车small", @"png") forState:UIControlStateNormal];
    buttonshoppingcar.backgroundColor = [UIColor clearColor];
    [view addSubview:buttonshoppingcar];
    
    return view;
    
}

#pragma mark - ActionDelegate


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
    return 2;//[arraydata count];
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
    
    cell.textLabel.text = @"123";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 获取首页数据
-(void)getshoppingcarinterface
{
    ShoppingCarService *shoppingcar = [ShoppingCarService new];
    [shoppingcar sendShoppingCarRequest:app.userinfo.userid App:app ReqUrl:RQMyShoppingCar successBlock:^(NSDictionary *dicData) {
        
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
