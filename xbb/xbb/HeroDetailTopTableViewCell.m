//
//  HeroDetailTopTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/6.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailTopTableViewCell.h"
#import "HeroArtViewController.h"
#import "MyUtility.h"

@implementation HeroDetailTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbTapped:)];
    [self.ivThumb addGestureRecognizer:tapGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)thumbTapped:(UITapGestureRecognizer *)tapGesture
{
//    HeroArtViewController *detailVC=[HeroArtViewController new];
//    detailVC.heroId=self.heroId;
//    
//    [MyUtility pushViewControllerFromNav:self.parentVC.navigationController withTargetVC:detailVC animated:YES];
}

@end
