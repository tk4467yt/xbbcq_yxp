//
//  HeroSkillItemTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/8.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroSkillItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivSkillThumb;
@property (weak, nonatomic) IBOutlet UIImageView *ivSkillThumbMask;
@property (weak, nonatomic) IBOutlet UILabel *lblSkillName;
@property (weak, nonatomic) IBOutlet UILabel *lblSkillDesc;

@end
