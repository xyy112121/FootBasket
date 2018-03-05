//
//  MyAddrListViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddrListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    
}
@property(nonatomic,weak)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *fromflag;//1表示订单页面进入  2表示个人中心地址管理进入
@end
