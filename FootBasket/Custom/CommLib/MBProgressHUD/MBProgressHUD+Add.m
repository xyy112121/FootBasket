//
//  ViewController.h
//  MBProgressHUB+Add
//
//  Created by shen_gh on 16/5/5.
//  Copyright © 2016年 shenAlexy. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
- (void)showSuccess:(NSString *)success
{
    self.detailsLabel.text = success;
    self.detailsLabel.font = [UIFont systemFontOfSize:16];
    // 设置图片
    self.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"success.png"]]];
    // 再设置模式
    self.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    self.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [self hideAnimated:YES afterDelay:2.0];
}
- (void)showError:(NSString *)error
{
    self.detailsLabel.text = error;
    self.detailsLabel.font = [UIFont systemFontOfSize:16];
    // 设置图片
    self.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"error.png"]]];
    // 再设置模式
    self.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    self.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [self hideAnimated:YES afterDelay:2.0];
}
+ (void)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabel.text = message;
    

    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
//    hud. dimBackground = NO;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:2.0];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)timeInterval
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabel.text = message;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
//    hud.dimBackground = NO;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:timeInterval];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = NO;
    return hud;
}
@end
