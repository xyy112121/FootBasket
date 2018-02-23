//
//  SearchResultViewController.h
//  FootBasket
//
//  Created by xyy on 2018/2/23.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    NSArray *arraydata;
}

@property(nonatomic,strong)NSString *FCSearchStr;
@end
