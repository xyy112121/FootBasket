//
//  SettingViewController.m
//  FootBasket
//
//  Created by xyy on 2018/3/1.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    arraypic = [[NSMutableArray alloc] init];
    self.title = @"基本信息设置";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor clearColor];

    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    
    
    UIButton *buttonlogout = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlogout.frame = CGRectMake(0, SCREEN_HEIGHT-StatusBarAndNavigationHeight-50-IPhone_SafeBottomMargin, SCREEN_WIDTH, 50);
    buttonlogout.backgroundColor = COLORNOW(238, 89, 83);
    [buttonlogout setTitle:@"退出登录" forState:UIControlStateNormal];
    [buttonlogout addTarget:self action:@selector(clicklogout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonlogout];
    
    
}

#pragma mark - viewcontroller delegate
-(void)viewWillAppear:(BOOL)animated
{
    if([app.userinfo.usertype isEqualToString:@"0"]||[app.userinfo.usertype isEqualToString:@"2"])
        [self getuserinfo];
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
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clicklogout:(id)sender
{
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = [NSString stringWithFormat:@"你确定要退出登录吗？"];
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSFileManager *filemanger = [NSFileManager defaultManager];
        [filemanger removeItemAtPath:Cache_UserInfo error:nil];
        app.userinfo = [UserInfo new];
        [self.navigationController popViewControllerAnimated:YES];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 70;
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10,(XYViewHeight(cell.contentView)-20)/2, 100, 20)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = COLORNOW(52, 52, 52);
    labeltitle.font = FONTN(15.0f);
    [cell.contentView addSubview:labeltitle];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, (XYViewHeight(cell.contentView)-20)/2, 50, 50)];
    imageview.layer.cornerRadius = 20.0f;
    imageview.clipsToBounds = YES;
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200,(XYViewHeight(cell.contentView)-20)/2, 170, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.textAlignment = NSTextAlignmentRight;
    labelvalue.font = FONTN(15.0f);

    
    switch (indexPath.row)
    {
        case 0:
            labeltitle.text = @"头像";
            imageview.tag = EnUserInfoAvatarTag;
            imageview.layer.cornerRadius = 25;
            imageview.clipsToBounds = YES;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLPicHeader,[dicuser objectForKey:@"avatar"]]] placeholderImage:LOADIMAGE(@"图层20", @"png")];
            [cell.contentView addSubview:imageview];
            break;
        case 1:
            labeltitle.text = @"昵称";
            labelvalue.text = [dicuser objectForKey:@"userLogin"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 2:
            labeltitle.text = @"真实姓名";
            labelvalue.text = [dicuser objectForKey:@"realName"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 3:
            labeltitle.text = @"电话号码";
            labelvalue.text = [dicuser objectForKey:@"mobile"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 4:
            labeltitle.text = @"门店信息";
            labelvalue.text = [NSString stringWithFormat:@"%d",(int)[arraymerchant count]];
            [cell.contentView addSubview:labelvalue];
            break;

    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==4)
    {
        RestaurantInfoViewController *restaurant = [[RestaurantInfoViewController alloc] init];
        [self.navigationController pushViewController:restaurant animated:YES];
    }
    else if(indexPath.row == 1)
    {
        SettingModifyUserInfoViewController *modify = [[SettingModifyUserInfoViewController alloc] init];
        modify.FCStrTitle = @"昵称";
        modify.FCStrsrc = [dicuser objectForKey:@"userLogin"];
        [self.navigationController pushViewController:modify animated:YES];
    }
    else if(indexPath.row == 2)
    {
        SettingModifyUserInfoViewController *modify = [[SettingModifyUserInfoViewController alloc] init];
        modify.FCStrTitle = @"真实姓名";
        modify.FCStrsrc = [dicuser objectForKey:@"realName"];
        [self.navigationController pushViewController:modify animated:YES];
    }
    else if(indexPath.row == 0)
    {
        [JPhotoMagenage JphotoGetFromSystemInController:self finish:^(UIImage *image) {
            UIImageView *imageview = [tableview viewWithTag:EnUserInfoAvatarTag];
            imageview.image = image;
            [arraypic removeAllObjects];
            [arraypic addObject:image];
            [self uploadavatarimage];
        } cancel:^{
            
        }];
    }
}

#pragma mark - 接口
-(void)getuserinfo
{
    SettingService *setservice = [SettingService new];
    
    [setservice sendGetUserInfoRequest:app.userinfo.userid App:app ReqUrl:RQMyUserCenter successBlock:^(NSDictionary *dicData) {
        dicuser = [dicData objectForKey:@"user"];
        arraymerchant = [dicData objectForKey:@"merchant"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
    }];
}

-(void)uploadavatarimage
{
    SettingService *setservice = [SettingService new];
    if([arraypic count]>0)
    {
        [setservice sendUserInfoAvatarRequest:app.userinfo.userid Avatar:arraypic App:app ReqUrl:RQUploadUserAvatar successBlock:^(NSDictionary *dicData) {
            [MBProgressHUD showSuccess:[dicData objectForKey:@"resultInfo"] toView:app.window];
            app.userinfo.userheader = [[dicData objectForKey:@"user"] objectForKey:@"avatar"];
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
