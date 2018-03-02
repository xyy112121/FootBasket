//
//  LoginView.h
//  FootBasket
//
//  Created by xyy on 2018/2/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView<UITextFieldDelegate>
{
    AppDelegate *app;
    UIButton *buttoncode;
    UIButton *buttonlogin;
    UITextField *textfieldtel;
    UITextField *textfieldcode;
    UIButton *buttonchange;
    EnUserTypeLogin usertypelogin;
}
@property(nonatomic,weak)id<ActionDelegate>delegate1;
@end
