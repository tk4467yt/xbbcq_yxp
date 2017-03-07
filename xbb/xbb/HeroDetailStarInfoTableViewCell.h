//
//  HeroDetailStarInfoTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/7.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailStarInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivStar0;
@property (weak, nonatomic) IBOutlet UIImageView *ivStar1;
@property (weak, nonatomic) IBOutlet UIImageView *ivStar2;
@property (weak, nonatomic) IBOutlet UIImageView *ivStar3;
@property (weak, nonatomic) IBOutlet UIImageView *ivStar4;
@property (weak, nonatomic) IBOutlet UILabel *lblLiliangGrow;
@property (weak, nonatomic) IBOutlet UILabel *lblZhiliGrow;
@property (weak, nonatomic) IBOutlet UILabel *lblMinjieGrow;

@property (nonatomic,assign) NSInteger initStar;
@property (nonatomic,assign) NSInteger curShownStarCount;
@property (nonatomic,strong) NSArray *heroGrowArr;
@end
