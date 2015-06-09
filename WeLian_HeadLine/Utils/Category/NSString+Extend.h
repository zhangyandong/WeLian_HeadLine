//
//  NSString+Extend.h
//  The Dragon
//
//  Created by yangxh on 12-7-19.
//  Copyright (c) 2012年 杭州引力网络技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

- (BOOL)isUrl;
- (BOOL)isMobile;
- (BOOL)isEmail;
- (BOOL)isContainsString:(NSString *)string;

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;

//将NSString转化为NSArray或者NSDictionary
- (id)JSONValue;
- (NSString *)MD5String;//md5加密

- (BOOL)isMobileNumber;//判断是否是中国的手机号码
- (NSString *)mobileType;//判断手机号码的类型

//日期转换
- (NSDate *)dateFromShortString;
- (NSDate *)dateFromString;
- (NSDate *)dateFromNormalString;
//不带秒的时间格式
- (NSDate *)dateFromNormalStringNoss;

//去除两端空格
- (NSString *)deleteTopAndBottomKongge;
- (NSString *)deleteTopAndBottomKonggeAndHuiche;

//汉字首字母转换
- (NSString *)getHanziFirstString;

//获取时间戳
+ (NSString *)getNowTimestamp;

// 字节长度
-(int)charNumber;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;
@end
