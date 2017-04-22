//
//  Juexing2FushiViewController.m
//  xbb
//
//  Created by  qin on 2017/4/22.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "Juexing2FushiViewController.h"
#import "MyUtility.h"
#import "FushiDescTableViewCell.h"
#import "Juexing2fushiInfo.h"

@interface Juexing2FushiViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSDictionary *fushiDescDict;
@property (nonatomic,strong) NSDictionary *juexing2fushiInfoDict;

@property (nonatomic,strong) NSArray *heroIdArr;
@end

@implementation Juexing2FushiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=NSLocalizedString(@"title_for_juexing2_fushi", @"");
    
    self.fushiDescDict=[DbHandler getAllFushiDescDict];
    self.juexing2fushiInfoDict=[DbHandler getAllJuexing2FushiInfoDict];
    
    self.heroIdArr=[self.juexing2fushiInfoDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        HeroInfo *hero1=[MyUtility getCachedHeroInfoWithHeroId:obj1];
        HeroInfo *hero2=[MyUtility getCachedHeroInfoWithHeroId:obj2];
        return [hero1.heroName compare:hero2.heroName];
    }];
    
    [self.tbFushi registerNib:[UINib nibWithNibName:@"FushiDescTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fushi_desc_cell_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenOrientationChangedHandle
{
    [self.tbFushi reloadData];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FushiDescTableViewCell *fushiDescCell=[tableView dequeueReusableCellWithIdentifier:@"fushi_desc_cell_id" forIndexPath:indexPath];
    
    NSString *heroId=self.heroIdArr[indexPath.section];
    NSArray *fushiDescArr=self.juexing2fushiInfoDict[heroId];
    Juexing2fushiInfo *aInfo=fushiDescArr[indexPath.row];
    NSString *fushiId=aInfo.fushiId;
    
    fushiDescCell.lblFushiName.text=[NSString stringWithFormat:@"%@:",self.fushiDescDict[fushiId]];
    fushiDescCell.lblFushiAttr.text=aInfo.fushiDesc;
    
    return fushiDescCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.heroIdArr.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HeroInfo *heroInfo=[MyUtility getCachedHeroInfoWithHeroId:self.heroIdArr[section]];
    return heroInfo.heroName;
}
@end
