//
//  SearchViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/23.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate,UITextFieldDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSMutableArray *arraydata;
    UITextField *textfieldsearch;
    UIView *viewnavigation;
}
@end
