//
//  HeroDetailTopTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/6.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailTopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivThumb;
@property (weak, nonatomic) IBOutlet UIImageView *ivType;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblShortName;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblPos;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end
