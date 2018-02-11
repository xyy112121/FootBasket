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
    NSArray *arraydata;
}

@end
