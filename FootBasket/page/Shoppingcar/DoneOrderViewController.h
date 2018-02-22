//
//  DoneOrderViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

//订单确认

#import <UIKit/UIKit.h>

@interface DoneOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    
}

@property(nonatomic,strong)NSArray *arraydata;
@end
