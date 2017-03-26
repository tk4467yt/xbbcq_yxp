//
//  HeroDetailViewController.h
//  xbb
//
//  Created by  qin on 2017/3/5.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyRootViewController.h"
#import "HeroInfo.h"
#import "SpeciesSetViewController.h"
#import "MyDelegateSet.h"

@interface HeroDetailViewController : MyRootViewController <UITableViewDelegate,UITableViewDataSource,SpeciesSetDidSelectHeroDelegate,equipComposeVCActionDelegate>
@property (nonatomic,strong) HeroInfo *hero2show;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

@end
