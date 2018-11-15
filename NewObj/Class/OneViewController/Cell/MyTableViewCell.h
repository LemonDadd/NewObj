//
//  MyTableViewCell.h
//  NewObj
//
//  Created by 关云秀 on 2018/11/13.
//  Copyright © 2018 xuannalisha. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *bg;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *date;
@property (nonatomic, strong) IBOutlet UILabel *lunar;
@property (nonatomic, strong) IBOutlet UILabel *detail;
@property (nonatomic, strong) IBOutlet UIImageView *pic;

@end

NS_ASSUME_NONNULL_END
