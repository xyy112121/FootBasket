//
//  CategoryLeftMenu.h
//  FootBasket
//
//  Created by xyy on 2018/2/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryLeftMenu : UIView<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    UITableView *tableview;
    NSString *strselect;
    int selectone;
    NSArray *arraydata;
}
@property(nonatomic,weak)id<ActionDelegate>delegate1;
- (instancetype)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic;
-(void)getCategorysmall:(NSDictionary *)dic;
@end
