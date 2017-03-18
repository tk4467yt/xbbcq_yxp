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

@property (nonatomic,assign) BOOL shownJuexingArt;
@end

@implementation HeroArtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=NSLocalizedString(@"nav_title_art", @"");
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(switchArtShown)];
    
    [self.tbArt registerNib:[UINib nibWithNibName:@"HeroArtTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroArtCellId];
    
    self.heroInfo2use=[DbHandler getHeroInfoWithHeroId:self.heroId];
}

- (void)switchArtShown
{
    self.shownJuexingArt=!self.shownJuexingArt;
    
    [self.tbArt reloadData];
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
    
    if (self.shownJuexingArt && ![MyUtility isStringNilOrZeroLength:self.heroInfo2use.artFileS]) {
        artCell.ivArt.image=[UIImage imageNamed:self.heroInfo2use.artFileS];
    } else {
        artCell.ivArt.image=[UIImage imageNamed:self.heroInfo2use.artFile];
    }
    
    cell2ret=artCell;
    
    [cell2ret setNeedsLayout];
    return cell2ret;
}

@end
