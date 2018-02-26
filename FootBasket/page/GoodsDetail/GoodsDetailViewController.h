//
//  GoodsDetailViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/9.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arrayfocus;
    NSArray *arrayattributes;
    NSDictionary *dicproduct;
    UIView *viewpopbuy;
}
@property(nonatomic,strong)NSString *FCGoodsId;
@end
