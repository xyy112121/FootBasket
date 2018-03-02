//
//  LoginView.m
//  FootBasket
//
//  Created by xyy on 2018/2/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        usertypelogin = EnNormalSelect;
        [self initView];
    }
    return self;
}

-(void)initView
{
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, StatusBarHeight+20, 120, 25)];
    labelname.text = @"快捷登录";
    labelname.font = FONTB(22.0f);
    [self addSubview:labelname];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, XYViewBottom(labelname)+120, SCREEN_WIDTH-40, 1)];
    imageline1.backgroundColor = COLORNOW(230, 230, 230);
    [self addSubview:imageline1];
    
    UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageline1)+50, SCREEN_WIDTH-40, 1)];
    imageline2.backgroundColor = COLORNOW(230, 230, 230);
    [self addSubview:imageline2];
    
    textfieldtel = [[UITextField alloc] initWithFrame:CGRectMake(XYViewL(imageline1)+5, XYViewTop(imageline1)-35, XYViewWidth(imageline1)-20, 30)];
    textfieldtel.placeholder = @"输入电话号码";
    textfieldtel.text = @"18669069389";//
    textfieldtel.font = FONTN(16.0f);
    textfieldtel.delegate = self;
    [self addSubview:textfieldtel];
    
    textfieldcode = [[UITextField alloc] initWithFrame:CGRectMake(XYViewL(imageline2)+5, XYViewTop(imageline2)-35, XYViewWidth(imageline2)-130, 30)];
    textfieldcode.placeholder = @"输入验证码";
    textfieldcode.font = FONTN(16.0f);
    textfieldcode.delegate = self;
    textfieldcode.text = @"4321";//@"1234";
    [self addSubview:textfieldcode];
    
    buttoncode = [UIButton buttonWithType:UIButtonTypeCustom];
    buttoncode.frame = CGRectMake(SCREEN_WIDTH-110, XYViewTop(imageline2)-43, 100, 35);
    [buttoncode setTitle:@"获取验证码" forState:UIControlStateNormal];
    buttoncode.backgroundColor = COLORNOW(230, 230, 230);
    buttoncode.layer.cornerRadius = 3.0f;
    buttoncode.clipsToBounds = YES;
    [self addSubview:buttoncode];
    
    buttonlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlogin.frame = CGRectMake(XYViewL(imageline2), XYViewBottom(imageline2)+50, XYViewWidth(imageline2), 40);
    [buttonlogin setTitle:@"登录" forState:UIControlStateNormal];
    buttonlogin.backgroundColor = COLORNOW(230, 230, 230);
    buttonlogin.layer.cornerRadius = 3.0f;
    buttonlogin.clipsToBounds = YES;
    [buttonlogin addTarget:self action:@selector(clicklogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonlogin];
    
    
    buttonchange = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonchange.frame = CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT-IPhone_SafeBottomMargin-60, 100, 35);
    [buttonchange setTitle:@"切换商家登录" forState:UIControlStateNormal];
    [buttonchange setTitleColor:COLORNOW(152, 152, 152) forState:UIControlStateNormal];
    buttonchange.titleLabel.font = FONTN(14.0f);
    [buttonchange addTarget:self action:@selector(clickchangeuser:) forControlEvents:UIControlEventTouchUpInside];
    buttonchange.backgroundColor = [UIColor whiteColor];
    [self addSubview:buttonchange];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGestureRecognizer];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textfieldtel.text length]>0||[textfieldcode.text length]>0)
    {
        buttoncode.enabled = YES;
        buttonlogin.enabled = YES;
        buttoncode.backgroundColor = COLORNOW(32, 188, 167);
        buttonlogin.backgroundColor = COLORNOW(32, 188, 167);
        
    }
    else
    {
        buttoncode.enabled = NO;
        buttonlogin.enabled = NO;
        buttoncode.backgroundColor = COLORNOW(230, 230, 230);
        buttonlogin.backgroundColor = COLORNOW(230, 230, 230);
    }
    return YES;
}

-(void)clicklogin:(id)sender
{
    if([textfieldcode.text length]<4)
    {
        [MBProgressHUD showError:@"请输入验证码" toView:app.window];
    }
    else
    {
        LoginService *loginservice = [LoginService new];
        [loginservice sendloginrequest:textfieldtel.text Code:textfieldcode.text App:app ReqUrl:RQLogin successBlock:^(NSDictionary *dicData) {
            DLog(@"dicData====%@",dicData);
            NSDictionary *dictemp = [dicData objectForKey:@"user"];
            [dictemp writeToFile:Cache_UserInfo atomically:NO];
            app.userinfo.userid = [dictemp objectForKey:@"id"];
            app.userinfo.usertel = [dictemp objectForKey:@"mobile"];
            app.userinfo.username = [dictemp objectForKey:@"realName"];
            app.userinfo.userheader = [dictemp objectForKey:@"avatar"];
            app.userinfo.usertype = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"userType"]];
            [self removeFromSuperview];
            if(_delegate1&&[_delegate1 respondsToSelector:@selector(DGLoginSuccess:)])
            {
                [_delegate1 DGLoginSuccess:nil];
            }
        }];
    }
}

-(void)clickchangeuser:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(usertypelogin == EnNormalSelect)
    {
        usertypelogin = EnDeliverySelected;
        [button setTitle:@"切换用户登录" forState:UIControlStateNormal];
        buttoncode.hidden = YES;
        textfieldcode.placeholder = @"输入密码";
        textfieldcode.secureTextEntry = YES;
        textfieldcode.text = @"";
        textfieldtel.text = @"";
    }
    else if(usertypelogin == EnDeliverySelected)
    {
        usertypelogin = EnNormalSelect;
        [button setTitle:@"切换送货员登录" forState:UIControlStateNormal];
        buttoncode.hidden = NO;
        textfieldcode.placeholder = @"输入验证码";
        textfieldcode.secureTextEntry = NO;
        textfieldcode.text = @"";
        textfieldtel.text = @"";
    }
}

#pragma mark - IBAction
-(void)keyboardHide:(id)sender
{
    [textfieldtel resignFirstResponder];
    [textfieldcode resignFirstResponder];
}

@end
