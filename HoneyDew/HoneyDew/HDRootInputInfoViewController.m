//
//  HDRootInputInfoViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 7/1/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDRootInputInfoViewController.h"
#import "HDControlManager.h"
#import "ProfileManager.h"
#import "HDProfile.h"
#import "UIView+Position.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"
#import "HDEvtCreateViewCell.h"

const static CGFloat kControlVertMargin = 20;
const static CGFloat kControlHorMargin = 10;

@interface HDRootInputInfoViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *infoTableView;
@property (nonatomic) NSArray *placeHolderArray;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UITextField *activeTF;

@property (nonatomic) UILabel *inputViewTitle;
@property (nonatomic) UILabel *emailTitle;
@property (nonatomic) UITextField *emailTF;
@property (nonatomic) UILabel *nameTitle;
@property (nonatomic) UITextField *nameTF;
@property (nonatomic) UILabel *pwdTitle;
@property (nonatomic) UITextField *pwdTF;
@property (nonatomic) UILabel *jobTitle;
@property (nonatomic) UITextField *jobTF;
@property (nonatomic) UILabel *locationTitle;
@property (nonatomic) UITextField *locationTF;
@property (nonatomic) UILabel *orgTitle;
@property (nonatomic) UITextField *orgTF;
@property (nonatomic) UILabel *foodTitle;
@property (nonatomic) UITextField *foodTF;

@property (nonatomic) UIButton *confirmButton;
@end

@implementation HDRootInputInfoViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if ([ProfileManager sharedManager].appProfile) {
    [[HDControlManager sharedManager] replaceRootViewControllerWithTabController];
  }
  [self addObservers];
  [self manuallyLayoutSubviews];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self removeObservers];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - UITableView delegate

#pragma mark - UITableView datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [HDEvtCreateViewCell defaultHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_placeHolderArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *eventCellIdentifier = @"InputInfoCellIdentifier";
  HDEvtCreateViewCell *cell = (HDEvtCreateViewCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
  if (!cell) {
    cell = [[HDEvtCreateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
  }
  cell.cellTF.placeholder = [self.placeHolderArray objectAtIndex:indexPath.row];
  cell.cellTF.delegate = self;
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.infoTableView.frameWidth, 50)];
  containerView.backgroundColor = [UIColor clearColor];
  UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  createBtn.frame = CGRectMake(0, 20, self.infoTableView.frameWidth, 40);
  createBtn.backgroundColor = UIColorFromRGB(PRIM_GREEN_COLOR);
  [createBtn setTitle:@"Confirm" forState:UIControlStateNormal];
  [createBtn.titleLabel setFont:MediumHelNeueFontOfSize(15)];
  [createBtn setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
  [createBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
  [containerView addSubview:createBtn];
  [createBtn centerHorizontally];
  return containerView;
}

- (void)confirmAction:(id)sender {
  NSMutableArray *resultArray = [NSMutableArray array];
  for (int i = 0; i < [self.placeHolderArray count]; i++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    HDEvtCreateViewCell *cell = (HDEvtCreateViewCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
    NSString *result = cell.cellTF.text;
    [resultArray addObject:result];
  }
  
  HDProfile *profile = [[HDProfile alloc] initWithEmail:resultArray[0] withName:resultArray[1] withPassword:resultArray[2] withJob:resultArray[3] withLocation:resultArray[4] withOrg:resultArray[5] withFoodFlavor:resultArray[6]];
  [[ProfileManager sharedManager] setAppProfile:profile];
  [self.view endEditing:YES];
  // save it to user default
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:profile];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userProfile"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
  [[HDControlManager sharedManager] replaceRootViewControllerWithTabController];
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  _activeTF = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  _activeTF = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.foodTF) {
    [textField resignFirstResponder];
    return NO;
  }
  return YES;
}

#pragma mark - Private methods

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObservers {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardDidShow:(NSNotification*)notification {
  NSDictionary *info = [notification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
  self.scrollView.contentSize = CGSizeMake(self.scrollView.frameWidth, self.scrollView.frameHeight);
  
  //scroll if neccessary
  CGRect rect = self.view.frame;
  rect.size.height -= kbSize.height;
  if (!CGRectContainsPoint(rect, _activeTF.frame.origin)) {
    [self.scrollView scrollRectToVisible:_activeTF.frame animated:YES];
  }
}

- (void)keyboardWillHide:(NSNotification*)notification {
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
  self.scrollView.contentSize = CGSizeZero;
}

- (void)commonInit {
  _placeHolderArray = @[@"Email address", @"Name", @"Password", @"Job", @"Location", @"Organization", @"Food flavor"];
  _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _infoTableView.backgroundColor = [UIColor clearColor];
  _infoTableView.delegate = self;
  _infoTableView.dataSource = self;
  [self.view addSubview:_infoTableView];
  
  self.view.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  _scrollView = [[UIScrollView alloc] init];
  _scrollView.backgroundColor = [UIColor clearColor];
  
  _inputViewTitle = [[UILabel alloc] init];
  _inputViewTitle.textColor = [UIColor blackColor];
  _inputViewTitle.backgroundColor = [UIColor clearColor];
  _inputViewTitle.font = HelNeueFontOfSize(16);
  _inputViewTitle.textAlignment = NSTextAlignmentCenter;
  _inputViewTitle.text = @"Please Input your information";
  
  _emailTitle = [[UILabel alloc] init];
  _emailTitle.textColor = [UIColor blackColor];
  _emailTitle.backgroundColor = [UIColor clearColor];
  _emailTitle.font = HelNeueFontOfSize(16);
  _emailTitle.text = @"Email address:";
  
  _nameTitle = [[UILabel alloc] init];
  _nameTitle.textColor = [UIColor blackColor];
  _nameTitle.backgroundColor = [UIColor clearColor];
  _nameTitle.font = HelNeueFontOfSize(16);
  _nameTitle.text = @"Name:";
  
  _pwdTitle = [[UILabel alloc] init];
  _pwdTitle.textColor = [UIColor blackColor];
  _pwdTitle.backgroundColor = [UIColor clearColor];
  _pwdTitle.font = HelNeueFontOfSize(16);
  _pwdTitle.text = @"Password:";
  
  _jobTitle = [[UILabel alloc] init];
  _jobTitle.textColor = [UIColor blackColor];
  _jobTitle.backgroundColor = [UIColor clearColor];
  _jobTitle.font = HelNeueFontOfSize(16);
  _jobTitle.text = @"Job";
  
  _locationTitle = [[UILabel alloc] init];
  _locationTitle.textColor = [UIColor blackColor];
  _locationTitle.backgroundColor = [UIColor clearColor];
  _locationTitle.font = HelNeueFontOfSize(16);
  _locationTitle.text = @"Location:";
  
  _orgTitle = [[UILabel alloc] init];
  _orgTitle.textColor = [UIColor blackColor];
  _orgTitle.backgroundColor = [UIColor clearColor];
  _orgTitle.font = HelNeueFontOfSize(16);
  _orgTitle.text = @"Organization:";
  
  _foodTitle = [[UILabel alloc] init];
  _foodTitle.textColor = [UIColor blackColor];
  _foodTitle.backgroundColor = [UIColor clearColor];
  _foodTitle.font = HelNeueFontOfSize(16);
  _foodTitle.text = @"Food flavor:";
  
  _emailTF = [[UITextField alloc] init];
  _emailTF.textColor = [UIColor blackColor];
  _emailTF.font = HelNeueFontOfSize(16);
  _emailTF.delegate = self;
  _emailTF.backgroundColor = [UIColor clearColor];
  
  _nameTF = [[UITextField alloc] init];
  _nameTF.textColor = [UIColor blackColor];
  _nameTF.font = HelNeueFontOfSize(16);
  _nameTF.delegate = self;
  _nameTF.backgroundColor = [UIColor clearColor];
  
  _pwdTF = [[UITextField alloc] init];
  _pwdTF.textColor = [UIColor blackColor];
  _pwdTF.font = HelNeueFontOfSize(16);
  _pwdTF.delegate = self;
  _pwdTF.backgroundColor = [UIColor clearColor];
  
  _jobTF = [[UITextField alloc] init];
  _jobTF.textColor = [UIColor blackColor];
  _jobTF.font = HelNeueFontOfSize(16);
  _jobTF.delegate = self;
  _jobTF.backgroundColor = [UIColor clearColor];
  
  _locationTF = [[UITextField alloc] init];
  _locationTF.textColor = [UIColor blackColor];
  _locationTF.font = HelNeueFontOfSize(16);
  _locationTF.delegate = self;
  _locationTF.backgroundColor = [UIColor clearColor];
  
  _orgTF = [[UITextField alloc] init];
  _orgTF.textColor = [UIColor blackColor];
  _orgTF.font = HelNeueFontOfSize(16);
  _orgTF.delegate = self;
  _orgTF.backgroundColor = [UIColor clearColor];
  
  _foodTF = [[UITextField alloc] init];
  _foodTF.textColor = [UIColor blackColor];
  _foodTF.font = HelNeueFontOfSize(16);
  _foodTF.delegate = self;
  _foodTF.backgroundColor = [UIColor clearColor];
  
  _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
  [_confirmButton.titleLabel setFont:HelNeueFontOfSize(16)];
  [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [_confirmButton addTarget:self action:@selector(confirmButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  
  //[self.view addSubview:_scrollView];
  [_scrollView addSubview:_inputViewTitle];
  [_scrollView addSubview:_emailTitle];
  [_scrollView addSubview:_nameTitle];
  [_scrollView addSubview:_pwdTitle];
  [_scrollView addSubview:_jobTitle];
  [_scrollView addSubview:_locationTitle];
  [_scrollView addSubview:_orgTitle];
  [_scrollView addSubview:_foodTitle];
  [_scrollView addSubview:_emailTF];
  [_scrollView addSubview:_nameTF];
  [_scrollView addSubview:_pwdTF];
  [_scrollView addSubview:_jobTF];
  [_scrollView addSubview:_locationTF];
  [_scrollView addSubview:_orgTF];
  [_scrollView addSubview:_foodTF];
  [_scrollView addSubview:_confirmButton];
}

- (void)manuallyLayoutSubviews {
  _infoTableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(0, 10, 0, 10));
  _scrollView.frame = self.view.bounds;
  
  _inputViewTitle.frame = CGRectMake(kControlHorMargin, kControlVertMargin * 3, self.view.frameWidth - 2 * kControlHorMargin, 20);
  
  _emailTitle.frame = CGRectMake(kControlHorMargin, _inputViewTitle.frameBottomY + kControlVertMargin, 100, 40);
  _emailTF.frame = CGRectMake(_emailTitle.frameRightX + kControlHorMargin, _emailTitle.frameY, self.view.frameWidth - 3 * kControlHorMargin, 40);
  
  _nameTitle.frame = CGRectMake(kControlHorMargin, _emailTitle.frameBottomY + kControlVertMargin, 100, 40);
  _nameTF.frame = CGRectMake(_emailTitle.frameRightX + kControlHorMargin, _nameTitle.frameY, self.view.frameWidth - 3 * kControlHorMargin, 40);
  
  _pwdTitle.frame = CGRectMake(kControlHorMargin, _nameTitle.frameBottomY + kControlVertMargin, 100, 40);
  _pwdTF.frame = CGRectMake(_emailTitle.frameRightX + kControlHorMargin, _pwdTitle.frameY, self.view.frameWidth - 3 * kControlHorMargin, 40);
  
  _jobTitle.frame = CGRectMake(kControlHorMargin, _pwdTitle.frameBottomY + kControlVertMargin, 100, 40);
  _jobTF.frame = CGRectMake(_emailTitle.frameRightX + kControlHorMargin, _jobTitle.frameY, self.view.frameWidth - 3 * kControlHorMargin, 40);
  
  _locationTitle.frame = CGRectMake(kControlHorMargin, _jobTitle.frameBottomY + kControlVertMargin, 100, 40);
  _locationTF.frame = CGRectMake(_emailTitle.frameRightX + kControlHorMargin, _locationTitle.frameY, self.view.frameWidth - 3 * kControlHorMargin, 40);
  
  _orgTitle.frame = CGRectMake(kControlHorMargin, _locationTitle.frameBottomY + kControlVertMargin, 100, 40);
  _orgTF.frame = CGRectMake(_emailTitle.frameRightX + kControlHorMargin, _orgTitle.frameY, self.view.frameWidth - 3 * kControlHorMargin, 40);
  
  _foodTitle.frame = CGRectMake(kControlHorMargin, _orgTitle.frameBottomY + kControlVertMargin, 100, 40);
  _foodTF.frame = CGRectMake(_emailTitle.frameRightX + kControlHorMargin, _foodTitle.frameY, self.view.frameWidth - 3 * kControlHorMargin, 40);
  
  _confirmButton.frame = CGRectMake(kControlHorMargin, _foodTitle.frameBottomY + kControlVertMargin, self.view.frameWidth - 2 * kControlHorMargin, 45);
}

- (void)confirmButtonTapped:(id)sender {
  NSString *email = self.emailTF.text;
  NSString *name = self.nameTF.text;
  NSString *password = self.pwdTF.text;
  NSString *job = self.jobTF.text;
  NSString *location = self.locationTF.text;
  NSString *org = self.orgTF.text;
  NSString *food = self.foodTF.text;
  HDProfile *profile = [[HDProfile alloc] initWithEmail:email withName:name withPassword:password withJob:job withLocation:location withOrg:org withFoodFlavor:food];
  [[ProfileManager sharedManager] setAppProfile:profile];
  
  // save it to user default
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:profile];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userProfile"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
  [[HDControlManager sharedManager] replaceRootViewControllerWithTabController];

}

@end
