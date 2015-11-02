//
//  MytabbarController.m
//  WishCard
//
//  Created by WangPandeng on 15/10/29.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "MytabbarController.h"
#import "BirthDayController.h"
#import "LoveController.h"
#import "ClipImageViewController.h"
#import "testClipViewController.h"

@interface MytabbarController ()

@end

@implementation MytabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BirthDayController *fretureVC = [[BirthDayController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:fretureVC];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"生日" image:[UIImage imageNamed:@"GB_FEATURE"] selectedImage:nil];
    
    LoveController *birthVC = [[LoveController alloc] init];
//    ClipImageViewController *cvc = [[ClipImageViewController alloc] init];
    testClipViewController *cvc = [[testClipViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:cvc];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"爱情" image:[UIImage imageNamed:@"GB_BIRTHDAY"] selectedImage:nil];
    
    
    self.viewControllers = @[nav1,nav2];
    self.selectedIndex = 0;

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
