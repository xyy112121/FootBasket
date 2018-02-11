//
//  CommonHeader.m
//  SceneKitRobot
//
//  Created by 谢毅 on 2017/11/28.
//  Copyright © 2017年 EPOQUE. All rights reserved.
//

#import "CommonHeader.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>
@implementation CommonHeader



/**
 画水印
 **/
- (UIImage *)CMSetImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect Frame:(CGRect)frame
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    }
    //原图
    [image drawInRect:frame];
    
    //水印图
    [mark drawInRect:rect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
//    self.image = newPic;
}

/**
 删除NSUserDefaults所有记录
 **/

-(void)CMRemovedefaultallkeyworlds
{
    //方法一
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    //方法二

//        NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
//        NSDictionary * dict = [defs dictionaryRepresentation];
//        for (id key in dict) {
//            [defs removeObjectForKey:key];
//        }
//        [defs synchronize];

    // 方法三
//    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
}

/**
 跳进app权限设置
 **/
-(void)CMJumpAppAuthSetting
{
    if (UIApplicationOpenSettingsURLString != NULL)
    {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
}

/**
 获取app缓存大小
 获取Library/Caches 目录下面折存储大小   如果用的是第三方的缓存，可以直接用第三方缓存来处理
 **/
-(CGFloat)CMGetCachSize
{
    // 获取自定义缓存大小
    // 用枚举器遍历 一个文件夹的内容
    // 1.获取 文件夹枚举器
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    __block CGFloat count = 0;
    // 2.遍历
    for (NSString *fileName in enumerator) {
        NSString *path = [myCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        //自定义所有缓存大小
        count += fileDict.fileSize;
    }
    // 得到是字节  转化为M
    CGFloat totalSize = count/1024/1024.0f;
    return totalSize;
}

/**
 几个常用权限判断
 **/

-(void)CMCheckAppAuthorization
{
//    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied{
//
//        NSLog(@"没有定位权限");
//    }
//        AVAuthorizationStatus statusVideo = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (statusVideo == AVAuthorizationStatusDenied) {
//            NSLog(@"没有摄像头权限");
//        }
//        AVAuthorizationStatus statusAudio = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
//        if (statusAudio == AVAuthorizationStatusDenied) {
//            NSLog(@"没有录音权限");
//        }
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//        if (status == PHAuthorizationStatusDenied) {
//            NSLog(@"没有相册权限");
//        }
//    }];
}

/**
 *  手机号码验证
 *
 *  @param mobileNum 手机号
 *
 *  @return 是否
 */
- (BOOL)CMisMobileNumber:(NSString *)mobileNum
{
    
    if (mobileNum.length != 11){
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
     * 电信号段: 133,134,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[013678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,152,155,156,170,171,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[256]|7[016]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,134,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[34]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)){
        
        return YES;
    }
    else{
        return NO;
    }
}

/**
 邮箱验证
 
 @param email 邮箱地址
 @return 是否
 */
- (BOOL)CMisValidateEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 根据正则，过滤特殊字符
 
 @param regexString 正则表达式
 @return 过滤后的字符串
 */
- (NSString *)CMFilterCharactorWithRegex:(NSString *)regexString {
    
    NSString *searchText = regexString;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}


/**
 身份证号码验证
 * 验证方法：
 * 1、将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2
 * 2、将这17位数字和系数相乘的结果相加
 * 3、用加出来和除以11，看余数是多少？
 * 4、余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字。其分别对应的最后一位身份证的号码为1－0－X －9－8－7－6－5－4－3－2
 * 5、通过上面得知如果余数是3，就会在身份证的第18位数字上出现的是9。如果对应的数字是10，身份证的最后一位号码就是罗马数字x
 @return 是/否
 */
- (BOOL)CMisIDCardNumber:(NSString *)strsrc
{
    
    NSInteger sum = 0;
    NSArray *numArr = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2]; // 系数
    NSArray *lastArr = @[@"1", @"0", @"X", @"9", @"8",@"7", @"6", @"5", @"4", @"3", @"2"]; // 最后一位身份证的号码
    
    if ([strsrc length] == 15) {
        NSString *lastCharactor =[strsrc substringFromIndex:[strsrc length] -1];
        if ([lastCharactor isEqualToString:@"X"] || [lastCharactor isEqualToString:@"x"])
        {
            NSString * subStr14 = [strsrc substringToIndex:[strsrc length] -1];
            return [self CMisPureInt:subStr14];
        }
        else
        {
            return [self CMisPureInt:strsrc];
        }
        
    }
    if ([strsrc length] == 18) {
        //将字符串转化为大写
        NSString *newString =[strsrc uppercaseString];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < [strsrc length]; i++) {
            [array addObject:[NSString stringWithFormat:@"%C", [newString characterAtIndex:i]]];
        }
        
        for (int i = 0; i < [strsrc length] - 1; i++) {
            sum += [array[i] integerValue] * [numArr[i] integerValue];
        }
        return [array[17] isEqualToString:lastArr[sum % 11]];
    }
    
    return NO;
}

/**
 车牌校验
 
 @return 是/否
 */
- (BOOL)CMisCarLicenceNum:(NSString *)strsrc
{
    
    if ([strsrc length] == 7 || [strsrc length] == 8)
    {
        NSString *carRegex = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
        return [carTest evaluateWithObject:self];
    }else{
        return NO;
    }
}

/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)CMDictionaryWithJsonString:(NSString *)jsonString
{
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"%@json解析失败：%@",jsonString,err);
        return nil;
        
    }
    return dic;
}

/**
 *  字典转json格式字符串：
 *
 */

- (NSString*)CMDataToJson:(id)data
{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  图片缩放
 *
 */
-(UIImage *)CMScaleToSize:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  获取stringsize大小
 *
 */
-(CGSize)CMGetlablesize:(NSString *)str Fwidth:(float)fwidth Fheight:(float)fheight Sfont:(UIFont *)sfont Spaceing:(float)spaceing
{
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
////    [style setLineBreakMode:NSLineBreakByCharWrapping];
//
//
//    NSDictionary *attributes = @{ NSFontAttributeName : sfont, NSParagraphStyleAttributeName : style };
//
//
//    CGSize Sizetemp = [str boundingRectWithSize:CGSizeMake(fwidth,fheight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    // 段落设置与实际显示的 Label 属性一致 采用 NSMutableParagraphStyle 设置Nib 中 Label 的相关属性传入到 NSAttributeString 中计算；
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:style}];
    
    CGSize Sizetemp =  [string boundingRectWithSize:CGSizeMake(fwidth, fheight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    NSLog(@" size =  %@", NSStringFromCGSize(Sizetemp));
    
    
    return Sizetemp;
}

//-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
//    if (!text || lineSpacing < 0.01) {
//        self.text = text;
//        return;
//    }
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
//
//    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
//    self.attributedText = attributedString;
//}

/**
 *  获取MD5
 *
 */
-(NSString *) CMMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02x", result[i]];
    }
    return md5String;
}

/**
 *  获取随机ID
 *
 */
-(NSString *)CMRandomId:(int)numwei
{
    NSDate *nowdate = [NSDate date];
    NSDateFormatter* dateFormat123 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat123 setDateFormat:@"yyyyMMddHHmmss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *randomstr = [dateFormat123 stringFromDate:nowdate];
    NSString *stringconst = @"abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSInteger x;
    for(int i = 0;i<numwei;i++)
    {
        x = arc4random()%61;
        randomstr = [randomstr stringByAppendingString:[stringconst substringWithRange:NSMakeRange(x,1)]];
    }
    DLog(@"randomstr=======%@",randomstr);
    return randomstr;
}

/**
 *  返回时间
 *
 */
-(NSString *)CMReturnnowdate:(NSString *)strformat
{
    //@"yyyy-MM-dd HH:mm:ss"
    NSDate *nowdate = [NSDate date];
    NSDateFormatter* dateFormat123 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat123 setDateFormat:strformat];//设定时间格式,这里可以设置成自己需要的格式
    NSString *nowdatestr = [dateFormat123 stringFromDate:nowdate];
    return nowdatestr;
}

/**
 *  json格式字典：
 *
 */
-(id)CMToArrayOrNSDictionary:(NSData *)jsonData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

/**
 判断字符串是否是纯数字
 
 @param string 带判断字符串
 @return 是/否
 */
- (BOOL)CMisPureInt:(NSString *)string
{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

/**
 计算时长
 */
- (NSString *)CMCaculateDurationWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime
{
    if (endTime == nil) {
        return @"未知";
    }
    NSDate *startDate           = [NSDate date];
    NSDate *endDate             = [NSDate date];
    
    NSDateFormatter *format     = [[NSDateFormatter alloc]init];
    format.dateFormat           = @"YYYY-MM-dd HH:mm:ss";
    format.timeZone             = [NSTimeZone systemTimeZone];
    startDate                   = [format dateFromString:startTime];
    endDate                         = [format dateFromString:endTime];
    NSTimeInterval duration     = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970;
    int hour                        = (int)duration / 3600;
    int min                         = (int)duration % 3600 / 60;
    int sec                         = (int)duration % 60;
    
    return [NSString stringWithFormat:@"%d小时%d分%d秒",hour,min,sec];
}

/**
 *  返回两个NSDate经历了多少天
 */
- (NSInteger)CMGetDaysFrom:(NSDate *)startDate To:(NSDate *)endDate
{
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:startDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}

/**
 *  修正图片方向
 *
 *  @return 修改后的图片
 */
- (UIImage *)CMFixOrientation:(UIImage *)imagesrc
{
    
    // No-op if the orientation is already correct
    if (imagesrc.imageOrientation == UIImageOrientationUp) return imagesrc;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (imagesrc.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, imagesrc.size.width, imagesrc.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, imagesrc.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, imagesrc.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (imagesrc.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, imagesrc.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, imagesrc.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, imagesrc.size.width, imagesrc.size.height,
                                             CGImageGetBitsPerComponent(imagesrc.CGImage), 0,
                                             CGImageGetColorSpace(imagesrc.CGImage),
                                             CGImageGetBitmapInfo(imagesrc.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (imagesrc.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,imagesrc.size.height,imagesrc.size.width), imagesrc.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,imagesrc.size.width,imagesrc.size.height), imagesrc.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/**
 *  转成黑白图像
 *
 *  @param sourceImage 原图
 *
 *  @return 黑白图像
 */
- (UIImage*)CMCovertToGrayImageFromImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    // 指定颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    // 创建图形上下文
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    // 绘制图片
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    // 得到图片
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

/**
 输入框是否是浮点数
 */
-(BOOL)CMisPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}



@end
