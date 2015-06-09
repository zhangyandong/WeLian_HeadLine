//
//  TouTiaoInfo.m
//  WeLian_HeadLine
//
//  Created by liuwu on 15/6/7.
//  Copyright (c) 2015年 杭州传送门网络科技有限公司. All rights reserved.
//

#import "TouTiaoInfo.h"


@implementation TouTiaoInfo

@dynamic author;
@dynamic created;
@dynamic intro;
@dynamic isShow;
@dynamic photo;
@dynamic title;
@dynamic touTiaoId;
@dynamic url;

+ (TouTiaoInfo *)createTouTiaoInfoWith:(ITouTiaoModel *)iTouTiaoModel
{
    TouTiaoInfo *touTiaoInfo = [self getTouTiaoInfoWithId:iTouTiaoModel.touTiaoId];
    if (!touTiaoInfo) {
        touTiaoInfo = [TouTiaoInfo MR_createEntity];
    }
    touTiaoInfo.touTiaoId = iTouTiaoModel.touTiaoId;
    touTiaoInfo.author = iTouTiaoModel.author;
    touTiaoInfo.created = [iTouTiaoModel.created dateFromNormalStringNoss];
    touTiaoInfo.intro = iTouTiaoModel.intro;
    touTiaoInfo.photo = iTouTiaoModel.photo;
    touTiaoInfo.title = iTouTiaoModel.title;
    touTiaoInfo.url = iTouTiaoModel.url;
    touTiaoInfo.isShow = @(YES);
    
    //    LogInUser *loginUser = [LogInUser getCurrentLoginUser];
    //    if (loginUser) {
    //        [loginUser addRsTouTiaoInfosObject:touTiaoInfo];
    //    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    return touTiaoInfo;
}

+ (TouTiaoInfo *)getTouTiaoInfoWithId:(NSNumber *)touTiaoId
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K == %@", @"touTiaoId",touTiaoId];
    TouTiaoInfo *touTiaoInfo = [TouTiaoInfo MR_findFirstWithPredicate:pre];
    return touTiaoInfo;
}

+ (NSArray *)getAllTouTiaos
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K == %@", @"isShow",@(YES)];
    NSArray *all = [TouTiaoInfo MR_findAllSortedBy:@"created" ascending:NO withPredicate:pre];
    return all;
}

//删除数据库数据。 隐性删除
+ (void)deleteAllTouTiaoInfos
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K == %@", @"isShow",@(YES)];
    NSArray *all = [TouTiaoInfo MR_findAllWithPredicate:pre];
    for (TouTiaoInfo *touTiaoInfo in all) {
        touTiaoInfo.isShow = @(NO);
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


//创建时间
- (NSString *)displayCreateTime
{
    NSString *time = @"";
    if ([self.created isToday]) {
        time = [NSString stringWithFormat:@"今天 %@",[self.created formattedDateWithFormat:@"HH:mm"]];
    }else if ([self.created isYesterday]){
        time = [NSString stringWithFormat:@"昨天 %@",[self.created formattedDateWithFormat:@"HH:mm"]];
    }else{
        time = [self.created formattedDateWithFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    return time;
}

@end
