//
//  HeroDetailStarInfoTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/7.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailStarInfoTableViewCell.h"
#import "MyUtility.h"
#import "HeroGrow.h"

@implementation HeroDetailStarInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tapGesture0=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(star0Tapped:)];
    [self.ivStar0 addGestureRecognizer:tapGesture0];
    
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(star1Tapped:)];
    [self.ivStar1 addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(star2Tapped:)];
    [self.ivStar2 addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(star3Tapped:)];
    [self.ivStar3 addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(star4Tapped:)];
    [self.ivStar4 addGestureRecognizer:tapGesture4];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblStarDesc.text=NSLocalizedString(@"star_title", @"");
    
    CGFloat curLiliang=0;
    CGFloat curZhili=0;
    CGFloat curMinjie=0;
    
    for (HeroGrow *aHeroGrow in self.heroGrowArr) {
        if (aHeroGrow.starCount == self.curShownStarCount) {
            curLiliang=aHeroGrow.liliang;
            curZhili=aHeroGrow.zhili;
            curMinjie=aHeroGrow.minjie;
            break;
        }
    }
    
    if (1 == self.curShownStarCount) {
        self.ivStar0.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar1.image=[UIImage imageNamed:kHeroStarImageGrey];
        self.ivStar2.image=[UIImage imageNamed:kHeroStarImageGrey];
        self.ivStar3.image=[UIImage imageNamed:kHeroStarImageGrey];
        self.ivStar4.image=[UIImage imageNamed:kHeroStarImageGrey];
    } else if (2 == self.curShownStarCount) {
        self.ivStar0.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar1.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar2.image=[UIImage imageNamed:kHeroStarImageGrey];
        self.ivStar3.image=[UIImage imageNamed:kHeroStarImageGrey];
        self.ivStar4.image=[UIImage imageNamed:kHeroStarImageGrey];
    } else if (3 == self.curShownStarCount) {
        self.ivStar0.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar1.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar2.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar3.image=[UIImage imageNamed:kHeroStarImageGrey];
        self.ivStar4.image=[UIImage imageNamed:kHeroStarImageGrey];
    } else if (4 == self.curShownStarCount) {
        self.ivStar0.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar1.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar2.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar3.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar4.image=[UIImage imageNamed:kHeroStarImageGrey];
    } else if (5 == self.curShownStarCount) {
        self.ivStar0.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar1.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar2.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar3.image=[UIImage imageNamed:kHeroStarImage];
        self.ivStar4.image=[UIImage imageNamed:kHeroStarImage];
    }
    
    self.lblLiliangGrow.text=[NSString stringWithFormat:NSLocalizedString(@"liliang_grow_title", @""),[NSString stringWithFormat:@"%.2f / 10",curLiliang]];
    self.lblZhiliGrow.text=[NSString stringWithFormat:NSLocalizedString(@"zhili_grow_title", @""),[NSString stringWithFormat:@"%.2f / 10",curZhili]];
    self.lblMinjieGrow.text=[NSString stringWithFormat:NSLocalizedString(@"minjie_grow_title", @""),[NSString stringWithFormat:@"%.2f / 10",curMinjie]];
}

- (IBAction)star0Tapped:(UITapGestureRecognizer *)sender {
    if (self.initStar <= 1) {
        self.curShownStarCount=1;
    }
    
    [self setNeedsLayout];
}

- (IBAction)star1Tapped:(UITapGestureRecognizer *)sender {
    if (self.initStar <= 2) {
        self.curShownStarCount=2;
    }
    
    [self setNeedsLayout];
}

- (IBAction)star2Tapped:(UITapGestureRecognizer *)sender {
    if (self.initStar <= 3) {
        self.curShownStarCount=3;
    }
    
    [self setNeedsLayout];
}

- (IBAction)star3Tapped:(UITapGestureRecognizer *)sender {
    if (self.initStar <= 4) {
        self.curShownStarCount=4;
    }
    
    [self setNeedsLayout];
}

- (IBAction)star4Tapped:(UITapGestureRecognizer *)sender {
    if (self.initStar <= 5) {
        self.curShownStarCount=5;
    }
    
    [self setNeedsLayout];
}
@end
