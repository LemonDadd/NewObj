//
//  MainViewController.m
//  NewObj
//
//  Created by 关云秀 on 2018/7/26.
//  Copyright © 2018年 xuannalisha. All rights reserved.
//

#import "MainViewController.h"
#import "OneViewController.h"
#import <SafariServices/SafariServices.h>

@interface MainViewController ()<SFSafariViewControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    kWeakSelf(self);
    AVQuery *query = [AVQuery queryWithClassName:@"config"];
    [query getObjectInBackgroundWithId:@"5be84706ee920a006680bfd6" block:^(AVObject * _Nullable object, NSError * _Nullable error) {
        BOOL swich = [object[@"swich"] boolValue];
        if (swich) {
            [weakself gotoWebView:object[@"url"]];
        }else {
            OneViewController *vc =[[OneViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            nav.navigationBarHidden = YES;
            [UIApplication sharedApplication].delegate.window.rootViewController = nav;
        }
    }];
    
    
    
}


- (void)gotoWebView:(NSString *)url {
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [UIApplication sharedApplication].delegate.window.rootViewController = safariVC;
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
