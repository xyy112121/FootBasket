//
//  CommonHeader.h
//  SceneKitRobot
//
//  Created by 谢毅 on 2017/11/28.
//  Copyright © 2017年 EPOQUE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonHeader : NSObject

/**
 画水印
 **/
- (UIImage *)CMSetImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect Frame:(CGRect)frame;

/**
 删除NSUserDefaults所有记录
 **/

-(void)CMRemovedefaultallkeyworlds;

/**
 跳进app权限设置
 **/
-(void)CMJumpAppAuthSetting;

/**
 获取app缓存大小
 获取Library/Caches 目录下面折存储大小   如果用的是第三方的缓存，可以直接用第三方缓存来处理
 **/
-(CGFloat)CMGetCachSize;

/**
 *  手机号码验证
 *
 *  @param mobileNum 手机号
 *
 *  @return 是否
 */
- (BOOL)CMisMobileNumber:(NSString *)mobileNum;

/**
 邮箱验证
 
 @param email 邮箱地址
 @return 是否
 */
- (BOOL)CMisValidateEmail:(NSString *)email;

/**
 根据正则，过滤特殊字符
 
 @param regexString 正则表达式
 @return 过滤后的字符串
 */
- (NSString *)CMFilterCharactorWithRegex:(NSString *)regexString;

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
- (BOOL)CMisIDCardNumber:(NSString *)strsrc;

/**
 车牌校验
 @return 是/否
 */
- (BOOL)CMisCarLicenceNum:(NSString *)strsrc;

/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)CMDictionaryWithJsonString:(NSString *)jsonString;

/**
 *  转json格式字符串：
 *
 */
- (NSString*)CMDataToJson:(id)data;

/**
 *  json格式字典：
 *
 */
-(id)CMToArrayOrNSDictionary:(NSData *)jsonData;

/**
 *  图片缩放
 *
 */
-(UIImage *)CMScaleToSize:(UIImage *)img size:(CGSize)size;

/**
 *  获取stringsize大小
 *
 */
-(CGSize)CMGetlablesize:(NSString *)str Fwidth:(float)fwidth Fheight:(float)fheight Sfont:(UIFont *)sfont Spaceing:(float)spaceing;

/**
 *  获取MD5
 *
 */
-(NSString *) CMMD5:(NSString *)str;

/**
 *  返回当前 时间格式
 *
 */
-(NSString *)CMReturnnowdate:(NSString *)strformat;

/**
 判断字符串是否是纯数字
 @param string 带判断字符串
 @return 是/否
 */
- (BOOL)CMisPureInt:(NSString *)string;

/**
 输入框是否是浮点数
 */
-(BOOL)CMisPureFloat:(NSString*)string;

/**
 计算时长
 */
- (NSString *)CMCaculateDurationWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime;

/**
 *  返回两个NSDate经历了多少天
 */
- (NSInteger)CMGetDaysFrom:(NSDate *)startDate To:(NSDate *)endDate;

/**
 *  修正图片方向
 *
 *  @return 修改后的图片
 */
- (UIImage *)CMFixOrientation:(UIImage *)imagesrc;

/**
 *  转成黑白图像
 *
 *  @param sourceImage 原图
 *
 *  @return 黑白图像
 */
- (UIImage*)CMCovertToGrayImageFromImage:(UIImage*)sourceImage;
@end
