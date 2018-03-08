//
//  RestaurantDetailViewController.m
//  FootBasket
//
//  Created by xyy on 2018/3/2.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RestaurantDetailViewController.h"

@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController

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
    self.title = @"餐馆信息";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self getrestaurantdetail];
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

#pragma mark - Scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark - IBAction
-(void)keyboardHide:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+0];
    UITextField *textfield2 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+1];
    FCname = textfield1.text;
    FCaddr = textfield2.text;
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    
}

-(void)returnback:(id)sender
{
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addcardpositive:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self keyboardHide:nil];
    [JPhotoMagenage JphotoGetFromSystemInController:self finish:^(UIImage *image) {
        imagepositive = image;
        [button setBackgroundImage:image forState:UIControlStateNormal];
    } cancel:^{
        
    }];
    
}

-(void)addcardopposite:(id)sender
{
    [self keyboardHide:nil];
    UIButton *button = (UIButton *)sender;
    [self keyboardHide:nil];
    [JPhotoMagenage JphotoGetFromSystemInController:self finish:^(UIImage *image) {
        imageopposite = image;
        [button setBackgroundImage:image forState:UIControlStateNormal];
    } cancel:^{
        
    }];
}

-(void)addlicense:(id)sender
{
    [self keyboardHide:nil];
    
    UIButton *button = (UIButton *)sender;
    [self keyboardHide:nil];
    [JPhotoMagenage JphotoGetFromSystemInController:self finish:^(UIImage *image) {
        imagelicense = image;
        [button setBackgroundImage:image forState:UIControlStateNormal];
    } cancel:^{
        
    }];
}

-(void)clicksave:(id)sender
{
    [self keyboardHide:nil];
    [self UploadRestaurantInfo];
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
    if(indexPath.section == 0)
        return 40;
    else if(indexPath.section == 1)
        return 300;
    else
        return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 10;
    return 40;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section ==0)
    {
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        imageline.backgroundColor = COLORNOW(240, 240, 240);
        return imageline;
    }
    else if((section == 1)||(section == 2))
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = COLORNOW(240, 240, 240);
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
        imageview.backgroundColor = [UIColor whiteColor];
        [view addSubview:imageview];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = FONTN(14.0f);
        label.textColor = COLORNOW(52, 52, 52);
        if(section == 1)
            label.text = @"身份证正反面";
        else
            label.text = @"营业执照";
        [view addSubview:label];
        
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
        imageline.backgroundColor = COLORNOW(220, 220, 220);
        [view addSubview:imageline];
        
        return view;
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
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10,(XYViewHeight(cell.contentView)-20)/2, 200, 20)];
        labeltitle.backgroundColor = [UIColor clearColor];
        labeltitle.textColor = COLORNOW(52, 52, 52);
        labeltitle.font = FONTN(15.0f);
        [cell.contentView addSubview:labeltitle];
        
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-110, 30)];
        textfield.backgroundColor = [UIColor clearColor];
        textfield.placeholder = @"请填写名称";
        textfield.font = FONTN(15.0f);
        textfield.textAlignment = NSTextAlignmentRight;
        textfield.textColor = COLORNOW(122, 122, 122);
        [cell.contentView addSubview:textfield];
        
        switch (indexPath.row)
        {
            case 0:
                textfield.tag = EnMyNewAddrTextfieldTag;
                textfield.text = FCname;
                labeltitle.text = @"餐馆名称";
                break;
            case 1:
                textfield.tag =EnMyNewAddrTextfieldTag+1;
                textfield.text = FCaddr;
                labeltitle.text = @"餐馆地址";
                break;
        }
        
    }
    else if(indexPath.section == 1)
    {
        UIButton *buttonpositive = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonpositive.frame = CGRectMake((SCREEN_WIDTH-193)/2, 20, 193, 120);
        [buttonpositive setBackgroundImage:LOADIMAGE(@"addpic", @"png") forState:UIControlStateNormal];
        if(imagepositive)
        {
           [buttonpositive setBackgroundImage:imagepositive forState:UIControlStateNormal];
        }
        else if([FCpositive length]>0)
        {
            [buttonpositive setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URLPicHeader,FCpositive]] placeholderImage:LOADIMAGE(@"addpic", @"png")];
        }
        [buttonpositive addTarget:self action:@selector(addcardpositive:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:buttonpositive];
        
        UIButton *buttonopposite = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonopposite.frame = CGRectMake((SCREEN_WIDTH-193)/2, XYViewBottom(buttonpositive)+20, 193, 120);
        [buttonopposite setBackgroundImage:LOADIMAGE(@"addpic", @"png") forState:UIControlStateNormal];
        if(imageopposite)
        {
            [buttonopposite setBackgroundImage:imageopposite forState:UIControlStateNormal];
        }
        else if([FCopposite length]>0)
        {
            [buttonopposite setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URLPicHeader,FCopposite]] placeholderImage:LOADIMAGE(@"addpic", @"png")];
        }
        [buttonopposite addTarget:self action:@selector(addcardopposite:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:buttonopposite];
    }
    else if(indexPath.section == 2)
    {
        UIButton *buttonlicense = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonlicense.frame = CGRectMake((SCREEN_WIDTH-193)/2, 20, 193, 120);
        [buttonlicense setBackgroundImage:LOADIMAGE(@"addpic", @"png") forState:UIControlStateNormal];
        if(imagelicense)
        {
            [buttonlicense setBackgroundImage:imagelicense forState:UIControlStateNormal];
        }
        else if([FClicense length]>0)
        {
            [buttonlicense setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URLPicHeader,FClicense]] placeholderImage:LOADIMAGE(@"addpic", @"png")];
        }
        [buttonlicense addTarget:self action:@selector(addlicense:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:buttonlicense];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 接口
-(void)UploadRestaurantInfo
{
    SettingService *setservice = [SettingService new];
    if(imagelicense==nil||imagepositive == nil||imageopposite == nil)
    {
        [MBProgressHUD showError:@"请上传认证图片" toView:app.window];
    }
    else
    {
        [arraypic removeAllObjects];
        [arraypic addObject:imagepositive];
        [arraypic addObject:imageopposite];
        [arraypic addObject:imagelicense];
    }
    [setservice sendrestaurantpicRequest:app.userinfo.userid Name:FCname Address:FCaddr RestaurantPic:arraypic App:app ReqUrl:RQUploadRestaurantInfo successBlock:^(NSDictionary *dicData) {
        [MBProgressHUD showSuccess:[dicData objectForKey:@"resultInfo"] toView:app.window];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 接口
-(void)getrestaurantdetail
{
    SettingService *setservice = [SettingService new];
    [setservice sendGetRestaurangDetailRequest:_FCrestaurantid App:app ReqUrl:RQRestaurantDetail successBlock:^(NSDictionary *dicData) {
        dicresponse = [dicData objectForKey:@"merchant"];
        FCname = [dicresponse objectForKey:@"name"];
        FCaddr = [dicresponse objectForKey:@"address"];
        FCpositive = [dicresponse objectForKey:@"cardPositive"];
        FCopposite = [dicresponse objectForKey:@"cardReverse"];
        FClicense = [dicresponse objectForKey:@"license"];
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
