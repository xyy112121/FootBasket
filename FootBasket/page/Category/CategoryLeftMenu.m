//
//  CategoryLeftMenu.m
//  FootBasket
//
//  Created by xyy on 2018/2/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "CategoryLeftMenu.h"

@implementation CategoryLeftMenu

- (instancetype)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = COLORNOW(240, 240, 240);
        selectone = 0;
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self initview];
        [self getCategorysmall:dic];
    }
    return self;
}

-(void)initview
{
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XYViewWidth(self), XYViewHeight(self)) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor = COLORNOW(235, 235, 235);
    [self addSubview:tableview];

    [self setExtraCellLineHidden:tableview];
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
    return [arraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
    
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
    
    cell.contentView.backgroundColor = COLORNOW(235, 235, 235);
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    if(indexPath.row == selectone)
        cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.text = [dictemp objectForKey:@"name"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectone = (int)indexPath.row;
    for(int i=0;i<100;i++)
    {
        UITableViewCell *cell = [tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.contentView.backgroundColor = COLORNOW(240, 240, 240);
    }
     UITableViewCell *celltemp = [tableview cellForRowAtIndexPath:indexPath];
    celltemp.contentView.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    if(_delegate1&&[_delegate1 respondsToSelector:@selector(DGClickCategorySmall:)])
    {
        [_delegate1 DGClickCategorySmall:dictemp];
    }
}

#pragma mark - 接口

-(void)getCategorysmall:(NSDictionary *)dic
{
    CategoryService *categoryservice = [CategoryService new];
    
    [categoryservice sendCategorySmallRequest:@"1" PageSize:@"10" CategoryId:[dic objectForKey:@"id"] App:app ReqUrl:RQCategoryOther successBlock:^(NSDictionary *dicData) {
        
        arraydata = [dicData objectForKey:@"rows"];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
        if([arraydata count]>0)
        {
            NSDictionary *dictemp = [arraydata objectAtIndex:0];
            if(_delegate1&&[_delegate1 respondsToSelector:@selector(DGClickCategorySmall:)])
            {
                [_delegate1 DGClickCategorySmall:dictemp];
            }
        }
    }];
    
    
}

@end
