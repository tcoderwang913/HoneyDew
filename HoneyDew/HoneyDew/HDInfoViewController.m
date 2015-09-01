//
//  HDInfoViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/20/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDInfoViewController.h"
#import "HDControlManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ProfileManager.h"
#import "HDInfoListCell.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"
#import "UIView+Position.h"

#define FBButtonTag 100

@interface HDInfoViewController ()
@property (nonatomic) UITableView *infoTableView;
@property (nonatomic) NSMutableArray *dataModel;
@end

@implementation HDInfoViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self loadUserInfo];
  [self manuallyLayoutSubviews];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.dataModel count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[self.dataModel objectAtIndex:section] allKeys] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *eventCellIdentifier = @"EventCellIdentifier";
  HDInfoListCell *cell = (HDInfoListCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
  if (!cell) {
    cell = [[HDInfoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
  }

  NSDictionary *sectionData = [self.dataModel objectAtIndex:indexPath.section];
  NSString *cellString = [[sectionData allKeys] objectAtIndex:indexPath.row];
  cell.cellLabel.text = cellString;
  cell.cellTF.text = [sectionData objectForKey:cellString];
  cell.cellTF.userInteractionEnabled = NO;
  return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [HDInfoListCell defaultHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  if (section == self.dataModel.count - 1) {
    return 60;
  } else {
    return 0;
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  if (section == self.dataModel.count - 1) {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.infoTableView.frameWidth, 50)];
    containerView.backgroundColor = [UIColor clearColor];
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(0, 20, self.infoTableView.frameWidth, 40);
    logoutButton.backgroundColor = UIColorFromRGB(PRIM_RED_COLOR);
    [logoutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [logoutButton.titleLabel setFont:MediumHelNeueFontOfSize(15)];
    [logoutButton setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logOutFB:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:logoutButton];
    [logoutButton centerHorizontally];
    return containerView;
  } else {
    return nil;
  }
}

#pragma mark - Private methods

- (void)logOutFB:(id)sender {
  [[FBSDKLoginManager new] logOut];
  // back to login screen
  [[HDControlManager sharedManager] popToRootLoginViewController];
}

- (void)commonInit {
  _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _infoTableView.allowsSelection = NO;
  _infoTableView.delegate = self;
  _infoTableView.dataSource = self;
  
  _infoTableView.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  self.view.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  [self.view addSubview:_infoTableView];
  
  _dataModel = [NSMutableArray array];
}

- (void)loadUserInfo {
  [_dataModel removeAllObjects];
  HDProfile *appProfile = [ProfileManager sharedManager].appProfile;
  
  NSDictionary *personInfo = @{@"Email Address":appProfile.email, @"Name":appProfile.name, @"Password":appProfile.pwd};
  NSDictionary *jobInfo = @{@"Title":appProfile.jobDescription, @"Location":appProfile.location, @"Organization":appProfile.organization};
  NSDictionary *foodInfo = @{@"Food Flavor":appProfile.foodFlavor};
  
  [_dataModel addObject:personInfo];
  [_dataModel addObject:jobInfo];
  [_dataModel addObject:foodInfo];
}

- (void)manuallyLayoutSubviews {
  [self setTitle:@"Info"];
  UIEdgeInsets tableViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
  _infoTableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, tableViewInsets);
  
  // create right bar item
  UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonTapped:)];
  self.navigationItem.rightBarButtonItem = add;
}

- (void)editButtonTapped:(id)sender {
  
}

@end
