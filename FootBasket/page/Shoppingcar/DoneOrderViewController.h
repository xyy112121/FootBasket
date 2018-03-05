//
//  DoneOrderViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

//订单确认

#import <UIKit/UIKit.h>
#import "DateTimePickerView.h"
@interface DoneOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate,UITextFieldDelegate,DateTimePickerViewDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
    NSDictionary *dicresponse;
    NSString *selectaddrid;
    NSString *payway;
    
    NSString *receivetime;
    UIButton *receivebuttontime;
    NSDictionary *dicselectaddr;
}
//@property(nonatomic,strong)DateTimePickerView *datePickerView;
@property(nonatomic,strong)NSArray *arrayproductnum;
@end
