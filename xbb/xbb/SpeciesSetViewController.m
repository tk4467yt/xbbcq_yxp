//
//  SpeciesSetViewController.m
//  xbb
//
//  Created by  qin on 2017/3/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "SpeciesSetViewController.h"
#import "SpeciesSetTopTableViewCell.h"
#import "MyUtility.h"
#import "SpeciesSetHerosTableViewCell.h"
#import "HeroSpecies.h"
#import "HeroInfo.h"
#import "DbHandler.h"

#define kSepciesSetTopCellId @"species_set_top_tb_cell_id"
#define kSpeciesSetHerosCellId @"species_set_heros_tb_cell_id"

@interface SpeciesSetViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *allHeroSpeciesArr;
@end

@implementation SpeciesSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.allHeroSpeciesArr=[MyUtility getAllHeroSpeciesArr];
    
    self.navigationItem.title=self.speciesDesc2show.speciesDesc;
    
    [self.tbSpeciesSet registerNib:[UINib nibWithNibName:@"SpeciesSetTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kSepciesSetTopCellId];
    [self.tbSpeciesSet registerNib:[UINib nibWithNibName:@"SpeciesSetHerosTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kSpeciesSetHerosCellId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)getAllHerosForCurSpecies
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    for (HeroSpecies *aHeroSpecies in self.allHeroSpeciesArr) {
        if ([aHeroSpecies.speciesId isEqualToString:self.speciesDesc2show.speciesId]) {
            HeroInfo *heroInfo=[DbHandler getHeroInfoWithHeroId:aHeroSpecies.heroId];
            [arr2ret addObject:heroInfo];
        }
    }
    
    return arr2ret;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 50;
    } else if (1 == indexPath.section) {
        return [MyUtility screenHeight]-50-80;
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
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell2ret=nil;
    
    if (0 == indexPath.section) {
        SpeciesSetTopTableViewCell *topCell=[tableView dequeueReusableCellWithIdentifier:kSepciesSetTopCellId];
        
        topCell.ivSpeciesThumb.image=[UIImage imageNamed:self.speciesDesc2show.speciesThumb];
        topCell.lblSpeciesDesc.text=self.speciesDesc2show.speciesDesc;
        
        topCell.backgroundColor=[UIColor lightGrayColor];
        cell2ret=topCell;
    } else if (1 == indexPath.section) {
        SpeciesSetHerosTableViewCell *herosCell=[tableView dequeueReusableCellWithIdentifier:kSpeciesSetHerosCellId];
        
        herosCell.lblHeroDesc.text=[NSString stringWithFormat:@"%@:",NSLocalizedString(@"nav_title_hero", @"")];
        herosCell.herosArr=[self getAllHerosForCurSpecies];
        
        herosCell.backgroundColor=[UIColor grayColor];
        cell2ret=herosCell;
    }
    
    [cell2ret setNeedsLayout];
    return cell2ret;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


@end
