//
//  MyEditAddrViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEditAddrViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    
    EnSelect selectresult;
    UIImageView *imageviewdefaule;
    
    NSString *FCname;
    NSString *FCtel;
    NSString *FCprovice;
    NSString *FCcity;
    NSString *FCarea;
    NSString *FCdetailaddr;
}

@property(nonatomic,strong)NSDictionary *FCdicaddr;

@end
