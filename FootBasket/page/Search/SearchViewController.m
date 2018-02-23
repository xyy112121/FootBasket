//
//  SearchViewController.m
//  FootBasket
//
//  Created by xyy on 2018/2/23.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    arraydata = [[NSMutableArray alloc] init];
    NSFileManager *filemanger = [NSFileManager defaultManager];
    if([filemanger fileExistsAtPath:Cache_SearchHistory])
    {
        arraydata = [[NSMutableArray alloc] initWithContentsOfFile:Cache_SearchHistory];
    }
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarAndNavigationHeight-50) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    
    if([arraydata count]>0)
        [self initfootview];
}

-(void)initfootview
{
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    tableview.tableFooterView = footview;
    
    UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.frame = CGRectMake((SCREEN_WIDTH-200)/2, 13, 200, 34);
    [buttonright setTitle:@"清空搜索历史" forState:UIControlStateNormal];
    buttonright.layer.cornerRadius = 2.0f;
    buttonright.layer.borderColor = COLORNOW(172, 172, 172).CGColor;
    buttonright.layer.borderWidth = 0.7f;
    buttonright.clipsToBounds = YES;
    [buttonright setTitleColor:COLORNOW(172, 172, 172) forState:UIControlStateNormal];
    [buttonright addTarget:self action:@selector(clickcleanhistory:) forControlEvents:UIControlEventTouchUpInside];
    buttonright.titleLabel.font = FONTN(15.0f);
    [footview addSubview:buttonright];
    
}

-(UIView *)topnavigationview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,44)];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(10,8, XYViewWidth(view)-70, 28)];
    imagebg.layer.cornerRadius = 14.0f;
    imagebg.clipsToBounds = YES;
    imagebg.layer.borderColor = COLORNOW(32, 188, 167).CGColor;
    imagebg.layer.borderWidth = 1.0f;
    [view addSubview:imagebg];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(imagebg)+10,XYViewTop(imagebg)+6, 16, 16)];
    imageicon.image = LOADIMAGE(@"searchicon", @"png");
    [view addSubview:imageicon];
    
    textfieldsearch = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+5, XYViewTop(imagebg)+1, XYViewWidth(imagebg)-40, XYViewHeight(imagebg)-2)];
    textfieldsearch.font = FONTN(15.0f);
    textfieldsearch.delegate = self;
    textfieldsearch.placeholder = @"搜索";
    textfieldsearch.backgroundColor = [UIColor clearColor];
    [view addSubview:textfieldsearch];
    
    UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.frame = CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
    [buttonright setTitle:@"取消" forState:UIControlStateNormal];
    [buttonright setTitleColor:COLORNOW(172, 172, 172) forState:UIControlStateNormal];
    [buttonright addTarget:self action:@selector(clickrightcannel:) forControlEvents:UIControlEventTouchUpInside];
    buttonright.titleLabel.font = FONTN(16.0f);
    [view addSubview:buttonright];
    
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
    
    [viewnavigation removeFromSuperview];
    viewnavigation =  [self topnavigationview];
    viewnavigation.tag = EnSearchNavigationBgViewTag;
    [self.navigationController.navigationBar addSubview:viewnavigation];
}

#pragma mark - IBAction
-(void)clickrightcannel:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickcleanhistory:(id)sender
{
    [arraydata removeAllObjects];
    [tableview reloadData];
    NSFileManager *filemanger = [NSFileManager defaultManager];
    [filemanger removeItemAtPath:Cache_SearchHistory error:nil];
}

#pragma mark - UItextfielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if([textField.text length]>1)
    {
        int flag = 0;
        for(int i=0;i<[arraydata count];i++)
        {
            NSString *str = [arraydata objectAtIndex:i];
            if([str isEqualToString:textField.text])
            {
                flag = 1;
                break;
            }
        }
        if(flag == 0)
        {
            if([arraydata count]>20)
                [arraydata removeObjectAtIndex:0];
            [arraydata addObject:textField.text];
            [arraydata writeToFile:Cache_SearchHistory atomically:YES];
            [tableview reloadData];
        }
        
        
    }
    else
    {
        [MBProgressHUD showError:@"搜索字符至少输入两个" toView:app.window];
    }
    return YES;
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
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = COLORNOW(240, 240, 240);
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    labeltitle.text = @"热门搜索";
    labeltitle.font = FONTN(15.0f);
    labeltitle.textColor = COLORNOW(172, 172, 172);
    labeltitle.backgroundColor = [UIColor clearColor];
    [view addSubview:labeltitle];
    
    return view;
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
    cell.textLabel.text = [arraydata objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchResultViewController *result = [[SearchResultViewController alloc] init];
    result.FCSearchStr = [arraydata objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:result animated:YES];
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
