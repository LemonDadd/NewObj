//
//  OneViewController.m
//  NewObj
//
//  Created by 关云秀 on 2018/11/13.
//  Copyright © 2018 xuannalisha. All rights reserved.
//

#import "OneViewController.h"
#import "MyTableViewCell.h"
#import "AllInterface.h"
#import "DetailViewController.h"
#import <SafariServices/SafariServices.h>
#import "JhlvShowAlertController.h"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tab;
@property (nonatomic, weak)IBOutlet UILabel *titleLabel;
@property (nonatomic, weak)IBOutlet UILabel *qian;
@property (nonatomic, weak)IBOutlet UILabel *hou;

@property (nonatomic, weak)IBOutlet UIButton *left;
@property (nonatomic, weak)IBOutlet UIButton *right;

@property (nonatomic, strong)NSMutableArray *allResource;

@property (nonatomic, assign)NSInteger indx;
@property (nonatomic, assign)NSInteger m;
@property (nonatomic, assign)NSInteger d;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indx = 0;
    
    // Do any additional setup after loading the view from its nib.
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.backgroundColor = [UIColor clearColor];
    [self.tab registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    kWeakSelf(self);
    self.tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reStartRequest];
    }];
    
    self.titleLabel.font = [UIFont fontWithName:MFONT size:28];
    self.qian.font = [UIFont fontWithName:MFONT size:22];
    self.hou.font = [UIFont fontWithName:MFONT size:22];
    
    self.left.layer.masksToBounds = YES;
    self.left.layer.cornerRadius =5.f;
    self.left.layer.borderColor = kColorWithHex(0x99897a).CGColor;
    self.left.layer.borderWidth = 1.f;
    
    self.right.layer.masksToBounds = YES;
    self.right.layer.cornerRadius =5.f;
    self.right.layer.borderColor = kColorWithHex(0x99897a).CGColor;
    self.right.layer.borderWidth = 1.f;
    
    [self setmd:[NSDate date]];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allResource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
    
    if (self.allResource.count>indexPath.row) {
        OneModel *model = self.allResource[indexPath.row];
        cell.title.text = model.title;
        cell.date.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)model.year,(long)model.month,(long)model.day];
        cell.lunar.text = model.lunar;
        cell.detail.text = model.des;
        cell.pic.hidden = !model.pic.length;
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[self createImageWithColor:kColorWithHex(0x99897a)]];
    }
    
    return cell;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.allResource.count>indexPath.row) {
        OneModel *model = self.allResource[indexPath.row];
        DetailViewController *vc = [DetailViewController new];
        vc.uid = model._id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)reStartRequest {
    [self.allResource removeAllObjects];
    NSLog(@"%ld----%ld",(long)_m,(long)_d);
    [AllInterface requestGetSlideshowListBymonth:_m day:_d request:^(NSArray * _Nonnull message, BOOL success, NSString * _Nonnull errorMsg) {
        [self.tab.mj_header endRefreshing];
        if (success) {
            [self.allResource addObjectsFromArray:message];
            [self.tab reloadData];
        }
    }];
}

-(IBAction)left:(UIButton *)sender {
    _indx -=1;
    [self setmd:[NSDate jk_dateAfterDate:[NSDate date] day:_indx]];
}
-(IBAction)right:(UIButton *)sender {
    _indx +=1;
    [self setmd:[NSDate jk_dateAfterDate:[NSDate date] day:_indx]];
}

-(IBAction)tody:(UIButton *)sender {
  
    NSInteger tm =[NSDate jk_month:[NSDate date]];
    NSInteger td =[NSDate jk_day:[NSDate date]];
    if (_m == tm && _d == td) {
        [CustomView alertMessage:@"已经回到当天" view:self.view];
        return;
    }
    _indx = 0;
    [self setmd:[NSDate date]];
}

-(IBAction)home:(UIButton *)sender {
    [[JhlvShowAlertController shareInstance]showAlert:@"是否查看更多历史上的今天" message:@"" cancelTitle:@"取消" titleArray:@[@"立刻前往~"] viewController:self confirm:^(NSInteger buttonTag) {
        if (buttonTag == 0) {
            SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.todayonhistory.com"]];
            [self presentViewController:safariVC animated:YES completion:nil];
        }
    }];
    
    
   
}

-(NSMutableArray *)allResource {
    if (_allResource == nil) {
        _allResource = [NSMutableArray array];
    }
    return _allResource;
}

- (void)setmd:(NSDate *)date {
    _m =[NSDate jk_month:date];
    _d =[NSDate jk_day:date];
    [_tab.mj_header beginRefreshing];
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
