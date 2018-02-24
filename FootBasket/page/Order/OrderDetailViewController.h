//
//  OrderDetailViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate,UITextFieldDelegate,DateTimePickerViewDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    NSDictionary *dicresponse;

}

@property(nonatomic,strong)NSString *FCorderid;

@end
