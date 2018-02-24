//
//  ShoppingCarViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSMutableArray *arraydata;
    EnShoppingCarSelectDelete selectdelete;
    EnSelect selectall;
    NSMutableArray *arraydelete;
    UIButton *buttonselectall;//全选中按钮
    NSMutableArray *arrayproductnum;//记录每一个的数目
}

@end
