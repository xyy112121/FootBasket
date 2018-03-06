//
//  SettingModifyUserInfoViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingModifyUserInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSDictionary *dicresponse;
    NSMutableArray *arraypic;
    NSDictionary *dicuser;
    NSArray *arraymerchant;
    UITextField *textfieldvalue;
}

@property(nonatomic,strong)NSString *FCStrsrc;
@property(nonatomic,strong)NSString *FCStrTitle;
@end
