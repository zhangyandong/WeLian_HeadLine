//
//  NSString+Extend.m
//  The Dragon
//
//  Created by yangxh on 12-7-19.
//  Copyright (c) 2012年 杭州引力网络技术有限公司. All rights reserved.
//

#import "NSString+Extend.h"
//#import "PinYin4Objc.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/sysctl.h>

@implementation NSString (Extend)

- (BOOL)isUrl
{
    NSString * regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isMobile
{
    NSUInteger num = 0;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(1(([357][0-9])|(47)|[8][0126789]))\\d{8}$" options:0 error:nil];
    if (regex) {
        num = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    }
    
    return num > 0;
}

- (BOOL)isEmail
{
    NSUInteger num = 0;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$" options:0 error:nil];
    if (regex) {
        num = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    }
    return num > 0;
}

- (BOOL)isContainsString:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return range.location != NSNotFound;
}

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    }
//    else {
//        expectedLabelSize = [self sizeWithFont:font
//                             constrainedToSize:size
//                                 lineBreakMode:NSLineBreakByWordWrapping];
//    }

    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

//将NSString转化为NSArray或者NSDictionary
- (id)JSONValue;
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

//md5加密
- (NSString *)MD5String
{
    if(self == nil || [self length] == 0){
        return nil;
    }
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
//    NSString * MOBILE = @"[\\d\\+]*1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * MOBILE = @"[\\d\\+]*1([347][0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestmobile evaluateWithObject:self] == YES
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString *)mobileType
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"[\\d\\+]*1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSString *type = @"未知";
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
            NSLog(@"China Mobile");
            type = @"中国移动";
        } else if([regextestct evaluateWithObject:self] == YES) {
            NSLog(@"China Telecom");
            type = @"中国电信";
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            NSLog(@"China Unicom");
            type = @"中国联通";
        } else {
            NSLog(@"Unknow");
            type = @"未知";
        }
    }
    return type;
}

//日期转换
- (NSDate *)dateFromShortString
{
    NSString *string = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:string];
    return date;
}

- (NSDate *)dateFromString
{
    NSString *string = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    NSDate *date = [formatter dateFromString:string];
    return date;
}

- (NSDate *)dateFromNormalString
{
    NSString *string = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:string];
    return date;
}

//不带秒的时间格式
- (NSDate *)dateFromNormalStringNoss
{
    NSString *string = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [formatter dateFromString:string];
    return date;
}

//去除空格
- (NSString *)deleteTopAndBottomKongge
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)deleteTopAndBottomKonggeAndHuiche
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
}

//汉字首字母转换
//- (NSString *)getHanziFirstString
//{
//    //格式类型
//    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
//    [outputFormat setToneType:ToneTypeWithoutTone];
//    [outputFormat setVCharType:VCharTypeWithV];
//    [outputFormat setCaseType:CaseTypeLowercase];
//
//    NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:[self substringToIndex:1] withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
//    return [[NSString stringWithFormat:@"%c",[outputPinyin characterAtIndex:0]] uppercaseString];
//}

//获取时间戳
+ (NSString *)getNowTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)[dat timeIntervalSince1970]];
    return timeString;
}

-(int)charNumber {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);

    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    return platform;
}

/**
 *  根据图片使用场景生成新的URL地址
 *
 *  @param imageScene 使用场景
 *
 *  @return 新的地址
 */
- (NSString *)imageUrlManageScene:(DownloadImageScene)imageScene condenseSize:(CGSize)condenseSize
{
    NSString *deleExestr = [self stringByDeletingPathExtension];
    if ([deleExestr hasSuffix:@"_x"]) return self;
    NSArray *array = [deleExestr componentsSeparatedByString:@"_"];
    if (array.count<3) {
        return self;
    }
    CGFloat originalWidth = [array[1] floatValue];
    CGFloat originalHeight = [array[2] floatValue];
    long long bytesStr = [[array lastObject] longLongValue];
    CGFloat max = MAX(originalWidth, originalHeight);
    if (max<300) return self;
    
    NSString *thumbType = @"w";
    if (originalWidth > originalHeight) {
        thumbType = @"h";
    }
    
    switch (imageScene) {
        case DownloadImageSceneAvatar:
            return [self stringByAppendingFormat:@"@200w_1o.jpg"];
            break;
        case DownloadImageSceneThumbnail:
        {
            NSString *widthStr = [NSString stringWithFormat:@"%.0f",condenseSize.width*2];
            //            NSString *heightStr = [NSString stringWithFormat:@"%.0f",condenseSize.height*4];
            return [self stringByAppendingFormat:@"@80Q_%@%@_1o.jpg",widthStr, thumbType];
        }
            break;
        case DownloadImageSceneTailor:
        {
            NSString *widthStr = [NSString stringWithFormat:@"%.0f",condenseSize.width*2];
            NSString *heightStr = [NSString stringWithFormat:@"%.0f",condenseSize.height*2];
            return [self stringByAppendingFormat:@"@%@x%@-5rc_2o.jpg",widthStr,heightStr];
        }
            break;
        case DownloadImageSceneBig:
        {
            CGFloat byteM = bytesStr/1024.00f;
            CGFloat min = MIN(originalHeight, originalWidth);
            if (min<1000) {
                CGFloat maxPixel = 20.0;
                if (byteM<=1.0) {
                    return self;
                }else if (byteM>1&&byteM<=8){
                    maxPixel = (10-byteM)*10;
                }
                return [self stringByAppendingFormat:@"@%.fQ_1o.jpg",maxPixel];
            }
            
            NSString *oreStr = @"";
            if (originalHeight > 3000 || originalWidth > 3000) {
                if ([thumbType isEqualToString:@"w"]) {
                    oreStr = @"_3000h";
                }else{
                    oreStr = @"_3000w";
                }
            }
            return [self stringByAppendingFormat:@"@%@_1o.jpg",oreStr];
        }
            break;
            
        default:
            break;
    }
    return self;
}

@end
