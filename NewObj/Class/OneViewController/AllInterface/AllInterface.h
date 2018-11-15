//
//  AllInterface.h
//  NewObj
//
//  Created by 关云秀 on 2018/11/13.
//  Copyright © 2018 xuannalisha. All rights reserved.
//

#import "JsonDeal.h"
#import "OneModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllInterface : JsonDeal

+ (void)requestGetSlideshowListBymonth:(NSInteger)month
                                   day:(NSInteger)day
                               request:(void(^)(NSArray *message,
                                                BOOL success,
                                                NSString *errorMsg))request;


+ (void)requestGetSlideshowListById:(NSString *)Id
                            request:(void(^)(NSDictionary *message,
                                             BOOL success,
                                             NSString *errorMsg))request;

@end

NS_ASSUME_NONNULL_END
