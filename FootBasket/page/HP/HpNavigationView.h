//
//  HpNavigationView.h
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HpNavigationView : UIView<UITextFieldDelegate>
{
    AppDelegate *app;
    UITextField *textfieldinput;
}

-(void)initViewHP;
-(void)initViewCategory;
@property(nonatomic,weak)id<ActionDelegate>delegate1;
@end
