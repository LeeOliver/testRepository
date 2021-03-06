//
//  NetWorkEngine.h
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkEngine : NSObject
{
    NSString *_personID;
    NSString *_password;
    NSString *_nikename;
    NSString *_userID;
    BOOL      _isPayment;
    BOOL      _isFlag;
}
@property (nonatomic, strong) NSString *personID;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *nikename;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic)         BOOL      isPayment;//付款标志，付款yes，收款no
@property (nonatomic)         BOOL      isFlag;//登陆标志，登陆yes，未登录no

+ (NetWorkEngine *)shareInstance;
- (id)init;

/**
 同步 check账号
 @param  error 回傳用的錯誤字串
 @return 1 成功，其他失敗
 */
- (int)chkIDExistIfError:(NSString**)error;

/**
 同步 Register账号
 @param  view_name 名字
 @param  error 回傳用的錯誤字串
 @return 1 成功，其他失敗
 */
- (int)registerWithName:(NSString *)view_name error:(NSString**)error;

/**
 非同步 取得CategoryList
 */
- (void)asyncGetCategoryListOfComplete:(void (^)(NSDictionary *)) compBlock;

/**
 非同步 email查询
 @param email      email
 */
- (void)userListSearchByEmail:(NSString *) email
                     delegate:(id) aDelegate
                          sel:(SEL) aSel;
/**
 非同步 分类查询
 @param schCategories      分类id
 */
- (void)userListSearchByCategories:(NSString *)schCategories
                          delegate:(id) aDelegate
                               sel:(SEL) aSel;

#pragma Mark-
#pragma 预约接口
/**
 *	@brief	建立临时会话记录 
 *  1
 *	@param 	requesterId 	申请人id，自己
 *	@param 	responserId 	被申请人id，选中的id
 *	@param 	rate 	费率
 *	@param 	serviceTime 	服务时间
 *	@param 	sum 	请求者资金
 */
- (void)creatTempMeetingRequestByRequesterId:(NSString *)requesterId
                              andResponserId:(NSString*)responserId
                                     andRate:(NSString*)rate
                              andServicetime:(NSString*)serviceTime
                                      andSum:(NSString*)sum
                                    delegate:(id) aDelegate
                                         sel:(SEL) aSel;

/**
 *	@brief	获取自己剩余金额（sum）
 *
 *	@param 	userId 	自己的id
 */
- (void)getBalanceByUserID:(NSString *)userId
                  delegate:(id) aDelegate
                       sel:(SEL) aSel;


/**
 *	@brief	收款人接收消息列表
 *  2
 *	@param 	responserId 	自己id
 */
- (void)getRequestInfoByResponserId:(NSString *)responserId
                           delegate:(id) aDelegate
                                sel:(SEL) aSel;

/**
 *	@brief	收款人接受请求
 *  3
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 *	@param 	serviceTime 	时间
 */
- (void)sendreceiveRequestByResponserId:(NSString *)responserId
                         andRequesterId:(NSString *)requesterId
                         andServiceTime:(NSString *)serviceTime
                               delegate:(id) aDelegate
                                    sel:(SEL) aSel;

/**
 *	@brief	付款方获取回应
 *  4
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 *	@param 	rate 	费率
 */
- (void)getTempMeetingReplyByResponserId:(NSString *)responserId
                          andRequesterId:(NSString *)requesterId
                                 andRate:(NSString *)rate
                                delegate:(id) aDelegate
                                     sel:(SEL) aSel;

/**
 *	@brief	开始计时
 *  5
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 *	@param 	meetingStar 	时间
 */
- (void)meetingStartByResponserId:(NSString *)responserId
                   andRequesterId:(NSString *)requesterId
                  andMeetingStart:(NSString *)meetingStar
                         delegate:(id) aDelegate
                              sel:(SEL) aSel;

/**
 *	@brief	每1秒请求一次
 *  6
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 *	@param 	countFunt 	总金额
 *	@param 	totalTime 	总时间
 *	@param 	requesterFund 	请求金额
 *	@param 	requesterRate 	请求费率
 */
- (void)meetingByResponserId:(NSString *)responserId
              andRequesterId:(NSString *)requesterId
                andCountFund:(NSString *)countFunt
                andTotalTime:(NSString *)totalTime
                    delegate:(id) aDelegate
                         sel:(SEL) aSel;

/**
 *	@brief	收款 60秒不变动就停止
 *  7
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 *	@param 	fund 	金额
 *	@param 	showTime 	时间
 */
- (void)getReicpientByResponserId:(NSString *)responserId
                   andRequesterId:(NSString *)requesterId
                          andFund:(NSString *)fund
                      andShowTime:(NSString *)showTime
                         delegate:(id) aDelegate
                              sel:(SEL) aSel;

/**
 *	@brief	付款 结束
 *  8
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 *	@param 	meetingStar 	开始标志
 */
- (void)meetingEndByResponserId:(NSString *)responserId
                 andRequesterId:(NSString *)requesterId
                andMeetingStart:(NSString *)meetingStar
                       delegate:(id) aDelegate
                            sel:(SEL) aSel;

/**
 *	@brief	停止请求 请求后拒绝
 *  9
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 */
- (void)stopRequestByResponserId:(NSString *)responserId
                  andRequesterId:(NSString *)requesterId
                        delegate:(id) aDelegate
                             sel:(SEL) aSel;

/**
 *	@brief	收款掉线后上线判断是否还有计费，在4前调
 *  10
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 */
- (void)checkMeetingByResponserId:(NSString *)responserId
                   andRequesterId:(NSString *)requesterId
                         delegate:(id) aDelegate
                              sel:(SEL) aSel;


/**
 *	@brief	添加登陆时间
 *
 *	@param 	sUserId 	自己的id
 */
- (void)addLastLoginTimeByUserId:(NSString *)sUserId;
/**
 *	@brief	退出程序
 *
 *	@param 	sUserId 	自己的id
 */
- (void)phoneOutByUserId:(NSString *)sUserId;

/**
 *	@brief	更新个人资料
 *
 *	@param 	sUserId 	自己id
 *	@param 	sName 	自己昵称
 *	@param 	sAddress 	地址
 *	@param 	sPhone 	电话
 */
- (void)updateUserInfoByUserId:(NSString *)sUserId
                   andNikeName:(NSString *)sName
                    andAddress:(NSString *)sAddress
                      andPhone:(NSString *)sPhone
                      delegate:(id) aDelegate
                           sel:(SEL) aSel;

/**
 *	@brief	获取某人的余额
 *
 *	@param 	sUserId 	查询用户id
 */
- (void)getUserFundByUserId:(NSString *)sUserId
                   delegate:(id) aDelegate
                        sel:(SEL) aSel;
/**
 *	@brief	获取某人的信息
 *
 *	@param 	sUserId 	查询用户id
 */
- (void)getUserInfoByUserId:(NSString *)sUserId
                   delegate:(id) aDelegate
                        sel:(SEL) aSel;

/**
 *	@brief	收款人管理-获取自己的服务
 *
 *	@param 	sUserId 	自己id
 */
- (void)getMyServiceListByUserId:(NSString *)sUserId
                        delegate:(id) aDelegate
                             sel:(SEL) aSel;

/**
 *	@brief	收款人管理-删除自己的服务
 *
 *	@param 	sComId 	服务id
 */
- (void)deleteMyServiceByComId:(NSString *)sComId
                      delegate:(id) aDelegate
                           sel:(SEL) aSel;

/**
 *	@brief	收款人管理-添加 修改自己服务
 *
 *	@param 	sUserId 	自己id，uid
 *	@param 	sComId 	更新填写，服务id，不填写添加服务
 *	@param 	sViewName 	服务类型1-32
 *	@param 	sName 	商品名字
 *	@param 	sCate 	费率
 */
- (void)addOrUpdateMyServiceByUserId:(NSString*)sUserId
                            andComId:(NSString*)sComId
                         andViewName:(NSString*)sViewName
                             andName:(NSString*)sName
                             andCate:(NSString*)sCate
                            delegate:(id) aDelegate
                                 sel:(SEL) aSel;

/**
 *	@brief	获取多人预约信息
 *
 *	@param 	sUserId 	自己id，获取收款人列表
 *	@param 	aUserI 	自己id，获取付款人列表
 */
- (void)getRequestByRequestId:(NSString*)sUserId
                 orResponseId:(NSString*)aUserI
                    ddelegate:(id) aDelegate
                          sel:(SEL) aSel;
@end
