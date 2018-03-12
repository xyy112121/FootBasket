//
//  MyCouponViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/2.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCouponViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    NSString *FCwallet;
    UILabel *labelwalletvalue;
}

@end
