//
//  AppDelegate.m
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize userinfo;

-(void)getuserinfo
{
    self.userinfo = [UserInfo new];
    NSFileManager *filemanger = [NSFileManager defaultManager];
    if([filemanger fileExistsAtPath:Cache_UserInfo])
    {
        NSDictionary *dictemp = [NSDictionary dictionaryWithContentsOfFile:Cache_UserInfo];
        self.userinfo.userid = [dictemp objectForKey:@"id"];
        self.userinfo.userheader = [dictemp objectForKey:@"avatar"];
        self.userinfo.usertel = [dictemp objectForKey:@"mobile"];
        self.userinfo.username = [dictemp objectForKey:@"realName"];
        self.userinfo.usernickname = [dictemp objectForKey:@"userLogin"];
        self.userinfo.usertype = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"userType"]];
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self getuserinfo];
    self.FCDisplayShoppingCar = @"0";
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
