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

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
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
    skillItemCell.lblSkillName.text=heroSkill.skillName;
    skillItemCell.lblSkillDesc.text=heroSkill.skillDesc;
    
    return skillItemCell;
}

@end
