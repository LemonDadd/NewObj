//
//  OneModel.h
//  NewObj
//
//  Created by 关云秀 on 2018/11/13.
//  Copyright © 2018 xuannalisha. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneModel : BaseModel

@property (nonatomic, assign)NSInteger day;
@property (nonatomic, copy)NSString *des;
@property (nonatomic, copy)NSString *_id;
@property (nonatomic, copy)NSString *lunar;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)NSInteger year;

@end

NS_ASSUME_NONNULL_END
