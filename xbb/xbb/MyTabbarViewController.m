//
//  MyTabbarViewController.m
//  xbb
//
//  Created by  qin on 2017/3/1.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyTabbarViewController.h"

@interface MyTabbarViewController ()

@end

@implementation MyTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (UITabBarItem *aItem in self.tabBar.items) {
        if (1 == aItem.tag) {
            aItem.title=NSLocalizedString(@"title_hero", @"");
        } else if (2 == aItem.tag) {
            aItem.title=NSLocalizedString(@"title_equip", @"");
        } else if (3 == aItem.tag) {
            aItem.title=NSLocalizedString(@"title_mine", @"");
        }
    }
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
