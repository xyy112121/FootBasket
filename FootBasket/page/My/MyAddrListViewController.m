//
//  MyAddrListViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "MyAddrListViewController.h"

@interface MyAddrListViewController ()

@end

@implementation MyAddrListViewController

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
    self.title = @"我的收货地址";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-50) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
}

//cell
-(UIView *)ViewCell:(CGRect)frame Dic:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, frame.size.height-10)];
    imagebg.backgroundColor = [UIColor whiteColor];
    [view addSubview:imagebg];
    

    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,20, 100, 20)];
    labelname.text = @"张明明";
    labelname.font = FONTB(16.0f);
    labelname.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelname];
    
    UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150,XYViewTop(labelname), 140, 20)];
    labeltel.text = @"13678909870";
    labeltel.font = FONTN(16.0f);
    labeltel.textAlignment = NSTextAlignmentRight;
    labeltel.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labeltel];
    
    UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname),XYViewBottom(labelname)+5, SCREEN_WIDTH-20, 40)];
    labeladdr.text = @"四川省简阳市 河东新区XX栋小XX号 多少户";
    labeladdr.font = FONTN(14.0f);
    labeladdr.backgroundColor = [UIColor redColor];
    labeladdr.textColor = COLORNOW(52, 52, 52);
    labeladdr.numberOfLines = 2;
    [view addSubview:labeladdr];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, XYViewBottom(view)-40, 120, 40);
    [button setImage:LOADIMAGE(@"选区", @"png") forState:UIControlStateNormal];
    [button setTitle:@"默认地址" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    [button setTitleColor:COLORNOW(52, 52, 52) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clicksetdefault:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = indexpath.row+EnMyAddrListDefaultBtTag;
    [view addSubview:button];
    
    UIButton *buttonedit = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonedit.frame = CGRectMake(SCREEN_WIDTH-80, XYViewBottom(view)-40, 70, 40);
    [buttonedit setImage:LOADIMAGE(@"编辑", @"png") forState:UIControlStateNormal];
    [buttonedit setTitle:@"编辑" forState:UIControlStateNormal];
    buttonedit.titleLabel.font = FONTN(15.0f);
    [buttonedit setTitleColor:COLORNOW(52, 52, 52) forState:UIControlStateNormal];
    [buttonedit addTarget:self action:@selector(clicksetdefault:) forControlEvents:UIControlEventTouchUpInside];
    buttonedit.tag = indexpath.row+EnMyAddrListDefaultBtTag;
    [view addSubview:buttonedit];
    
    UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
    buttondelete.frame = CGRectMake(XYViewL(buttonedit)-70, XYViewTop(buttonedit), 70, 40);
    [buttondelete setImage:LOADIMAGE(@"删除", @"png") forState:UIControlStateNormal];
    [buttondelete setTitle:@"删除" forState:UIControlStateNormal];
    buttondelete.titleLabel.font = FONTN(15.0f);
    [buttondelete setTitleColor:COLORNOW(52, 52, 52) forState:UIControlStateNormal];
    [buttondelete addTarget:self action:@selector(clicksetdefault:) forControlEvents:UIControlEventTouchUpInside];
    buttondelete.tag = indexpath.row+EnMyAddrListDefaultBtTag;
    [view addSubview:buttondelete];
    
    
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clicksetdefault:(id)sender
{
    
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
    return 120;
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
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    UIView *view = [self ViewCell:CGRectMake(0, 0, SCREEN_WIDTH, 120) Dic:dictemp IndexPath:indexPath];
    [cell.contentView addSubview:view];
    
    
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
