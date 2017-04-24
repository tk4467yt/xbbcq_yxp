//
//  MengjingTeamViewController.m
//  xbb
//
//  Created by  qin on 2017/4/22.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MengjingTeamViewController.h"
#import "MyUtility.h"
#import "MengjingTeamTableViewCell.h"
#import "MengjingTeam.h"

@interface MengjingTeamViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbTeam;
@property (nonatomic,strong) NSDictionary *mengjingBossDict;
@property (nonatomic,strong) NSDictionary *mengjingTeamDict;

@property (nonatomic,strong) NSArray *bossId2showArr;

@end

@implementation MengjingTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=NSLocalizedString(@"nav_title_for_mengjing_team", @"");
    
    self.mengjingBossDict=[DbHandler getAllMengjingBossDescDict];
    self.mengjingTeamDict=[DbHandler getAllMengjingTeamDict];
    
    self.bossId2showArr=[self.mengjingBossDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        NSString *bossName1=self.mengjingBossDict[obj1];
        NSString *bossName2=self.mengjingBossDict[obj2];
        
        return [bossName1 compare:bossName2];
    }];
    [self.tbTeam registerNib:[UINib nibWithNibName:@"MengjingTeamTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mengjing_team_cell_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenOrientationChangedHandle
{
    [self.tbTeam reloadData];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bossId=self.bossId2showArr[indexPath.section];
    NSArray *teamArr=self.mengjingTeamDict[bossId];
    MengjingTeam *teamInfo=teamArr[indexPath.row];
    
    NSInteger count=6;
    if ([MyUtility isStringNilOrZeroLength:teamInfo.heroId6]) {
        count=5;
    }
    return [MyAppSizeInfo cacTableCellHeightForCVWithMaxWidth:[MyUtility screenWidth]-[MyUtility layoutMarginForLeftAndRightForView:self.view]
                                                  andItemSize:[MyAppSizeInfo heroBriefCVItemSize]
                                                 andItemCount:count
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
    NSArray *teamArr=self.mengjingTeamDict[bossId];
    return teamArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MengjingTeamTableViewCell *teamCell=[tableView dequeueReusableCellWithIdentifier:@"mengjing_team_cell_id"];
    
    NSString *bossId=self.bossId2showArr[indexPath.section];
    NSArray *teamArr=self.mengjingTeamDict[bossId];
    teamCell.teamInfo=teamArr[indexPath.row];
    
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
    
    return self.mengjingBossDict[bossId];
}
@end
