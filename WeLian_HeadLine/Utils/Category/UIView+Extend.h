//
//  UIView+Extend.h
//  The Dragon
//
//  Created by yangxh on 12-7-3.
//  Copyright (c) 2012年 杭州引力网络技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

// 设置为调试状态
- (void)setDebug:(BOOL)val;

- (UIView *)findFirstResponder;

- (void)dropShadowWithOpacity:(float)opacity;

//获取按钮对象
+ (UIButton *)getBtnWithTitle:(NSString *)title image:(UIImage *)image;

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action;
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight title:(NSString *)strTitle target:(id)target action:(SEL)action;
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight title:(NSString *)strTitle imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action;

@end

