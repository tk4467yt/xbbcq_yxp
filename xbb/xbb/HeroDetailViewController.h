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

@interface HeroDetailViewController : MyRootViewController <UITableViewDelegate,UITableViewDataSource,SpeciesSetDidSelectHeroDelegate>
@property (nonatomic,strong) HeroInfo *hero2show;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

@end
