//
//  RestaurantDetailViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/2.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
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
    NSString *FCpositive;
    NSString *FCopposite;
    NSString *FClicense;
    NSDictionary *dicresponse;
}

@property(nonatomic,copy)NSString *FCrestaurantid;

@end
