//
//  HeroDetailSkillTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/7.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailSkillTableViewCell.h"
#import "HeroSkillItemTableViewCell.h"
#import "HeroSkill.h"
#import "MyUtility.h"
#import "RankDesc.h"
#import "DbHandler.h"

#define kHeroSkillItemTBCellId @"hero_skill_item_tb_cell_id"

@interface HeroDetailSkillTableViewCell () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation HeroDetailSkillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tbSkills.delegate=self;
    self.tbSkills.dataSource=self;
    
    [self.tbSkills registerNib:[UINib nibWithNibName:@"HeroSkillItemTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroSkillItemTBCellId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblSkillDesc.text=NSLocalizedString(@"skill_title", @"");
    
    [self.tbSkills reloadData];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeroSkill *heroSkill=self.heroSkillsArr[indexPath.row];
    CGFloat skillRowHeight = MAX(96, 20+16+[MyUtility getLabelHeightByWidth:[MyUtility screenWidth]-80-16-10-60-10 title:heroSkill.skillDesc font:[UIFont systemFontOfSize:14]]);
    return skillRowHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heroSkillsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeroSkillItemTableViewCell *skillItemCell=[tableView dequeueReusableCellWithIdentifier:kHeroSkillItemTBCellId];
    
    HeroSkill *heroSkill=self.heroSkillsArr[indexPath.row];
    skillItemCell.ivSkillThumb.image=[UIImage imageNamed:heroSkill.skillThumb];
    skillItemCell.lblSkillName.text=[NSString stringWithFormat:@"%@:",heroSkill.skillName];
    skillItemCell.lblSkillDesc.text=heroSkill.skillDesc;
    
    RankDesc *rankDesc=[DbHandler getRankDescForRankId:[MyUtility rankIdForBai]];
    UIImage *maskImg=[UIImage imageNamed:rankDesc.equipFrameThumb];
    skillItemCell.ivSkillThumbMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    
    return skillItemCell;
}

@end
