//
//  HeroArtViewController.m
//  xbb
//
//  Created by  qin on 2017/3/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroArtViewController.h"
#import "HeroArtTableViewCell.h"
#import "MyUtility.h"
#import "HeroInfo.h"
#import "DbHandler.h"

#define kHeroArtCellId @"hero_art_tb_cell_id"

@interface HeroArtViewController ()
@property (strong,nonatomic) HeroInfo *heroInfo2use;
@end

@implementation HeroArtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=NSLocalizedString(@"nav_title_art", @"");
    
    [self.tbArt registerNib:[UINib nibWithNibName:@"HeroArtTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroArtCellId];
    
    self.heroInfo2use=[DbHandler getHeroInfoWithHeroId:self.heroId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyUtility screenHeight]-80;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell2ret=nil;
    
    HeroArtTableViewCell *artCell=[tableView dequeueReusableCellWithIdentifier:kHeroArtCellId];
    
    artCell.ivArt.image=[UIImage imageNamed:self.heroInfo2use.artFile];
    
    cell2ret=artCell;
    
    [cell2ret setNeedsLayout];
    return cell2ret;
}

@end
