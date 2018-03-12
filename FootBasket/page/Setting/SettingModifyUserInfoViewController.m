//
//  SettingModifyUserInfoViewController.m
//  FootBasket
//
//  Created by xyy on 2018/3/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "SettingModifyUserInfoViewController.h"

@interface SettingModifyUserInfoViewController ()

@end

@implementation SettingModifyUserInfoViewController

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
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(2, StatusBarHeight, 60, 40)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"保存"forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:COLORNOW(52, 52, 52) forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(clicksave:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = COLORNOW(240, 240, 240);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    arraypic = [[NSMutableArray alloc] init];
    self.title = @"修改用户信息";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
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

#pragma mark - UItextfielddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

#pragma mark - IBAction
-(void)returnback:(id)sender
{
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    imageline.backgroundColor = COLORNOW(240, 240, 240);
    return imageline;
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
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20,(XYViewHeight(cell.contentView)-20)/2, 100, 20)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = COLORNOW(52, 52, 52);
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = _FCStrTitle;
    [cell.contentView addSubview:labeltitle];
    
    UITextField *textfieldvalue = [[UITextField alloc] initWithFrame:CGRectMake(100,10, 200, 30)];
    textfieldvalue.backgroundColor = [UIColor clearColor];
    textfieldvalue.textColor = [UIColor blackColor];
    textfieldvalue.font = FONTN(15.0f);
    textfieldvalue.placeholder = [NSString stringWithFormat:@"请输入%@",_FCStrTitle];
    textfieldvalue.text = _FCStrsrc;
    textfieldvalue.tag = EnModifyTextfieldValue;
    [cell.contentView addSubview:textfieldvalue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 接口
-(void)clicksave:(id)sender
{
    
    UITableViewCell *cell  = [tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textfield = [cell.contentView viewWithTag:EnModifyTextfieldValue];
    _FCStrsrc = textfield.text;
    if([_FCStrsrc length]==0)
    {
        [MBProgressHUD showError:@"请输入需要修改的信息" toView:app.window];
        return;
    }
    SettingService *setservice = [SettingService new];
    
    if([_FCStrTitle isEqualToString:@"昵称"])
    {
        [setservice sendModifySettingRequest:app.userinfo.userid Name:@"" NickName:_FCStrsrc App:app ReqUrl:RQModifyUserInfo successBlock:^(NSDictionary *dicData) {
            [MBProgressHUD showError:[dicData objectForKey:@"resultInfo"] toView:app.window];
        }];
    }
    else if([_FCStrTitle isEqualToString:@"真实姓名"])
    {
        [setservice sendModifySettingRequest:app.userinfo.userid Name:_FCStrsrc NickName:@"" App:app ReqUrl:RQModifyUserInfo successBlock:^(NSDictionary *dicData) {
            [MBProgressHUD showError:[dicData objectForKey:@"resultInfo"] toView:app.window];
            [self.navigationController popViewControllerAnimated:YES];
        }];
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
