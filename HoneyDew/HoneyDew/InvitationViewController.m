//
//  InvitationViewController.m
//  HoneyDew
//
//  Created by Song Wang on 3/31/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "InvitationViewController.h"
#import "InvitationTableViewCell.h"


static const CGFloat kHeightOfNavBar = 64;
static const NSInteger kNumberOfSections = 2;
static const CGFloat kHeightOfTableViewCell = 60;

static NSString *cellIdentifier = @"InvitationTableViewCellIdentifier";

@interface InvitationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation InvitationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  if (self) {
    UIView *invitationView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    invitationView.backgroundColor = [UIColor whiteColor];
    self.title = @"Invitations";
    self.tabBarItem.image = [UIImage imageNamed:@"Invite-25"];
    self.view = invitationView;
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.tableView];
  }
  return  self;
}


- (UINavigationBar *)navBar
{
  if (_navBar == nil) {
    _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeightOfNavBar)];
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"Invitations"];
    _navBar.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:1 alpha:1.0];
    [_navBar pushNavigationItem:item animated:NO];
  }
  return _navBar;
}

- (UITableView *)tableView
{
  if (_tableView == nil) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.navBar.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
  }
  return _tableView;
}


#pragma mark -- table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return kNumberOfSections;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return kHeightOfTableViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0)
  {
    return 5; //This is placeholder, will get the data from table view's data source
  }
  else{
    return 5;
  }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  switch(section) {
    case 0:
    case 1:
    default:return 50;
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UILabel * sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, tableView.frame.size.width, 50.0)];
  sectionHeader.backgroundColor = [UIColor blueColor];
  sectionHeader.textAlignment = NSTextAlignmentCenter;
  sectionHeader.font = [UIFont boldSystemFontOfSize:18];
  sectionHeader.textColor = [UIColor whiteColor];
  
  switch(section) {
    case 0:sectionHeader.text = @"Outgoing Invitations"; break;
    case 1:sectionHeader.text = @"Incoming Invitations"; break;
    default:sectionHeader.text = @"TITLE OTHER"; break;
  }
  return sectionHeader;
}


#pragma mark -- table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  InvitationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[InvitationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  //The following fields have placehoders
  if (indexPath.section == 0) {
    cell.nameLabel.text = @"John McCain";
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    cell.dateLabel.text =  dateString;
  }
  else {
    cell.nameLabel.text = @"Barack Obama";
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    cell.dateLabel.text =  dateString;
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
