//
//  DetailViewController.m
//  NewObj
//
//  Created by 关云秀 on 2018/11/14.
//  Copyright © 2018 xuannalisha. All rights reserved.
//

#import "DetailViewController.h"
#import "AllInterface.h"

@interface DetailViewController ()

@property (nonatomic, weak)IBOutlet UILabel *titleLabel;
@property (nonatomic, weak)IBOutlet UILabel *contentLabel;
@property (nonatomic, weak)IBOutlet UILabel *name;
@property (nonatomic, weak)IBOutlet UILabel *date;
@property (nonatomic, weak)IBOutlet UIImageView *pic;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.font = [UIFont fontWithName:MFONT size:28];
    self.contentLabel.font = [UIFont fontWithName:MFONT size:22];
    self.name.font = [UIFont fontWithName:MFONT size:30];
    self.date.font = [UIFont fontWithName:MFONT size:22];
    self.pic.contentMode = UIViewContentModeScaleAspectFit;
    [self request];
}


-(IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)request {
    [[CustomView getInstancetype]showWaitView:@"请稍后" byView:self.view];
    [AllInterface requestGetSlideshowListById:self.uid request:^(NSDictionary * _Nonnull message, BOOL success, NSString * _Nonnull errorMsg) {
        [[CustomView getInstancetype]closeHUD];
        if (success) {
            [self.pic sd_setImageWithURL:message[@"pic"] placeholderImage:[self createImageWithColor:kColorWithHex(0x99897a)]];
            self.contentLabel.text = message[@"content"];
            self.name.text =message[@"title"];
            self.date.text =message[@"lunar"];
        }
    }];
}

- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
