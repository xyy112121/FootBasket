//
//  MyNewAddrViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "MyNewAddrViewController.h"

@interface MyNewAddrViewController ()

@end

@implementation MyNewAddrViewController

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
    self.title = @"添加新地址";
    selectresult = EnNotSelect;
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-50) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    UIButton *buttonaddnew = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonaddnew.frame = CGRectMake(0, SCREEN_HEIGHT-50-StatusBarAndNavigationHeight-IPhone_SafeBottomMargin, SCREEN_WIDTH, 50);
    [buttonaddnew setTitle:@"保存" forState:UIControlStateNormal];
    [buttonaddnew setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    buttonaddnew.titleLabel.font = FONTN(15.0f);
    [buttonaddnew setBackgroundColor:COLORNOW(32, 188, 167)];
    [buttonaddnew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonaddnew addTarget:self action:@selector(clickdone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonaddnew];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
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
    if(textField.tag == EnMyNewAddrTextfieldTag+2)
    {
        [self keyboardHide:nil];
        [self clickselectcity];
        return NO;
    }
    
    return YES;
}

#pragma mark - IBAction
-(void)returnback:(id)sender
{
    [XLBallLoading hideInView:app.window];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdone:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+0];
    UITextField *textfield2 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+1];
    UITextField *textfield3 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+2];
    UITextField *textfield4 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+3];
    FCname = textfield1.text;
    FCtel = textfield2.text;
    if(([textfield1.text length]==0)||([textfield2.text length]==0)||([textfield3.text length]==0)||([textfield4.text length]==0))
    {
        [MBProgressHUD showError:@"请填写地址信息" toView:app.window];
    }
    else if(![[CommonHeader new] CMisMobileNumber:textfield2.text])
    {
        [MBProgressHUD showError:@"请填写正确的手机号" toView:app.window];
    }
    else
    {
        MangeAddressService *addrservice = [MangeAddressService new];
        [addrservice sendAddNewAddressRequest:FCprovice City:FCcity Area:FCarea Address:FCdetailaddr Tel:FCtel IsDefault:selectresult==EnSelected?@"1":@"0" UserName:FCname UserId:app.userinfo.userid App:app ReqUrl:RQAddNewAddress successBlock:^(NSDictionary *dicData) {
            
            [self returnback:nil];
        }];
    }
}

-(void)clickselectcity
{
    UITextField *textfield = [tableview viewWithTag:EnMyNewAddrTextfieldTag+2];
    [CZHAddressPickerView areaPickerViewWithProvince:FCprovice city:FCcity area:FCarea areaBlock:^(NSString *province, NSString *city, NSString *area) {
        FCprovice = province;
        FCcity = city;
        FCarea = area;
        NSString *text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        textfield.text = text;
    }];
}

-(void)keyboardHide:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+0];
    UITextField *textfield2 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+1];
    UITextField *textfield3 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+2];
    UITextField *textfield4 = [tableview viewWithTag:EnMyNewAddrTextfieldTag+3];
    FCname = textfield1.text;
    FCtel = textfield2.text;
    FCdetailaddr = textfield4.text;
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];

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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 4;
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
    
    
    if(indexPath.section == 0)
    {
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        labelname.textColor = COLORNOW(52, 52, 52);
        labelname.font = FONTN(16.0f);
        [cell.contentView addSubview:labelname];
        
        UITextField *textfieldvalue = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(labelname), 10, SCREEN_WIDTH-120, 20)];
        textfieldvalue.textColor = COLORNOW(52, 52, 52);
        textfieldvalue.font = FONTN(15.0f);
        textfieldvalue.delegate = self;
        [cell.contentView addSubview:textfieldvalue];
        textfieldvalue.tag = EnMyNewAddrTextfieldTag+indexPath.row;
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"收货人";
                textfieldvalue.placeholder = @"添加收货人姓名";
                textfieldvalue.text = FCname;
                break;
            case 1:
                labelname.text = @"联系电话";
                textfieldvalue.placeholder = @"填写联系电话";
                textfieldvalue.text = FCtel;
                break;
            case 2:
                labelname.text = @"所在省市";
                textfieldvalue.placeholder = @"选择省市";
                break;
            case 3:
                labelname.text = @"详细地址";
                textfieldvalue.placeholder = @"填写详细地址";
                textfieldvalue.text = FCdetailaddr;
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        labelname.textColor = COLORNOW(52, 52, 52);
        labelname.font = FONTN(16.0f);
        labelname.text = @"设为默认";
        [cell.contentView addSubview:labelname];
     
        imageviewdefaule = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 10, 20, 20)];
        imageviewdefaule.image = LOADIMAGE(@"选区", @"png");
        [cell.contentView addSubview:imageviewdefaule];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        if(selectresult == EnNotSelect)
        {
            selectresult = EnSelected;
            imageviewdefaule.image = LOADIMAGE(@"选择框选中", @"png");
        }
        else
        {
            selectresult = EnNotSelect;
            imageviewdefaule.image = LOADIMAGE(@"选区", @"png");
        }
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
