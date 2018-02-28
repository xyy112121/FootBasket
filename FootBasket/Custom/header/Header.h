
/**
 TY开头的表示常量自定义
 DG开头表示Delegate自定义
 IF开头表示接口函数自定义
 RQ开头表示接口编码自定义
 GB开头表示全局的数据自定义
 FC开头表示类变量
 **/

#define TYDefaultUserInfo @"defaultuserinfo"
#define TYJWTKey @"pBsHKWefbAuZNxMofj5N"  //JWT的key

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define Tmp_path [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/videos"]
#define Cache_path [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
#define Cache_Remarks [Cache_path stringByAppendingPathComponent:@"CacheRemarks.plist"]
#define Cache_SearchHistory [Cache_path stringByAppendingPathComponent:@"SearchHistory.plist"]
#define Cache_UserInfo [Cache_path stringByAppendingPathComponent:@"UserInfo.plist"]

#define COLORNOW(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define iphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define  iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})
#define StatusBarHeight      (iPhoneX ? 44.f : 20.f)
#define IPhone_SafeBottomMargin  (iPhoneX ? 30.f : 0.f)
#define StatusBarAndNavigationHeight (StatusBarHeight+44)

// View的right、left、bottom、top、width、height
#define XYViewR(View)              (View.frame.origin.x + View.frame.size.width)
#define XYViewL(View)               (View.frame.origin.x)
#define XYViewBottom(View)             (View.frame.origin.y + View.frame.size.height)
#define XYViewTop(View)                (View.frame.origin.y)
#define XYViewWidth(View)              (View.frame.size.width)
#define XYViewHeight(View)             (View.frame.size.height)

//获得iOS版本
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue]

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]

//字体
#define FONTN(F) [UIFont systemFontOfSize:F]
#define FONTB(F) [UIFont fontWithName:@"HelveticaNeue" size:F]//系统默认粗体
#define FONTHelve(F) [UIFont fontWithName:@"Helvetica" size:F]
#define FONTLIGHT(F) [UIFont fontWithName:@"STHeitiTC-Light" size:F]//黑体细体
#define FONTMEDIUM(F) [UIFont fontWithName:@"STHeitiTC-Medium" size:F]//黑体粗体

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


