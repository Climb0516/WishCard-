//
//  H5BGMViewController.m
//  WishCard
//
//  Created by 张鹤楠 on 15/11/6.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "H5BGMViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface H5BGMViewController ()
{
    UITableView *musicTableView;
}
@end

@implementation H5BGMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str =  @"http://192.168.3.3:90/Uploads/syspic/mp3/yq0KA1R9XYCAVcSWAA8tADeZN1g520.mp3";
    AVPlayer *newPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:str]];}

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
