//
//  TouTiaoInfo.h
//  WeLian_HeadLine
//
//  Created by liuwu on 15/6/7.
//  Copyright (c) 2015年 杭州传送门网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ITouTiaoModel;

@interface TouTiaoInfo : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * intro;
@property (nonatomic, retain) NSNumber * isShow;//是否显示
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * touTiaoId;
@property (nonatomic, retain) NSString * url;

+ (TouTiaoInfo *)createTouTiaoInfoWith:(ITouTiaoModel *)iTouTiaoModel;
+ (TouTiaoInfo *)getTouTiaoInfoWithId:(NSNumber *)touTiaoId;
+ (NSArray *)getAllTouTiaos;
//删除数据库数据。 隐性删除
+ (void)deleteAllTouTiaoInfos;

//获取创建时间
- (NSString *)displayCreateTime;

@end
