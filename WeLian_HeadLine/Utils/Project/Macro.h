//
//  Macro.h
//  Welian
//
//  Created by weLian on 15/4/21.
//  Copyright (c) 2015年 chuansongmen. All rights reserved.
//

#ifndef Welian_Macro_h
#define Welian_Macro_h

//微链服务电话 now now
#define kTelNumber @"18658883913"

// 服务器地址
//测试环境
#define WLHttpTestServer  @"http://test.welian.com:8091"
//#define WLHttpServer @"http://test.welian.com:8080"
//正式环境
#define WLHttpServer      @"http://sevnew.welian.com:80"

//本地调试
//#define WLHttpServer  @"http://192.168.1.122:80"

//#define WLHttpServer  @"http://www.welian.com:8080"

#define WLHttpCheck   @"Http_preference"

// DES加解密key
#define KDESkey @"weLian&188"

//支付宝回调地址
//#define kAlipayNotifyURL @"http://test.welian.com:8080/alipay/notify"
#define kAlipayNotifyURL @"http://www.welian.com:8080/alipay/notify"

#pragma mark - 1.8.0版接口
// 发现banner 广告
#define KBannerUrl(path) [NSString stringWithFormat:@"ad/%@",path]

#pragma mark - 微链头条
#define KTouTiaoUrl(path) [NSString stringWithFormat:@"toutiao/%@",path]
// 微链头条 列表
#define KTouTiaoListUrl KTouTiaoUrl(@"list")

// 热门项目
#define KHotProjectPath kProjectUrl(@"hot")
// 项目集
#define KClassifications kProjectUrl(@"classifications")
//取项目集下的项目列表
#define KClassListPath kProjectUrl(@"clist")
//检索项目
#define KProjectSearchPath kProjectUrl(@"search")
//取筛选选项
#define KCommSelectPath kCommonUrl(@"select")

#pragma mark - 投资人模块
//基本路径
#define kInvestorUrl(path) [NSString stringWithFormat:@"investor/%@",path]
//取投资人列表
#define kInvestorListPath kInvestorUrl(@"list")
//获取投资人的项目列表
#define kInvestorProjectsPath kInvestorUrl(@"projects")
//投递项目
#define kInvestorToudiPath kInvestorUrl(@"order")
//投资人取项目详情
#define kInvestorProjectDetailInfoPath kInvestorUrl(@"project")
//项目bp的下载
#define kInvestorDownloadPath kInvestorUrl(@"download")
//索要bp
#define kInvestorRequiredPath kInvestorUrl(@"required")
//查看投资人
#define kInvestorGetPath kInvestorUrl(@"get")
//不同意投递bp
#define kInvestorNoToudiPath kInvestorUrl(@"requiredstatus")
//取投资机构
#define kInvestorJigouPath kInvestorUrl(@"firms")
//取投资机构的投资人
#define kInvestorJigouPersonPath kInvestorUrl(@"friminvestors")
//取投资机构案例
#define kInvestorCasesPath kInvestorUrl(@"cases")
//投资人筛选
#define kInvestorSearchPath kInvestorUrl(@"search")
//项目投递反馈
#define kInvestorFankuiPath kInvestorUrl(@"feedback")




//********************************************************************************//
#pragma mark - 注册，登录
//基本路径
#define kRegisterUrl(path) [NSString stringWithFormat:@"register/%@",path]
//微信注册
#define kWXRegisterPath kRegisterUrl(@"wxregister")
//手机注册
#define kRegisterPath kRegisterUrl(@"register")
//获取验证码
#define kGetcodePath kRegisterUrl(@"getcode")
//验证验证码
#define kCheckcodePath kRegisterUrl(@"checkcode")
//忘记密码
#define kChanagePasswordPath kRegisterUrl(@"chanagepassword")
//登陆
#define kLoginPath kRegisterUrl(@"login")
// 上传平台，clientid
#define kUpdateclient kRegisterUrl(@"updateclient")
//退出登录
#define kLogoutPath kRegisterUrl(@"logout")


#pragma mark - 用户模块
//基本路径
#define kUserUrl(path) [NSString stringWithFormat:@"user/%@",path]
//修改用户信息
#define kSaveUserInfoPath kUserUrl(@"save")
//增加教育经历
#define kSaveSchoolPath kUserUrl(@"saveschool")
//删除教育经历
#define kDeleteSchoolPath kUserUrl(@"deleteschool")
//增加工作经历
#define kSaveCompanyPath kUserUrl(@"savecompany")
//删除工作经历
#define kDeleteCompanyPath kUserUrl(@"deletecompany")
//认证投资人
#define kInvestPath kUserUrl(@"invest")
//取用户认证信息
#define kLoadInvestorPath kUserUrl(@"loadinvestor")
//修改密码
#define kChangePassWDPath kUserUrl(@"chanagepassword")
//取投资人列表
#define kInvestorsListPath kUserUrl(@"investors")
//修改用户头像
#define kChangeAvatarPath kUserUrl(@"avatar")
//修改用户地理位置
#define kChangeLocationPath kUserUrl(@"location")
//查找用户信息
#define kSearchUserPath kUserUrl(@"search")

#pragma mark - 认证手机号码
//取验证码接口
#define kMobileCodePath kUserUrl(@"mobilecode")
//验证手机号码
#define kCheckMobileCodePath kUserUrl(@"checkmobilecode")


#pragma mark - 动态Feed模块
//基本路径
#define kFeedUrl(path) [NSString stringWithFormat:@"feed/%@",path]
//添加动态
#define kSaveFeedPath kFeedUrl(@"save")
//删除动态
#define kDeleteFeedPath kFeedUrl(@"delete")
//评论动态
#define kFeedCommentPath kFeedUrl(@"comment")
//删除动态评论
#define kDeleteFeedCommentPath kFeedUrl(@"deletecomment")
//赞
#define kFeedZanPath kFeedUrl(@"zan")
//取消赞
#define kDeleteFeedZanPath kFeedUrl(@"deletezan")
//转推
#define kFeedForwardPath kFeedUrl(@"forward")
//取消转推
#define kDeleteFeedForwardPath kFeedUrl(@"deleteforward")
//取动态列表
#define kFeedListPath kFeedUrl(@"list")
//取动态评论列表
#define kFeedListCommentPath kFeedUrl(@"listcomment")
//取赞的用户列表
#define kFeedListZanPath kFeedUrl(@"listzan")
//取转推的用户列表
#define kFeedListForwardPath kFeedUrl(@"listforward")
//取动态详情
#define kFeedDetailInfoPath kFeedUrl(@"get")
//举报
#define kFeedReportPath kFeedUrl(@"report")
//取最新动态数量
#define kFeedNewCountPath kFeedUrl(@"new")


#pragma mark - 好友模块 friends
//基本路径
#define kFriendUrl(path) [NSString stringWithFormat:@"friend/%@",path]
//取好友列表
#define kFriendListPath kFriendUrl(@"list")
//上传通讯录，获取系统好友列表
#define kFriendUploadphonebookPath kFriendUrl(@"uploadphonebook")
//取微信好友列表
#define kFriendWXListPath kFriendUrl(@"wxlist")
//二度好友列表
#define kFriendList2Path kFriendUrl(@"list2")
//取共同好友
#define kFriendSamelistPath kFriendUrl(@"samelist")
//请求添加好友
#define kFriendRequestPath kFriendUrl(@"request")
//确认添加好友
#define kFriendConfirmPath kFriendUrl(@"confirm")
//删除好友
#define kDeleteFriendPath kFriendUrl(@"delete")
//邀请微信好友
#define kInviteWXFriendPath kFriendUrl(@"invite")
//上传通讯录，获取好友关系，包括微信好友
#define kFriendPhonebookRelationPath kFriendUrl(@"phonebookrelation")


#pragma mark - 项目 project 模块
//基本路径
#define kProjectUrl(path) [NSString stringWithFormat:@"project/%@",path]
//检测项目是否同名存在
#define kCheckProjectPath kProjectUrl(@"check")
//取我收藏的项目列表
#define kProjectFavoriteListPath kProjectUrl(@"favoritelist")
//取项目列表
#define kProjectListPath kProjectUrl(@"list")
//取项目详情
#define kProjectDetailInfoPath kProjectUrl(@"get")
//添加项目，修改
#define kSaveProjectPath kProjectUrl(@"save")
//添加项目成员
#define kSaveProjectMembersPath kProjectUrl(@"savemembers")
//删除项目成员
#define kDeleteProjectMembersPath kProjectUrl(@"deletemembers")
//取项目成员
#define kProjectMembersPath kProjectUrl(@"members")
//项目 赞
#define kProjectZanPath kProjectUrl(@"zan")
//项目 评论
#define kProjectCommentPath kProjectUrl(@"comment")
//取赞的用户列表
#define kProjectZanListPath kProjectUrl(@"zanlist")
//取评论列表
#define kProjectCommentListPath kProjectUrl(@"commentlist")
//删除项目赞
#define kDeleteProjectZanPath kProjectUrl(@"deletezan")
//删除项目评论
#define kDeleteProjectCommentPath kProjectUrl(@"deletecomment")
//删除项目图片
#define kDeleteProjectPhotoPath kProjectUrl(@"deletephoto")
//添加项目图片
#define kSaveProjectPhotoPath kProjectUrl(@"savephoto")
//项目 收藏
#define kProjectFavoritePath kProjectUrl(@"favorite")
//取消收藏
#define kDeleteProjectFavoritePath kProjectUrl(@"deletefavorite")
//删除项目
#define kDeleteProjectPath kProjectUrl(@"delete")


#pragma mark - 活动 active 模块
//基本路径
#define kActiveUrl(path) [NSString stringWithFormat:@"active/%@",path]
//取活动列表
#define kActiveListPath kActiveUrl(@"list")
//取活动详情
#define kActiveDetailInfoPath kActiveUrl(@"get")
//已报名用户列表
#define kActiveRecordersPath kActiveUrl(@"recorders")
//取票务信息
#define kActiveTicketsPath kActiveUrl(@"tickets")
//收藏活动
#define kActiveFavoritePath kActiveUrl(@"favorite")
//取消收藏
#define kDeleteActiveFavoritePath kActiveUrl(@"deletefavorite")
//取用户相关活动
#define kActiveUserActivesPath kActiveUrl(@"useractives")
//报名，购票
#define kActiveOrderPath kActiveUrl(@"order")
//修改订单状态
#define kActiveOrderStatusPath kActiveUrl(@"orderstatus")
//取消报名
#define kDeleteActiveRecordPath kActiveUrl(@"deleterecorder")
//取已经购买的票
#define kActiveBuyedTicketsPath kActiveUrl(@"buyedtickets")
//取活动城市列表
#define kActiveCitiesPath kActiveUrl(@"cities")


#pragma mark - 系统模块
//基本路径
#define kCommonUrl(path) [NSString stringWithFormat:@"common/%@",path]
//版本更新检测
#define kCheckUpdatePath kCommonUrl(@"update")
//获取城市列表
#define kAllCityListPath kCommonUrl(@"city")
//取行业列表
#define kAllIndustryListPath kCommonUrl(@"industry")
//搜索学校
#define kSearchSchoolPath kCommonUrl(@"school")
//搜索专业
#define kSearchSpecialtyPath kCommonUrl(@"specialty")
//搜索公司
#define kSearchCompanyPath kCommonUrl(@"company")
//搜索职位
#define kSearchPositionPath kCommonUrl(@"position")






#pragma mark - CoreData
//数据库名字
#define kStoreName @"WeLian_HeadLine.sqlite"

#pragma mark - Sqlite Data

#define KWLDataDBName @"wlDataDBName.db"

// 1.8.0
// 广告位数据
#define KBannerDataTableName [NSString stringWithFormat:@"Banner"]
// 投资人
#define KInvestrUserTableName [NSString stringWithFormat:@"InvestrUsers"]
// 投资机构
#define KInvestrJiGouTableName [NSString stringWithFormat:@"InvestrJiGou"]

// 首页数据
#define KHomeDataTableName [NSString stringWithFormat:@"home%@",[LogInUser getCurrentLoginUser].uid]
//首页数据 重新发送
#define KSendAgainDataTableName [NSString stringWithFormat:@"SendAgain%@",[LogInUser getCurrentLoginUser].uid]
// 所有动态数据
#define KWLStutarDataTableName [NSString stringWithFormat:@"stutarData%@",[LogInUser getCurrentLoginUser].uid]
// 所有用户详细信息
#define KWLUserInfoTableName [NSString stringWithFormat:@"UserInfo%@",[LogInUser getCurrentLoginUser].uid]
// 用户共同好友
#define KWLSamefriendsTableName [NSString stringWithFormat:@"Samefriends%@",[LogInUser getCurrentLoginUser].uid]

// 投资领域数据 行业
#define KInvestIndustryTableName @"InvestIndustry"

// 文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userInfo.data"]


//#pragma mark - 支付宝配置信息
//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088611088140964"
//收款支付宝账号
#define SellerID  @"wx@welian.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"9ztmliltn7r93e3wz31dee780eme05rj"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALoophIkcpw8SAgNtPCoK7dC3igETE8m227BiFUi7fUQbJMFG+yfnwH/Q0zR+zuKScLjB81EAqwYBjU+d7S+Lr4h+VqixRtUL56jXyL4oK6sg7JO5RdkVjmih+/k5f4NlFTSpPPlv4gqON7NLqnoXUmR5K5M7qfJva8ppNbpzTCZAgMBAAECgYAwWqSga8U1Xdcb+Gt6Y0RPqtfHry4fFSnEQBLoglUq5aQ+IAKb2O5Vd3eEubo3Qflc3NnG8JZ9GxRpuhsf4JKFMRS4OqnRHhZNwLugpTCrt6XnukDS69bsmH2li6zXkJ9SHJLhQzkqpZ7gSTd7nkxFy39bmsMqzjK1nNqPR/FhnQJBAOI8yt6wS3DhBmk5leMKKvMMNm1lzd6LLr2vV6RiwEVzlrtli/9VLeRiHP5YUYHTIqN/qGQIyT0O7prFNJtx1LMCQQDSphblXFp4C9dbrUCtM3zRKHN40jTsy0L3VvpAv1i1a/gQ041ni10xh3IOuWYS5bR2OEg2bLnR8S4TKho+08ODAkBnXk9zICnYEXjUazNI4URueI4FvhYqMH3SvWLWASjIkt+0D9m/eDPXvdxxefkD0GxrN9DApCMOetwaazB2NbRxAkB+urWjn4A+IMGbwgvbJ9K78t4lnjGBFHhhXc6JDZVM8Hv5g4za8plKpvYTra6fR9reFNY9CARzLepOVVIc4kIJAkEAltBchwK3mueIOOWW2SN3CMk5NnB/2jzaLNZtAJd9P9wu63dyPETYTmH1OiUMbtdy93Fe7kSPi90AMz1yyxYqfg=="

//把支付宝公钥和RSA私钥配置到代码里面，RSA私钥如果不是php语言签名的，都要用pkcs8转码后再配置到代码里面，php语言签名的直接用rsa_private的pem文件 RSA公钥上传地址：登录b.alipay.com，点我的商家服务，点查询PID和KEY->合作伙伴密钥管理，RSA密钥->查看密钥或者添加密钥
//支付宝商户生成的公钥
#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"


#endif
