//
//  CategoryViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
    HpNavigationView *hpnav;
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    NSArray *arraymain;
    UIImageView *imageselectcategory;
    CategoryLeftMenu *leftcategorymenu;
}

@end
