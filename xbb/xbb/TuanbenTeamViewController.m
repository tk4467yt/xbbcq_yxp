//
//  TuanbenTeamViewController.m
//  xbb
//
//  Created by  qin on 2017/4/22.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "TuanbenTeamViewController.h"
#import "MyUtility.h"
#import "TuanbenTeamTableViewCell.h"

@interface TuanbenTeamViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSDictionary *tuanbenBossDict;
@property (nonatomic,strong) NSDictionary *tuanbenTeamDict;

@property (nonatomic,strong) NSArray *bossId2showArr;
@end

@implementation TuanbenTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=NSLocalizedString(@"nav_title_for_tuanben_team", @"");
    
    self.tuanbenBossDict=[DbHandler getAllTuanbenBossInfoDict];
    self.tuanbenTeamDict=[DbHandler getAllTuanbenBossTeamDict];
    self.bossId2showArr=[DbHandler getAllTuanbenBossIdArr];
    
    [self.tbTuanbenTeam registerNib:[UINib nibWithNibName:@"TuanbenTeamTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tuanben_team_cell_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenOrientationChangedHandle
{
    [self.tbTuanbenTeam reloadData];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAppSizeInfo cacTableCellHeightForCVWithMaxWidth:[MyUtility screenWidth]-[MyUtility layoutMarginForLeftAndRightForView:self.view]
                                                  andItemSize:[MyAppSizeInfo heroBriefCVItemSize]
                                                 andItemCount:5
                                                andLineOffset:10]+16+10+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *bossId=self.bossId2showArr[section];
    NSArray *bossArr=self.tuanbenTeamDict[bossId];
    return bossArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuanbenTeamTableViewCell *teamCell=[tableView dequeueReusableCellWithIdentifier:@"tuanben_team_cell_id"];
    
    NSString *bossId=self.bossId2showArr[indexPath.section];
    NSArray *bossArr=self.tuanbenTeamDict[bossId];
    teamCell.tuanbenTeam=bossArr[indexPath.row];
    teamCell.teamIdx=indexPath.row;
    
    [teamCell setNeedsLayout];
    return teamCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.bossId2showArr.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *bossId=self.bossId2showArr[section];
    NSString *bossName=self.tuanbenBossDict[bossId];
    return bossName;
}
@end
