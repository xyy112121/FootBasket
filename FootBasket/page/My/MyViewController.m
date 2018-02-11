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
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor =  COLORNOW(32, 188, 167);
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    [self initview];
    
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
//    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
//    [button setTitle:@"设置"forState:UIControlStateNormal];
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    [button addTarget:self action: @selector(gotosetting:) forControlEvents: UIControlEventTouchUpInside];
//    [contentView addSubview:button];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
//    self.navigationItem.leftBarButtonItem = barButtonItem;
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = COLORNOW(245, 245, 245);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-49) style:UITableViewStylePlain];
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

    [self initheaderview];
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 56, 56);
    button.layer.cornerRadius = 28.0f;
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 2.0f;
    [button setBackgroundImage:LOADIMAGE(@"个人头像", @"png") forState:UIControlStateNormal];
    button.center = CGPointMake(SCREEN_WIDTH/2, 80);
    [viewheader addSubview:button];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, XYViewBottom(button)+5, 150, 20)];
    labelname.text = app.userinfo.username;
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
    UIButton *imagewaitreceive = [UIButton buttonWithType:UIButtonTypeCustom];
    imagewaitreceive.frame = CGRectMake(30, XYViewBottom(imageviewline)+5, nowwidth, 50);
    imagewaitreceive.backgroundColor = [UIColor clearColor];
    [imagewaitreceive setImage:LOADIMAGE(@"待收货", @"png") forState:UIControlStateNormal];
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
    [viewheader addSubview:imagereceived];
    
    UILabel *labelmiddle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagereceived), XYViewBottom(imagereceived)-5, XYViewWidth(imagereceived), 20)];
    labelmiddle.text = @"已收货";
    labelmiddle.backgroundColor = [UIColor clearColor];
    labelmiddle.font = FONTN(15.0f);
    labelmiddle.textAlignment = NSTextAlignmentCenter;
    labelmiddle.textColor = COLORNOW(51, 51, 51);
    [viewheader addSubview:labelmiddle];
    
    //送货单
    UIButton *imagedelivery = [UIButton buttonWithType:UIButtonTypeCustom];
    imagedelivery.frame = CGRectMake(30+XYViewR(imagereceived), XYViewTop(imagewaitreceive), nowwidth, 50);
    imagedelivery.backgroundColor = [UIColor clearColor];
    [imagedelivery setImage:LOADIMAGE(@"待发货", @"png") forState:UIControlStateNormal];
    [viewheader addSubview:imagedelivery];
    
    UILabel *labeldelivery = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagedelivery), XYViewBottom(imagedelivery)-5, XYViewWidth(imagedelivery), 20)];
    labeldelivery.text = @"送货单";
    labeldelivery.backgroundColor = [UIColor clearColor];
    labeldelivery.font = FONTN(15.0f);
    labeldelivery.textAlignment = NSTextAlignmentCenter;
    labeldelivery.textColor = COLORNOW(51, 51, 51);
    [viewheader addSubview:labeldelivery];
    
    tableview.tableHeaderView = viewheader;
}

#pragma mark - IBAction
-(void)gotosetting:(id)sender
{
    
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
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
        case 1:
            imageview.image = LOADIMAGE(@"礼物", @"png");
            labelname.text = @"邀请有礼";
            break;
        case 2:
            imageview.image = LOADIMAGE(@"电话", @"png");
            labelname.text = @"联系客服";
            break;

    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
