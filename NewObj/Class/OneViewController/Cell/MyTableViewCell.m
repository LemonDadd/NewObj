//
//  MyTableViewCell.m
//  NewObj
//
//  Created by 关云秀 on 2018/11/13.
//  Copyright © 2018 xuannalisha. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    self.bg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.bg.layer.masksToBounds = YES;
    self.bg.layer.cornerRadius =5.f;
    self.bg.layer.borderColor = kColorWithHex(0x99897a).CGColor;
    self.bg.layer.borderWidth = 1.f;
    
    
    self.title.font = [UIFont fontWithName:MFONT size:22];
    self.date.font = [UIFont fontWithName:MFONT size:20];
    self.lunar.font = [UIFont fontWithName:MFONT size:20];
    self.detail.font = [UIFont fontWithName:MFONT size:18];
    self.pic.contentMode = UIViewContentModeScaleAspectFill;
    self.pic.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
