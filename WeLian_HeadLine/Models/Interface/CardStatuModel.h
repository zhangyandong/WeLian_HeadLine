//
//  CardStatuModel.h
//  Welian
//
//  Created by dong on 15/3/9.
//  Copyright (c) 2015年 chuansongmen. All rights reserved.
//

#import "IFBase.h"

@interface CardStatuModel : IFBase

// cid 为0 时表示已删除
@property (nonatomic, strong) NSNumber *cid;
 //3 活动，10项目，11 网页  13 投递项目卡片 14 用户名片卡片 15 投资人索要项目卡片
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *content;

@end
