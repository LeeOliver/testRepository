//
//  NetWorkEngine.m
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NetWorkEngine.h"

@implementation NetWorkEngine

@synthesize personID = _personID,password = _password,nikename = _nikename,userID = _userID;
@synthesize isPayment = _isPayment;
@synthesize isFlag = _isFlag;
static NetWorkEngine * sharedNetWorkEngine = NULL;

+(NetWorkEngine *)shareInstance{
    @synchronized(self){
        if(sharedNetWorkEngine == NULL){
            sharedNetWorkEngine = [[NetWorkEngine alloc] init];
        }
        
        return sharedNetWorkEngine;
    }
}

- (id) init{
    if (self = [super init])
    {
    }
    return self;
}

/**
 同步 CheckID账号
 @param  error 回傳用的錯誤字串
 @return 1 成功，其他失敗
 */
- (int)chkIDExistIfError:(NSString**)error
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:self.personID key:PERSONID optional:NO];
    [getParams assemblyValue:self.password key:PASSWORD optional:NO];

    ////在判斷電話是否為會員
    NSDictionary *retDic = [[SJNetworkService shareInstance] syncRequestWithMethodName:@"CheckID"
                                                                          andGetParams:getParams
                                                                         andPostParams:nil];
    if(retDic && [[retDic objectForKey:FLAG] isEqual:@"1"])
    {
        *error = [retDic objectForKey:MSG];
        if ([[retDic objectForKey:MSG]isEqualToString:@"OK"])
        {
            _userID = [[retDic objectForKey:RETURNDATA]objectForKey:@"user_id"];
            _nikename = [[retDic objectForKey:RETURNDATA]objectForKey:@"nickName"];
            return 1;
        }
        else 
        {
            return 0;
        }
    }
    else 
    {
        *error = [retDic objectForKey:MSG];
        return 0;
    }
    *error = @"網路連線異常,請稍後再試";
    return 0;
}
/**
 同步 Register账号
 @param  view_name 名字
 @param  error 回傳用的錯誤字串
 @return 1 成功，其他失敗
 */
- (int)registerWithName:(NSString *)view_name error:(NSString**)error
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:view_name  key:NIKENAME optional:NO];
    [getParams assemblyValue:self.password key:PASSWORD optional:NO];
    [getParams assemblyValue:self.personID key:PERSONID optional:NO];
    //以電話判斷是否為會員
    NSDictionary *retDic = [[SJNetworkService shareInstance] syncRequestWithMethodName:@"Register"
                                                                          andGetParams:nil
                                                                         andPostParams:getParams];
    if(retDic && [[retDic objectForKey:FLAG] isEqual:@"1"])
    {
        *error = [retDic objectForKey:MSG];
        if ([[retDic objectForKey:MSG]isEqualToString:@"OK"])
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        *error = [retDic objectForKey:MSG];
        return 0;
    }
    *error = @"網路連線異常,請稍後再試";
    return 0;
}

/**
 非同步 取得CategoryList
 */
- (void)asyncGetCategoryListOfComplete:(void (^)(NSDictionary *)) compBlock
{
    //成功回調
    void (^CategoryList)(ASIHTTPRequest * request);
    CategoryList = ^(ASIHTTPRequest * request)
    {
        DLog(@"receive asyncGetCategoryListOfComplete return");
        NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (compBlock != NULL){
            compBlock(returnData);
        }
    };
    //失敗回調
    void (^CategoryListFail)(ASIHTTPRequest * request);
    CategoryListFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive asyncGetCategoryListOfComplete return");
        if (compBlock != NULL){
            compBlock(NULL);
        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"CategoryList"
                                                   andGetParams:nil
                                                  andPostParams:nil
                                                   andSuccBlock:CategoryList
                                                   andFailBlock:CategoryListFail];
}

/**
 非同步 email查询
 @param email      email
 */
- (void)userListSearchByEmail:(NSString *) email
                     delegate:(id) aDelegate
                          sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:email key:PERSONID optional:NO];
    [getParams assemblyValue:_userID key:USERID optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive userListSearchByEmail return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSMutableArray *usersList = [[NSMutableArray alloc]init];
            usersList = [returnData objectForKey:@"data"];
//            [[returnData objectForKey:@"Data"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                TmpNamecard *aNamecard = [TmpNamecard tempEntity];
//                [[ContactsManager shareInstance] saveServerNcInfo:obj
//                                                       toNamecard:aNamecard];
//                [usersList addObject:aNamecard];
//            }];
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
            
        }
        else {
                if (aDelegate &&
                    [aDelegate respondsToSelector:aSel])
                {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                    [aDelegate performSelector:aSel
                                    withObject:nil];
#pragma clang diagnostic pop

                }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive userListSearchByEmail return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"SearchFromEmail"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}
/**
 非同步 分类查询
 @param schCategories      分类id
 */
- (void)userListSearchByCategories:(NSString *) schCategories
                          delegate:(id) aDelegate
                               sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:schCategories key:@"schCategories" optional:NO];
    [getParams assemblyValue:_userID key:USERID optional:NO];

    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive userListSearchByCategories return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSMutableArray *usersList = [[NSMutableArray alloc]init];
            usersList = [returnData objectForKey:@"data"];
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive userListSearchByCategories return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"SearchExperts"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}
/**
 *	@brief	建立临时会话记录
 *
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
                                         sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:rate key:@"rate" optional:NO];
    [getParams assemblyValue:serviceTime key:@"service_time" optional:NO];
    [getParams assemblyValue:sum key:@"sum" optional:NO];

    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive creatTempMeetingRequestByRequesterId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];
            usersList = [returnData objectForKey:@"data"];
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive creatTempMeetingRequestByRequesterId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"CreatTempMeetingRequest"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];
    
}

/**
 *	@brief	获取自己剩余金额（sum）
 *
 *	@param 	userId 	自己的id
 */
- (void)getBalanceByUserID:(NSString *)userId
                  delegate:(id) aDelegate
                       sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:userId key:USERID optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive getBalanceByUserID return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"success" ])
        {
            NSMutableString *usersList = [[NSMutableString alloc]init];
            usersList = [returnData objectForKey:@"fund"];
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive getBalanceByUserID return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"get_balance"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

/**
 *	@brief	收款人接收消息列表
 *
 *	@param 	responserId 	自己id
 */
- (void)getRequestInfoByResponserId:(NSString *)responserId
                           delegate:(id) aDelegate
                                sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive getRequestInfoByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];
            usersList = [returnData objectForKey:@"data"];
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive getRequestInfoByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"GetRequestInfo"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];
}

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
                                    sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    [getParams assemblyValue:serviceTime key:@"service_time" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive sendreceiveRequestByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];
            usersList = [returnData objectForKey:@"data"];
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive sendreceiveRequestByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"SendReceiveRequest"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

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
                                     sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    [getParams assemblyValue:rate key:@"rate" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive getTempMeetingReplyByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData)
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];

            if ([[returnData objectForKey:@"fund_flag"] isKindOfClass:[NSNull class]]) {
                usersList = @{@"flag": @"E"};
            }else if ([[returnData objectForKey:@"fund_flag"] isEqualToString:@"Y"]) {
                usersList = @{@"flag": @"Y"};
            }else {
                usersList = @{@"flag": @"N"};

            }
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive getTempMeetingReplyByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"GetTempMeetingReply"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

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
                              sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    [getParams assemblyValue:meetingStar key:@"meeting_start" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive meetingStartByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];
            usersList = @{@"flag": @"Y"};
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive meetingStartByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"MeetingStart"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

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
                         sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    [getParams assemblyValue:countFunt key:@"count_fund" optional:NO];
    [getParams assemblyValue:totalTime key:@"total_time" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive meetingByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[returnData objectForKey:@"flag"])
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];
            usersList = @{@"flag":@"Y"};
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive meetingByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"Meeting"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

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
                              sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    [getParams assemblyValue:fund key:@"fund" optional:NO];
    [getParams assemblyValue:showTime key:@"show_time" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive getReicpientByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData)
        {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:returnData];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive getReicpientByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"GetReivpient"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

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
                            sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    [getParams assemblyValue:meetingStar key:@"meeting_start" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive meetingEndByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];
            usersList = @{@"flag":@"Y"};
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive meetingEndByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"MeetingEnd"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

/**
 *	@brief	停止请求 请求后拒绝
 *  9
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 */
- (void)stopRequestByResponserId:(NSString *)responserId
                  andRequesterId:(NSString *)requesterId
                        delegate:(id) aDelegate
                             sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive stopRequestByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"1" ])
        {
            NSDictionary *usersList = [[NSDictionary alloc]init];
            usersList = @{@"SUCCESS": @"SUCCESS"};
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:usersList];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive stopRequestByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"StopRequest"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}

/**
 *	@brief	收款掉线后上线判断是否还有计费，在4前调
 *  10
 *	@param 	responserId 	自己id
 *	@param 	requesterId 	对方id
 */
- (void)checkMeetingByResponserId:(NSString *)responserId
                   andRequesterId:(NSString *)requesterId
                         delegate:(id) aDelegate
                              sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:responserId key:@"responser_id" optional:NO];
    [getParams assemblyValue:requesterId key:@"requester_id" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive checkMeetingByResponserId return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"fund_flag"] isEqualToString:@"Y" ])
        {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:returnData];
#pragma clang diagnostic pop

            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop

            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive checkMeetingByResponserId return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop

        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"CheckMeeting"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}
/**
 *	@brief	添加登陆时间
 *
 *	@param 	sUserId 	自己的id
 */

- (void)addLastLoginTimeByUserId:(NSString *)sUserId
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:sUserId key:@"userid" optional:NO];
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive addLastLoginTime return");
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive addLastLoginTime return");
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"AddLastLoginTime"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];


}
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
                           sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:sUserId key:@"userid" optional:NO];
    [getParams assemblyValue:sName key:@"nikeName" optional:YES];
    [getParams assemblyValue:sAddress key:@"address" optional:YES];
    [getParams assemblyValue:sPhone key:@"phone" optional:YES];

    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive UpdateUserInfo return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"SUCCESS" ])
        {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                [aDelegate performSelector:aSel
                                withObject:returnData];
#pragma clang diagnostic pop
                
            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop
                
            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive UpdateUserInfo return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop
            
        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"UpdateUserInfo"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];

}
/**
 *	@brief	获取某人的余额
 *
 *	@param 	sUserId 	查询用户id
 */
- (void)getUserFundByUserId:(NSString *)sUserId
                   delegate:(id) aDelegate
                        sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:sUserId key:@"userid" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive GetUserFund return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"T" ])
        {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                [aDelegate performSelector:aSel
                                withObject:returnData];
#pragma clang diagnostic pop
                
            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop
                
            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive GetUserFund return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop
            
        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"GetUserFund"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];
}
/**
 *	@brief	获取某人的信息
 *
 *	@param 	sUserId 	查询用户id
 */
- (void)getUserInfoByUserId:(NSString *)sUserId
                   delegate:(id) aDelegate
                        sel:(SEL) aSel
{
    NSMutableDictionary *getParams = [[NSMutableDictionary alloc]init];
    [getParams assemblyValue:sUserId key:@"userid" optional:NO];
    
    //成功回調
    void (^reciveInviteUser)(ASIHTTPRequest * request);
    reciveInviteUser = ^(ASIHTTPRequest * request) {
        DLog(@"receive GetUserInfo return");
        __block NSDictionary *returnData = [[request responseData] objectFromJSONData];
        if (returnData&&[[returnData objectForKey:@"flag"] isEqualToString:@"T" ])
        {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                [aDelegate performSelector:aSel
                                withObject:returnData];
#pragma clang diagnostic pop
                
            }
        }
        else {
            if (aDelegate &&
                [aDelegate respondsToSelector:aSel])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                [aDelegate performSelector:aSel
                                withObject:nil];
#pragma clang diagnostic pop
                
            }
        }
    };
    //失敗回調
    void (^reciveInviteUserFail)(ASIHTTPRequest * request);
    reciveInviteUserFail = ^(ASIHTTPRequest * request) {
        DLog(@"receive GetUserInfo return");
        if (aDelegate &&
            [aDelegate respondsToSelector:aSel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            [aDelegate performSelector:aSel
                            withObject:nil];
#pragma clang diagnostic pop
            
        }
    };
    [[SJNetworkService shareInstance] asynRequestWithMethodName:@"GetUserInfo"
                                                   andGetParams:getParams
                                                  andPostParams:nil
                                                   andSuccBlock:reciveInviteUser
                                                   andFailBlock:reciveInviteUserFail];
}

@end
