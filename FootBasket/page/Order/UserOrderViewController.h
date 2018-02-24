//
//  UserOrderViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    UIImageView *selectline;
    NSDictionary *dicresponse;
}
@property(nonatomic,strong)NSString *orderstate;
@end
