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
#import "HeroTypeDesc.h"

#define kHeroArtCellId @"hero_art_tb_cell_id"

@interface HeroArtViewController ()
@property (strong,nonatomic) HeroInfo *heroInfo2use;
@property (nonatomic,strong) NSDictionary *heroTypeDescDict;

@property (nonatomic,assign) BOOL shownJuexingArt;
@end

@implementation HeroArtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heroInfo2use=[MyUtility getCachedHeroInfoWithHeroId:self.heroId];
    self.heroTypeDescDict=[DbHandler getAllHeroTypeDescDict];
    
    self.navigationItem.title=[NSString stringWithFormat:@"%@-%@",NSLocalizedString(@"nav_title_art", @""),self.heroInfo2use.heroName];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(switchArtShown)];
    
    [self updateRightNavItem];
    
    [self.tbArt registerNib:[UINib nibWithNibName:@"HeroArtTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeroArtCellId];
}

-(void)screenOrientationChangedHandle
{
    [self.tbArt reloadData];
}

- (void)switchArtShown
{
    self.shownJuexingArt=!self.shownJuexingArt;
    
    [self updateRightNavItem];
    [self.tbArt reloadData];
}

-(void)updateRightNavItem
{
    if (self.shownJuexingArt) {
        self.navigationItem.rightBarButtonItem.title=NSLocalizedString(@"hero_title_thumb_juexing", @"");
    } else {
        self.navigationItem.rightBarButtonItem.title=NSLocalizedString(@"hero_title_thumb_normal", @"");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyUtility screenHeight]-[MyUtility heightOfStatusBar]-self.navigationController.navigationBar.frame.size.height;
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
    
    HeroTypeDesc *typeDesc=self.heroTypeDescDict[self.heroInfo2use.heroType];
    artCell.ivType.image=[UIImage imageNamed:typeDesc.typeThumbS];
    
    cell2ret=artCell;
    
    [cell2ret setNeedsLayout];
    return cell2ret;
}

@end
