//
//  DeliveryDetailViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/26.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliveryDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate,UITextFieldDelegate,DateTimePickerViewDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    NSDictionary *dicresponse;
    UIButton *buttonreceivedone;
}

@property(nonatomic,strong)NSString *FCorderid;

@end
