//
//  AllInterface.m
//  NewObj
//
//  Created by 关云秀 on 2018/11/13.
//  Copyright © 2018 xuannalisha. All rights reserved.
//

#import "AllInterface.h"


#define ErrorMessage @"数据请求失败,请检查您的网络"

@implementation AllInterface


+ (void)requestGetSlideshowListBymonth:(NSInteger)month
                                   day:(NSInteger)day
                               request:(void(^)(NSArray *message,
                                                  BOOL success,
                                                  NSString *errorMsg))request {
    
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:@(month) forKey:@"month"];
    [paramDic setObject:@(day) forKey:@"day"];
    [paramDic setObject:@"f7288b1a2d5161c2d24a4557e449e67e" forKey:@"key"];
    [paramDic setObject:@"1.0" forKey:@"v"];
    
    [HttpHelper httpDataRequestByGetMethod:@"http://api.juheapi.com/japi/toh" paramDictionary:paramDic TimeOutSeconds:120 request:^(BOOL finish, NSString *data) {
        if (finish) {
            if (data == nil) {
                request(nil, false, ErrorMessage);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"error_code"] integerValue];
                if (Code == 0) {
                    NSMutableArray *result = [NSMutableArray new];
                    NSArray *datas = dic[@"result"];
                    for (NSDictionary *theDic in datas) {
                        @autoreleasepool {
                            OneModel *model = [OneModel mj_objectWithKeyValues:theDic];
                            [result addObject:model];
                        }
                    }
                    request(result, true, nil);
                } else {
                    request(nil, false, dic[@"reason"]);
                }
            }
        } else {
            request(nil, false, data);
        }
    }];
}


+ (void)requestGetSlideshowListById:(NSString *)Id
                               request:(void(^)(NSDictionary *message,
                                                BOOL success,
                                                NSString *errorMsg))request {
    
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:Id forKey:@"id"];
    [paramDic setObject:@"f7288b1a2d5161c2d24a4557e449e67e" forKey:@"key"];
    [paramDic setObject:@"1.0" forKey:@"v"];
    
    [HttpHelper httpDataRequestByGetMethod:@"http://api.juheapi.com/japi/tohdet" paramDictionary:paramDic TimeOutSeconds:120 request:^(BOOL finish, NSString *data) {
        if (finish) {
            if (data == nil) {
                request(nil, false, ErrorMessage);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"error_code"] integerValue];
                if (Code == 0) {
                    NSArray *datas = dic[@"result"];
                    NSDictionary *dict = datas[0];
                    request(dict, true, nil);
                } else {
                    request(nil, false, dic[@"reason"]);
                }
            }
        } else {
            request(nil, false, data);
        }
    }];
}

@end
