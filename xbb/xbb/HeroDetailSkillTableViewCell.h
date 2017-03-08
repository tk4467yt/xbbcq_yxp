//
//  HeroDetailSkillTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/7.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailSkillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITableView *tbSkills;
@property (nonatomic,strong) NSArray *heroSkillsArr;
@end
