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
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    UIButton *buttonaddnew = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonaddnew.frame = CGRectMake(0, SCREEN_HEIGHT-50-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin, SCREEN_WIDTH, 50);
    [buttonaddnew setImage:LOADIMAGE(@"添加icon", @"png") forState:UIControlStateNormal];
    [buttonaddnew setTitle:@"添加新地址" forState:UIControlStateNormal];
    [buttonaddnew setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    buttonaddnew.titleLabel.font = FONTN(15.0f);
    [buttonaddnew setBackgroundColor:COLORNOW(32, 188, 167)];
    [buttonaddnew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonaddnew addTarget:self action:@selector(clickaddnew:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonaddnew];
    
    
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
    labelname.text = [dic objectForKey:@"userName"];
    labelname.font = FONTB(16.0f);
    labelname.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labelname];
    
    UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150,XYViewTop(labelname), 140, 20)];
    labeltel.text = [dic objectForKey:@"mobile"];
    labeltel.font = FONTN(16.0f);
    labeltel.textAlignment = NSTextAlignmentRight;
    labeltel.textColor = COLORNOW(52, 52, 52);
    [view addSubview:labeltel];
    
    UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname),XYViewBottom(labelname)+5, SCREEN_WIDTH-20, 40)];
    labeladdr.text =[NSString stringWithFormat:@"%@%@%@%@",[dic objectForKey:@"province"],[dic objectForKey:@"city"],[dic objectForKey:@"county"],[dic objectForKey:@"address"]];
    labeladdr.font = FONTN(14.0f);
    labeladdr.backgroundColor = [UIColor clearColor];
    labeladdr.textColor = COLORNOW(72, 72, 72);
    labeladdr.numberOfLines = 2;
    [view addSubview:labeladdr];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, XYViewBottom(view)-40, 100, 40);
    [button setImage:LOADIMAGE(@"选区", @"png") forState:UIControlStateNormal];
    if([[dic objectForKey:@"isDefault"] intValue]==1)
        [button setImage:LOADIMAGE(@"选择框选中", @"png") forState:UIControlStateNormal];
    [button setTitle:@"默认地址" forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    button.titleLabel.font = FONTN(15.0f);
    [button setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setdefaultaddr:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = indexpath.row+EnMyAddrListDefaultBtTag;
    [view addSubview:button];
    
    UIButton *buttonedit = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonedit.frame = CGRectMake(SCREEN_WIDTH-80, XYViewBottom(view)-40, 70, 40);
    [buttonedit setImage:LOADIMAGE(@"编辑", @"png") forState:UIControlStateNormal];
    [buttonedit setTitle:@"编辑" forState:UIControlStateNormal];
    buttonedit.titleLabel.font = FONTN(15.0f);
    [buttonedit setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [buttonedit setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
    [buttonedit addTarget:self action:@selector(clickeditaddr:) forControlEvents:UIControlEventTouchUpInside];
    buttonedit.tag = indexpath.row+EnMyAddrEditBtTag;
    [view addSubview:buttonedit];
    
    UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
    buttondelete.frame = CGRectMake(XYViewL(buttonedit)-70, XYViewTop(buttonedit), 70, 40);
    [buttondelete setImage:LOADIMAGE(@"删除", @"png") forState:UIControlStateNormal];
    [buttondelete setTitle:@"删除" forState:UIControlStateNormal];
    buttondelete.titleLabel.font = FONTN(15.0f);
    [buttondelete setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [buttondelete setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
    [buttondelete addTarget:self action:@selector(clickdeleteaddr:) forControlEvents:UIControlEventTouchUpInside];
    buttondelete.tag = indexpath.row+EnMyAddrDeleteBtTag;
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
    [self getaddrlist];
}

#pragma mark - IBAction
-(void)returnback:(id)sender
{
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clicksetdefault:(id)sender
{
    
}

-(void)clickeditaddr:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag] - EnMyAddrEditBtTag;
    NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
    MyEditAddrViewController *editaddr = [[MyEditAddrViewController alloc] init];
    editaddr.FCdicaddr = dictemp;
    [self.navigationController pushViewController:editaddr animated:YES];
}

-(void)clickdeleteaddr:(id)sender
{
    
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = [NSString stringWithFormat:@"确定要删除选择的收货地址吗？"];
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIButton *button = (UIButton *)sender;
        int tagnow = (int)[button tag] - EnMyAddrDeleteBtTag;
        NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
        [self deleteaddress:[dictemp objectForKey:@"id"]];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    

}

-(void)clickaddnew:(id)sender
{
    MyNewAddrViewController *addnew = [[MyNewAddrViewController alloc] init];
    [self.navigationController pushViewController:addnew animated:YES];
}

-(void)setdefaultaddr:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnMyAddrListDefaultBtTag;
    
    NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
    [self comitsetdefault:[dictemp objectForKey:@"id"]];
    
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
    UIView *view = [self ViewCell:CGRectMake(0, 0, SCREEN_WIDTH, 120) Dic:dictemp IndexPath:indexPath];
    [cell.contentView addSubview:view];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    if([_fromflag isEqualToString:@"1"])
    {
        if(_delegate1 && [_delegate1 respondsToSelector:@selector(DGClickOrderAddress:)])
        {
            [_delegate1 DGClickOrderAddress:dictemp];
            [self returnback:nil];
        }
    }
    else
    {
        
    }
}

#pragma mark - 接口
-(void)getaddrlist
{
    MangeAddressService *address = [MangeAddressService new];
    [address sendAddrListRequest:app.userinfo.userid App:app ReqUrl:RQAddrList successBlock:^(NSDictionary *dicData) {
        arraydata = [dicData objectForKey:@"rows"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
    }];
}

-(void)deleteaddress:(NSString *)objectid
{
    MangeAddressService *address = [MangeAddressService new];
    [address sendDeleteAddressRequest:objectid App:app ReqUrl:RQDeleteMyAddr successBlock:^(NSDictionary *dicData) {
        [self getaddrlist];
    }];
}

-(void)comitsetdefault:(NSString *)objectid
{
    SettingService *settingservice = [SettingService new];
    [settingservice sendSetDefaultAddressRequest:objectid App:app ReqUrl:RQSetDefaultAddr successBlock:^(NSDictionary *dicData) {
        [self getaddrlist];
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
