//
//  HeroArtViewController.h
//  xbb
//
//  Created by  qin on 2017/3/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyRootViewController.h"

@interface HeroArtViewController : MyRootViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbArt;
@property (copy) NSString *heroId;
@end
