//
//  SettingViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/1.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    UITableView *tableview;
    NSDictionary *dicresponse;
    NSMutableArray *arraypic;
    NSDictionary *dicuser;
    NSArray *arraymerchant;
}
@end
