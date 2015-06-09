//
//  WeLian_HeadLineClient.h
//  WeLian_HeadLine
//
//  Created by liuwu on 15/6/7.
//  Copyright (c) 2015年 杭州传送门网络科技有限公司. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface WeLian_HeadLineClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

#pragma mark - 取消所有请求
+ (void)cancelAllRequestHttpTool;

// 微链头条 列表
+ (void)getTouTiaoListWithPage:(NSNumber *)page
                          Size:(NSNumber *)size
                       Success:(SuccessBlock)success
                        Failed:(FailedBlock)failed;

@end
