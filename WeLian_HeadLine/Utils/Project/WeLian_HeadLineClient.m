//
//  WeLian_HeadLineClient.m
//  WeLian_HeadLine
//
//  Created by liuwu on 15/6/7.
//  Copyright (c) 2015年 杭州传送门网络科技有限公司. All rights reserved.
//

#import "WeLian_HeadLineClient.h"

@implementation WeLian_HeadLineClient

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        //设置传输为json格式
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"text/plain"]];
    }
    return self;
}

+ (instancetype)sharedClient
{
    static WeLian_HeadLineClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WeLian_HeadLineClient alloc] initWithBaseURL:[NSURL URLWithString:[UserDefaults boolForKey:WLHttpCheck]?WLHttpTestServer:WLHttpServer]];
    });
    return _sharedClient;
}

//post请求
+ (void)reqestPostWithParams:(NSDictionary *)params Path:(NSString *)path Success:(SuccessBlock)success
                      Failed:(FailedBlock)failed
{
    //设置sessionid
//    NSString *sessid = [UserDefaults objectForKey:kSessionId];
    
    NSString *pathInfo = path;
//    if (sessid.length) {
//        pathInfo = [NSString stringWithFormat:@"%@?sessionid=%@",path,@"bf50ad9e3f1cbf853d4de2fb3c592411"];
//    }
//    pathInfo = [NSString stringWithFormat:@"%@?sessionid=%@",path,@"9d1cfebab1848a8351488a13725c9bde"];
    
    [[WeLian_HeadLineClient sharedClient] POST:pathInfo
                           parameters:params
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  DLog(@"reqest----- %@---- %@",path,[responseObject DESdecrypt]);
                                  
                                  IBaseModel *result = [IBaseModel objectWithDict:[[responseObject DESdecrypt] JSONValue]];
                                  //如果sessionid有的话放入data
                                  if (result.isSuccess) {
                                      if (result.sessionid.length > 0) {
                                          //保存session
                                          [UserDefaults setObject:result.sessionid forKey:kSessionId];
                                      }
                                      SAFE_BLOCK_CALL(success, result.data);
                                  }else{
                                      if (result.state.integerValue > 1000 && result.state.integerValue < 2000) {
//                                          if (result.state.integerValue==1010) {
//                                              // 未登录
//                                              AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                                              [appDelegate logout];
//                                          }
                                          //可以提醒的错误
                                          SAFE_BLOCK_CALL(failed, result.error);
                                          if (result.state.integerValue != 1010) {
                                              [WLHUDView showErrorHUD:result.errormsg];
                                          }
                                      }else if(result.state.integerValue >= 2000 && result.state.integerValue < 3000){
                                          //系统级错误，直接打印错误信息
                                          DLog(@"Result System ErroInfo-- : %@",result.errormsg);
                                          SAFE_BLOCK_CALL(failed, nil);
                                      }else if(result.state.integerValue>=3000){
                                          //打印错误信息 ，返回操作
                                          DLog(@"Result ErroInfo-- : %@",result.errormsg);
                                          SAFE_BLOCK_CALL(success, result.data);
                                      }else{
                                          DLog(@"Result ErroInfo-- : %@",result.errormsg);
                                          SAFE_BLOCK_CALL(failed, nil);
                                      }
                                  }
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  //打印错误信息
                                  SAFE_BLOCK_CALL(failed, nil);
                                  if (error.code == -1001) {
                                      [WLHUDView showErrorHUD:@"请求超时，请检查网络"];
                                  }else{
                                      [WLHUDView hiddenHud];
                                  }
                                  //                                  if (error.code == -1009) {
                                  //                                      [WLHUDView showErrorHUD:@"网络已断开，请检查网络"];
                                  //                                  }
                                  DLog(@"SystemErroInfo-- : %@",error.description);
                              }];
}

#pragma mark - 取消所有请求
+ (void)cancelAllRequestHttpTool
{
    [[[WeLian_HeadLineClient sharedClient] operationQueue] cancelAllOperations];
}

// 微链头条 列表
+ (void)getTouTiaoListWithPage:(NSNumber *)page
                          Size:(NSNumber *)size
                       Success:(SuccessBlock)success
                        Failed:(FailedBlock)failed
{
    NSDictionary *params = @{@"page":page,
                             @"size":size};
    [self reqestPostWithParams:params
                          Path:KTouTiaoListUrl
                       Success:^(id resultInfo) {
                           DLog(@"getTouTiaoList ---- %@",resultInfo);
                           NSArray *result = [ITouTiaoModel objectsWithInfo:resultInfo];
                           SAFE_BLOCK_CALL(success,result);
                       } Failed:^(NSError *error) {
                           SAFE_BLOCK_CALL(failed, error);
                       }];
}

@end
