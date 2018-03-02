//
//  RestaurantAuthViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/1.
//  Copyright © 2018年 谢毅. All rights reserved.
//

//添加新的餐饮信息

#import <UIKit/UIKit.h>

@interface RestaurantAuthViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    NSString *FCname;
    NSString *FCaddr;
    UIImage *imagepositive;
    UIImage *imageopposite;
    UIImage *imagelicense;
    NSMutableArray *arraypic;
}

@property(nonatomic,copy)NSString *FCrestaurantid;
@end
