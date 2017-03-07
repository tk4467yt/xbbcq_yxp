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
#import "DbHandler.h"
#import "HeroTypeDesc.h"
#import "PosDesc.h"

#define kHeroDetailTopCellId @"hero_detail_top_table_view_cell"
#define kHeroDetailSpeciesCellId @"hero_detail_species_cell_id"
#define kHeroDetailStarInfoCellId @"hero_detail_star_info_cell_id"

@interface HeroDetailViewController ()
@property (nonatomic,strong) NSDictionary *heroTypeDescDict;
@property (nonatomic,strong) NSDictionary *heroPosDescDict;
@property (nonatomic,strong) NSArray *heroSpeciesArr;
@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=self.hero2show.heroName;
    
    self.heroTypeDescDict=[DbHandler getAllHeroTypeDescDict];
    self.heroPosDescDict=[DbHandler getAllPosDescDict];
    self.heroSpeciesArr=[DbHandler getHeroSpeciesForHero:self.hero2show.heroId];
    
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailTopCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailSpeciesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailSpeciesCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"HeroDetailStarInfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroDetailStarInfoCellId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 120;
    } else if (1 == indexPath.section) {
        if (self.heroSpeciesArr.count <= 0) {
            return 0;
        }
        return 60;
    } else if (2 == indexPath.section) {
        return 106;
    }
    return 0;
}

//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//    return NO;
//}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    } else if (1 == section) {
        return 1;
    } else if (2 == section) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell2ret=nil;
    
    if (0 == indexPath.section) {
        HeroDetailTopTableViewCell *topCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailTopCellId];
        
        topCell.ivThumb.image=[UIImage imageNamed:self.hero2show.thumbFile];
        topCell.lblName.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_name", @""),self.hero2show.heroName];
        
        HeroTypeDesc *typeDesc2use=self.heroTypeDescDict[self.hero2show.heroType];
        topCell.lblType.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_type", @""),typeDesc2use.typeDesc];
        topCell.ivType.image=[UIImage imageNamed:typeDesc2use.typeThumb];
        
        PosDesc *posDesc2use=self.heroPosDescDict[self.hero2show.heroPos];
        topCell.lblPos.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_pos", @""),posDesc2use.posDesc];
        
        topCell.lblDesc.text=[NSString stringWithFormat:NSLocalizedString(@"hero_cell_title_prefix_desc", @""),self.hero2show.heroDesc];
        
        cell2ret=topCell;
    } else if (1 == indexPath.section) {
        HeroDetailSpeciesTableViewCell *speciesCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailSpeciesCellId];
        speciesCell.heroSpeciesArr=self.heroSpeciesArr;
        
        cell2ret=speciesCell;
    } else if (2 == indexPath.section) {
        HeroDetailStarInfoTableViewCell *starInfoCell=[tableView dequeueReusableCellWithIdentifier:kHeroDetailStarInfoCellId];
        starInfoCell.initStar=self.hero2show.initStar;
        starInfoCell.curShownStarCount=self.hero2show.initStar;
        starInfoCell.heroGrowArr=[DbHandler getHeroGrowForHero:self.hero2show.heroId];
        
        cell2ret=starInfoCell;
    } else {
        cell2ret=[UITableViewCell new];
    }
    return cell2ret;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
@end
