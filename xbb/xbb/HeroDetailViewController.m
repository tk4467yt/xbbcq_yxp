//
//  HeroDetailViewController.m
//  xbb
//
//  Created by  qin on 2017/3/5.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "HeroDetailTopTableViewCell.h"
#import "HeroDetailSpeciesTableViewCell.h"
#import "HeroDetailStarInfoTableViewCell.h"
#import "HeroDetailSkillTableViewCell.h"
#import "HeroDetailEquipsTableViewCell.h"
#import "EquipComposeViewController.h"
#import "DbHandler.h"
#import "HeroTypeDesc.h"
#import "PosDesc.h"
#import "MyUtility.h"
#import "HeroEquips.h"
#import "HeroSkill.h"
#import "RankDesc.h"

#define kHeroDetailTopCellId @"hero_detail_top_table_view_cell"
#define kHeroDetailSpeciesCellId @"hero_detail_species_cell_id"
#define kHeroDetailStarInfoCellId @"hero_detail_star_info_cell_id"
#define kHeroDetailSkillCellId @"hero_detail_skill_tb_cell_id"
#define kHeroDetailEquipCellId @"hero_detail_equip_tb_cell_id"

@interface HeroDetailViewController () <HeroDetailEquipsTapDelegate>
@property (nonatomic,strong) NSDictionary *heroTypeDescDict;
@property (nonatomic,strong) NSDictionary *heroPosDescDict;
@property (nonatomic,strong) NSArray *heroSpeciesArr;
@property (nonatomic,strong) NSArray *heroSkillsArr;
@property (nonatomic,strong) NSDictionary *heroEquipsDict;
@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.heroTypeDescDict=[DbHandler getAllHeroTypeDescDict];
    self.heroPosDescDict=[DbHandler getAllPosDescDict];
    [self updateHeroRelateStructure];
    
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailTopCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailSpeciesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailSpeciesCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailStarInfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailStarInfoCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailSkillTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailSkillCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailEquipsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailEquipCellId];
}

-(void)updateHeroRelateStructure
{
    self.navigationItem.title=self.hero2show.heroName;
    
    self.heroSpeciesArr=[DbHandler getHeroSpeciesForHero:self.hero2show.heroId];
    self.heroSkillsArr=[DbHandler getHeroSkillsForHero:self.hero2show.heroId];
    self.heroEquipsDict=[DbHandler getHeroEquipsDictForHero:self.hero2show.heroId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)heightForEquipTopCell
{
    CGFloat height2ret=16+20*4;
    height2ret += [MyUtility getLabelHeightByWidth:[MyUtility screenWidth]-60-16-10 title:[self heroDescText] font:[UIFont systemFontOfSize:15]];
    height2ret += 10;
    return height2ret;
}

#pragma mark SpeciesSetDidSelectHeroDelegate
- (void)speciesSetDidSelectHeroWithId:(NSString *)heroId
{
    if (![MyUtility isStringNilOrZeroLength:heroId] && ![heroId isEqualToString:self.hero2show.heroId]) {
        self.hero2show=[DbHandler getHeroInfoWithHeroId:heroId];
        
        [self updateHeroRelateStructure];
        
        [self.tbContent reloadData];
    }
}

#pragma mark HeroDetailEquipsTapDelegate
- (void)equipTappedWithRank:(NSString *)rankId andItemIdx:(NSInteger)itemIdx
{
    HeroEquips *heroEquip=self.heroEquipsDict[rankId];
    
    NSString *equipId=@"";
    
    if ([MyUtility shouldSwitchEquipsForRankId:rankId]) {
        if (0 == itemIdx) {
            equipId=heroEquip.equip6;
        } else if (1 == itemIdx) {
            equipId=heroEquip.equip1;
        } else if (2 == itemIdx) {
            equipId=heroEquip.equip2;
        } else if (3 == itemIdx) {
            equipId=heroEquip.equip3;
        } else if (4 == itemIdx) {
            equipId=heroEquip.equip4;
        } else if (5 == itemIdx) {
            equipId=heroEquip.equip5;
        }
    } else {
        if (0 == itemIdx) {
            equipId=heroEquip.equip1;
        } else if (1 == itemIdx) {
            equipId=heroEquip.equip2;
        } else if (2 == itemIdx) {
            equipId=heroEquip.equip3;
        } else if (3 == itemIdx) {
            equipId=heroEquip.equip4;
        } else if (4 == itemIdx) {
            equipId=heroEquip.equip5;
        } else if (5 == itemIdx) {
            equipId=heroEquip.equip6;
        }
    }
    
    if (![MyUtility isStringNilOrZeroLength:equipId]) {
        EquipInfo *equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:equipId];
        if (nil != equipInfo2use) {
            EquipComposeViewController *composeVC=[EquipComposeViewController new];
            
            composeVC.equipInfo=equipInfo2use;
            
            [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:composeVC animated:YES];
        }
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return [self heightForEquipTopCell];
    } else if (1 == indexPath.section) {
//        if (self.heroSpeciesArr.count <= 0) {
//            return 0;
//        }
        CGFloat maxCVWidth=[MyUtility screenWidth]-70-16;
        CGSize itemSize=[MyAppSizeInfo heroSpeciesItemSize];
        NSInteger maxItemOneLine=maxCVWidth/itemSize.width;
        NSInteger itemShown=maxItemOneLine;
        CGFloat height=itemSize.height;
        while (itemShown < self.heroSpeciesArr.count) {
            itemShown += maxItemOneLine;
            height += itemSize.height+10;
        }
        return height;
    } else if (2 == indexPath.section) {
        return 110;
    } else if (3 == indexPath.section) {
        CGFloat skillRowHeight=0;
        for (HeroSkill *aSkill in self.heroSkillsArr) {
            skillRowHeight += [HeroDetailSkillTableViewCell getHeightForASkill:aSkill];
        }
        return skillRowHeight+16;
    } else if (4 == indexPath.section) {
        CGFloat maxCVWidth=[MyUtility screenWidth]-70-16;
        CGSize itemSize = [MyAppSizeInfo equipBriefCVItemSmallSize];
        NSInteger maxItemOneLine=maxCVWidth/itemSize.width;
        NSInteger itemShown=maxItemOneLine;
        CGFloat height=itemSize.height;
        while (itemShown < 6) {
            itemShown += maxItemOneLine;
            height += itemSize.height;
        }
        return height+18+8;
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    } else if (1 == section) {
        return 1;
    } else if (2 == section) {
        return 1;
    } else if (3 == section) {
        return 1;
    } else if (4 == section) {
        return 16;
    }
    return 0;
}

- (NSString *)heroDescText
{
    return [NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_desc", @""),self.hero2show.heroDesc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell2ret=nil;
    
    if (0 == indexPath.section) {
        HeroDetailTopTableViewCell *topCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailTopCellId];
        
        topCell.ivThumb.image=[UIImage imageNamed:self.hero2show.thumbFile];
        topCell.lblName.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_name", @""),self.hero2show.heroName];
        topCell.lblShortName.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_short_name", @""),self.hero2show.shortName];
        
        RankDesc *rankDesc=[MyUtility getRankDescForRankIdCache:[MyUtility rankIdForBai]];
        UIImage *maskImg=[UIImage imageNamed:rankDesc.heroIconFrameThumb];
        topCell.ivThumbMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
        
        HeroTypeDesc *typeDesc2use=self.heroTypeDescDict[self.hero2show.heroType];
        topCell.lblType.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_type", @""),typeDesc2use.typeDesc];
        topCell.ivType.image=[UIImage imageNamed:typeDesc2use.typeThumb];
        
        PosDesc *posDesc2use=self.heroPosDescDict[self.hero2show.heroPos];
        topCell.lblPos.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_pos", @""),posDesc2use.posDesc];
        
        topCell.lblDesc.text=[self heroDescText];
        
        topCell.parentVC=self;
        topCell.heroId=self.hero2show.heroId;
        
        cell2ret=topCell;
    } else if (1 == indexPath.section) {
        HeroDetailSpeciesTableViewCell *speciesCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailSpeciesCellId];
        speciesCell.heroSpeciesArr=self.heroSpeciesArr;
        speciesCell.parentVC=self;
        
        cell2ret=speciesCell;
    } else if (2 == indexPath.section) {
        HeroDetailStarInfoTableViewCell *starInfoCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailStarInfoCellId];
        starInfoCell.initStar=self.hero2show.initStar;
        starInfoCell.curShownStarCount=self.hero2show.initStar;
        starInfoCell.heroGrowArr=[DbHandler getHeroGrowForHero:self.hero2show.heroId];
        
        cell2ret=starInfoCell;
    } else if (3 == indexPath.section) {
        HeroDetailSkillTableViewCell *skillCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailSkillCellId];
        skillCell.heroSkillsArr=self.heroSkillsArr;
        
        cell2ret=skillCell;
    } else if (4 == indexPath.section) {
        HeroDetailEquipsTableViewCell *equipCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailEquipCellId];
        equipCell.lblEquipDesc.hidden=true;
        
        NSString *rankId2use=@"";
        NSString *title2set=@"";
        if (15 == indexPath.row) {
            rankId2use=[MyUtility rankIdForBai];
            title2set=NSLocalizedString(@"title_equip_bai", @"");
        } else if (14 == indexPath.row) {
            rankId2use=[MyUtility rankIdForLv];
            title2set=NSLocalizedString(@"title_equip_lv", @"");
        } else if (13 == indexPath.row) {
            rankId2use=[MyUtility rankIdForLv1];
            title2set=NSLocalizedString(@"title_equip_lv1", @"");
        } else if (12 == indexPath.row) {
            rankId2use=[MyUtility rankIdForLan];
            title2set=NSLocalizedString(@"title_equip_lan", @"");
        } else if (11 == indexPath.row) {
            rankId2use=[MyUtility rankIdForLan1];
            title2set=NSLocalizedString(@"title_equip_lan1", @"");
        } else if (10 == indexPath.row) {
            rankId2use=[MyUtility rankIdForLan2];
            title2set=NSLocalizedString(@"title_equip_lan2", @"");
        } else if (9 == indexPath.row) {
            rankId2use=[MyUtility rankIdForZi];
            title2set=NSLocalizedString(@"title_equip_zi", @"");
        } else if (8 == indexPath.row) {
            rankId2use=[MyUtility rankIdForZi1];
            title2set=NSLocalizedString(@"title_equip_zi1", @"");
        } else if (7 == indexPath.row) {
            rankId2use=[MyUtility rankIdForZi2];
            title2set=NSLocalizedString(@"title_equip_zi2", @"");
        } else if (6 == indexPath.row) {
            rankId2use=[MyUtility rankIdForZi3];
            title2set=NSLocalizedString(@"title_equip_zi3", @"");
        } else if (5 == indexPath.row) {
            rankId2use=[MyUtility rankIdForZi4];
            title2set=NSLocalizedString(@"title_equip_zi4", @"");
        } else if (4 == indexPath.row) {
            rankId2use=[MyUtility rankIdForCheng];
            title2set=NSLocalizedString(@"title_equip_cheng", @"");
        } else if (3 == indexPath.row) {
            rankId2use=[MyUtility rankIdForCheng1];
            title2set=NSLocalizedString(@"title_equip_cheng1", @"");
        } else if (2 == indexPath.row) {
            rankId2use=[MyUtility rankIdForCheng2];
            title2set=NSLocalizedString(@"title_equip_cheng2", @"");
        } else if (1 == indexPath.row) {
            rankId2use=[MyUtility rankIdForHong];
            title2set=NSLocalizedString(@"title_equip_hong", @"");
        } else if (0 == indexPath.row) {
            equipCell.lblEquipDesc.hidden=false;
            rankId2use=[MyUtility rankIdForHong1];
            title2set=NSLocalizedString(@"title_equip_hong1", @"");
        }
        
        HeroEquips *aHeroEquip=self.heroEquipsDict[rankId2use];
        
        equipCell.rankId=rankId2use;
        equipCell.equipTapDelegate=self;
        
        equipCell.lblRankDesc.text=title2set;
        
        equipCell.heroEquips=aHeroEquip;
        
        cell2ret=equipCell;
    } else {
        cell2ret=[UITableViewCell new];
    }
    
    if (0 == indexPath.section%2) {
        cell2ret.backgroundColor=[UIColor lightGrayColor];
    } else {
        cell2ret.backgroundColor=[UIColor grayColor];
    }
    
    [cell2ret setNeedsLayout];
    return cell2ret;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
@end
