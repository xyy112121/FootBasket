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
    textfieldtel.text = @"18669069389";
    textfieldtel.font = FONTN(16.0f);
    textfieldtel.delegate = self;
    [self addSubview:textfieldtel];
    
    textfieldcode = [[UITextField alloc] initWithFrame:CGRectMake(XYViewL(imageline2)+5, XYViewTop(imageline2)-35, XYViewWidth(imageline2)-130, 30)];
    textfieldcode.placeholder = @"输入验证码";
    textfieldcode.font = FONTN(16.0f);
    textfieldcode.delegate = self;
    textfieldcode.text = @"1234";
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
    CommonHeader *common = [CommonHeader new];
    if(![common CMisMobileNumber:textfieldtel.text])
    {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:app.window];
    }
    else if([textfieldcode.text length]<4)
    {
        [MBProgressHUD showError:@"请输入验证码" toView:app.window];
    }
    else
    {

        LoginService *loginservice = [LoginService new];
        
        [loginservice sendloginrequest:textfieldtel.text Code:textfieldcode.text App:app ReqUrl:RQLogin successBlock:^(NSDictionary *dicData) {
            app.userinfo.userid = [dicData objectForKey:@"id"];
            app.userinfo.usertel = [dicData objectForKey:@"mobile"];
            app.userinfo.username = [dicData objectForKey:@"mobile"];
            [self removeFromSuperview];
            if(_delegate1&&[_delegate1 respondsToSelector:@selector(DGLoginSuccess:)])
            {
                [_delegate1 DGLoginSuccess:nil];
            }
        }];
    
        
    }
}

@end
