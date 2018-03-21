//
//  MyApplyStoreViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/21.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyApplyStoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSDictionary *dicresponse;

    UITextField *textfieldrealnamevalue;
    UITextField *textfieldstorenamevalue;
}

@property(nonatomic,strong)NSString *FCStrsrc;
@property(nonatomic,strong)NSString *FCStrTitle;

@end
