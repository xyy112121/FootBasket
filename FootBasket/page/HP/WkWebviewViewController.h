//
//  WkWebviewViewController.h
//  FootBasket
//
//  Created by xyy on 2018/3/9.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WkWebviewViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,ActionDelegate>
{
    AppDelegate *app;
    WKWebView   *wkwebview;
    WKUserContentController * userContentController;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,copy)NSString *FCDiscoveryUrl;

@end
