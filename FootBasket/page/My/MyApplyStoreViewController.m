//
//  MyApplyStoreViewController.m
//  FootBasket
//
//  Created by xyy on 2018/3/21.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "MyApplyStoreViewController.h"

@interface MyApplyStoreViewController ()

@end

@implementation MyApplyStoreViewController

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
    self.title = @"添加商户信息";
    
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
    return 2;
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
    
    
    
    
    switch (indexPath.row)
    {
        case 0:
           
            labeltitle.text = @"真实姓名";
            [cell.contentView addSubview:labeltitle];
            
            textfieldrealnamevalue = [[UITextField alloc] initWithFrame:CGRectMake(100,10, 200, 30)];
            textfieldrealnamevalue.backgroundColor = [UIColor clearColor];
            textfieldrealnamevalue.textColor = [UIColor blackColor];
            textfieldrealnamevalue.font = FONTN(15.0f);
            textfieldrealnamevalue.placeholder = @"请输入真实姓名";
            [cell.contentView addSubview:textfieldrealnamevalue];
            break;
            
        case 1:
            
            labeltitle.text = @"餐馆名称";
            [cell.contentView addSubview:labeltitle];
            
            textfieldstorenamevalue = [[UITextField alloc] initWithFrame:CGRectMake(100,10, 200, 30)];
            textfieldstorenamevalue.backgroundColor = [UIColor clearColor];
            textfieldstorenamevalue.textColor = [UIColor blackColor];
            textfieldstorenamevalue.font = FONTN(15.0f);
            textfieldstorenamevalue.placeholder = @"请输入餐馆名称";
            [cell.contentView addSubview:textfieldstorenamevalue];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 接口
-(void)clicksave:(id)sender
{
    if([textfieldrealnamevalue.text length]==0)
    {
        [MBProgressHUD showError:@"请输入真实姓名" toView:app.window];
        return;
    }
    else if([textfieldstorenamevalue.text length]==0)
    {
        [MBProgressHUD showError:@"请输入餐饮名称" toView:app.window];
        return;
    }
    SettingService *setservice = [SettingService new];
    
    [setservice sendStorebussiseRequest:app.userinfo.userid Name:textfieldrealnamevalue.text StoreName:textfieldstorenamevalue.text App:app ReqUrl:RQRequestStoreBuss successBlock:^(NSDictionary *dicData) {
        
        NSDictionary *dictemp = [dicData objectForKey:@"user"];
        [dictemp writeToFile:Cache_UserInfo atomically:NO];
        app.userinfo.userid = [dictemp objectForKey:@"id"];
        app.userinfo.usertel = [dictemp objectForKey:@"mobile"];
        app.userinfo.username = [dictemp objectForKey:@"realName"];
        app.userinfo.userheader = [dictemp objectForKey:@"avatar"];
        app.userinfo.usernickname = [dictemp objectForKey:@"userLogin"];
        app.userinfo.usertype = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"userType"]];
        
        
        NSString *title = NSLocalizedString(@"提示", nil);
        NSString *message = [dicData objectForKey:@"resultInfo"];
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        // Add the actions.
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
