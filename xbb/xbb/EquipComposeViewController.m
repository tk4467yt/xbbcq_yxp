//
//  EquipComposeViewController.m
//  xbb
//
//  Created by  qin on 2017/3/9.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeViewController.h"
#import "HeroCollectionViewCell.h"
#import "EquipComposeHeaderTableViewCell.h"
#import "EquipComposeContentTableViewCell.h"
#import "MyUtility.h"
#import "DbHandler.h"

#define equipComposeHeaderCellId @"equip_compose_header_tb_cell_id"
#define equipComposeContentCellId @"equip_compose_content_tb_cell_id"

@interface EquipComposeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *equip2showArr;
@end

@implementation EquipComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=self.equipInfo.equipName;
    
    self.equip2showArr=[NSMutableArray new];
    [self.equip2showArr addObject:self.equipInfo.equipId];
    
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeHeaderCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeContentCellId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 80;
    } else if (1 == indexPath.section) {
        return [MyUtility screenHeight]-80-60-20;
    }
    return 0;
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
        EquipComposeHeaderTableViewCell *headerCell=[tableView dequeueReusableCellWithIdentifier:equipComposeHeaderCellId];
        headerCell.equipShowingArr=self.equip2showArr;
        
        cell2ret=headerCell;
    } else if (1 == indexPath.section) {
        EquipComposeContentTableViewCell *contentCell=[tableView dequeueReusableCellWithIdentifier:equipComposeContentCellId];
        
        cell2ret=contentCell;
    } else {
        cell2ret=[UITableViewCell new];
    }
    return cell2ret;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
@end
