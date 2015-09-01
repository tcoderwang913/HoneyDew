//
//  HDEvtCreateViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/21/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtCreateViewController.h"
#import "HDEvtInviteFriendViewController.h"
#import "UIView+Position.h"
#import "EventManager.h"
#import "HDEvtCreateViewCell.h"
#import "HDEvtCreateViewIsPublicCell.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"

static const CGFloat kVerticalMargin = 20;
static const CGFloat kLabelHeight = 40;
static const CGFloat kControlHeight = 45;
static const CGFloat kHorizontalMargin = 10;

#define kOFFSET_FOR_KEYBOARD  80.0

@interface HDEvtCreateViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITextField *currentTextField;

@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) UILabel *eventNameLabel;
@property (nonatomic) UITextField *eventNameTF;

@property (nonatomic) UILabel *eventDateTimeLabel;
@property (nonatomic) UITextField *eventDateTimeTF;
@property (nonatomic) UIDatePicker *eventDateTimePicker;

@property (nonatomic) UILabel *eventPartySizeLabel;
@property (nonatomic) UITextField *eventPartySizeTF;
@property (nonatomic) UIPickerView *eventPartySizePickerView;

@property (nonatomic) UILabel *eventPublicSwitchLabel;
@property (nonatomic) UISwitch *isPubSwitch;

@property (nonatomic) UIButton *inviteFriendButton;

@property (nonatomic) NSArray *partySizeArray;


@property (nonatomic) NSDate *selectedDate;
@property (nonatomic) NSInteger selectedSize;

@property (nonatomic) UITableView *evtTableView;
@property (nonatomic) NSArray *evtPlaceHolderArray;
@end

@implementation HDEvtCreateViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self manuallyLayoutSubviews];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"Create Event";
  
  //[self addSubViews];
  [self addNotifications];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableView delegate

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return [self.evtPlaceHolderArray count];
  }
  else return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    static NSString *eventCellIdentifier = @"CreateEventCellIdentifier";
    HDEvtCreateViewCell *cell = (HDEvtCreateViewCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
    if (!cell) {
      cell = [[HDEvtCreateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
    }
    cell.cellTF.placeholder = [self.evtPlaceHolderArray objectAtIndex:indexPath.row];
    cell.cellTF.delegate = self;
    if (indexPath.row == 1) {
      cell.cellTF.inputView = self.eventDateTimePicker;
    } else if (indexPath.row == 2) {
      cell.cellTF.inputView = self.eventPartySizePickerView;
    } else {
      cell.cellTF.inputView = nil;
    }
    return cell;
  } else {
    static NSString *eventCellPublicIdentifier = @"CreateEventCellPublicIdentifier";
    HDEvtCreateViewIsPublicCell *cell = (HDEvtCreateViewIsPublicCell*)[tableView dequeueReusableCellWithIdentifier:eventCellPublicIdentifier];
    if (!cell) {
      cell = [[HDEvtCreateViewIsPublicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellPublicIdentifier];
    }
    cell.cellTitle.text = @"Is this a public event?";
    return cell;
  }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  if (section == 1) {
    return 60;
  } else {
    return 0;
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  if (section == 1) {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.evtTableView.frameWidth, 50)];
    containerView.backgroundColor = [UIColor clearColor];
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = CGRectMake(0, 20, self.evtTableView.frameWidth, 40);
    createBtn.backgroundColor = UIColorFromRGB(PRIM_GREEN_COLOR);
    [createBtn setTitle:@"Create event and Invite friends" forState:UIControlStateNormal];
    [createBtn.titleLabel setFont:MediumHelNeueFontOfSize(15)];
    [createBtn setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createAndInvite:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:createBtn];
    [createBtn centerHorizontally];
    return containerView;
  } else {
    return nil;
  }
}

- (void)createAndInvite:(id)sender {
//  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//  NSString *evtName = ((HDEvtCreateViewCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellTF.text;
//  indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//  NSString *evtDT = ((HDEvtCreateViewCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellTF.text;
//  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
//  NSString *evtSize = ((HDEvtCreateViewCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellTF.text;
//  indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//  BOOL isPublic = ((HDEvtCreateViewIsPublicCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellIsPublicSwitch.isOn;
//  
//  if ([evtName isEqualToString:@""] || [evtDT isEqualToString:@""] || [evtSize isEqualToString:@""]) {
//    return;
//  }
//  
//  // create event
//  
//  Event *newEvent = [[Event alloc] initEventWithTitle:evtName andEventDetail:@"no detail" andDateTime:self.selectedDate andPartySize:self.selectedSize andIsPublicEvent:isPublic];
//  [[EventManager sharedManager] addEvent:newEvent];
  
  HDEvtInviteFriendViewController *hdEvtInviteFriendViewController = [[HDEvtInviteFriendViewController alloc] init];
  [self.navigationController pushViewController:hdEvtInviteFriendViewController animated:YES];
}

#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [self.partySizeArray count];;
}

#pragma mark - UIPickerView delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSInteger selectedRow = [pickerView selectedRowInComponent:component];
  NSString *selectedPickerRow = [self.partySizeArray objectAtIndex:selectedRow];
  self.currentTextField.text = selectedPickerRow;
  self.selectedSize = row + 1;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return (NSString*)[self.partySizeArray objectAtIndex:row];
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  self.currentTextField = textField;
}


#pragma mark - Private methods

- (void)addSubViews {
  [self.view addSubview:_scrollView];
  [_scrollView addSubview:_eventNameLabel];
  [_scrollView addSubview:_eventNameTF];
  [_scrollView addSubview:_eventDateTimeLabel];
  [_scrollView addSubview:_eventDateTimeTF];
  [_scrollView addSubview:_eventPartySizeLabel];
  [_scrollView addSubview:_eventPartySizeTF];
  [_scrollView addSubview:_eventPublicSwitchLabel];
  [_scrollView addSubview:_isPubSwitch];
  [_scrollView addSubview:_inviteFriendButton];
}

- (void)addNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)commonInit {
  self.view.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  
  _evtTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _evtTableView.delegate = self;
  _evtTableView.dataSource = self;
  _evtTableView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_evtTableView];
  
  _evtPlaceHolderArray = @[@"Event name:", @"Event time:", @"Party size"];
  
  _scrollView = [[UIScrollView alloc] init];
  
  _eventNameLabel = [[UILabel alloc] init];
  _eventNameLabel.text = @"Event name:";
  _eventNameLabel.backgroundColor = [UIColor clearColor];
  _eventNameLabel.textColor = [UIColor blackColor];
  _eventNameLabel.font = HelNeueFontOfSize(18);
  _eventNameTF = [[UITextField alloc] init];
  _eventNameTF.borderStyle = UITextBorderStyleLine;
  
  _eventDateTimeLabel = [[UILabel alloc] init];
  _eventDateTimeLabel.text = @"Event time:";
  _eventDateTimeLabel.backgroundColor = [UIColor clearColor];
  _eventDateTimeLabel.textColor = [UIColor blackColor];
  _eventDateTimePicker = [[UIDatePicker alloc] init];
  [_eventDateTimePicker setDatePickerMode:UIDatePickerModeDateAndTime];
  [_eventDateTimePicker addTarget:self action:@selector(updateDateTimeTF:) forControlEvents:UIControlEventValueChanged];
  _eventDateTimeTF = [[UITextField alloc] init];
  _eventDateTimeTF.borderStyle = UITextBorderStyleLine;
  _eventDateTimeTF.delegate = self;
  _eventDateTimeTF.inputView = _eventDateTimePicker;
  
  _eventPartySizeLabel = [[UILabel alloc] init];
  _eventPartySizeLabel.text = @"Party size:";
  _eventPartySizeLabel.backgroundColor = [UIColor clearColor];
  _eventPartySizeLabel.textColor = [UIColor blackColor];
  _eventPartySizePickerView = [[UIPickerView alloc] init];
  _eventPartySizePickerView.dataSource = self;
  _eventPartySizePickerView.delegate = self;
  _eventPartySizePickerView.showsSelectionIndicator = YES;
  _eventPartySizeTF = [[UITextField alloc] init];
  _eventPartySizeTF.borderStyle = UITextBorderStyleLine;
  _eventPartySizeTF.inputView = _eventPartySizePickerView;
  
  _eventPublicSwitchLabel = [[UILabel alloc] init];
  _eventPublicSwitchLabel.text = @"Is this Public Event?";
  _eventPublicSwitchLabel.backgroundColor = [UIColor clearColor];
  _eventPublicSwitchLabel.textColor = [UIColor blackColor];
  _isPubSwitch = [[UISwitch alloc] init];
  
  _inviteFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _inviteFriendButton.layer.borderColor = [UIColor blueColor].CGColor;
  _inviteFriendButton.layer.borderWidth = 1.0;
  [_inviteFriendButton setTitle:@"Create Event and Invite Friends" forState:UIControlStateNormal];
  [_inviteFriendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [_inviteFriendButton addTarget:self action:@selector(inviteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  
  _partySizeArray = @[@"just myself", @"you and me", @"three guys", @"four brothers", @"five dudes", @"more than six"];
}

- (void)manuallyLayoutSubviews {
  _evtTableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(10, 10, 10, 10));
  
  _scrollView.frame = self.view.bounds;
  
  _eventNameLabel.frame = CGRectMake(kHorizontalMargin, kVerticalMargin, self.view.frameWidth - 2 * kHorizontalMargin, kLabelHeight);
  _eventNameTF.frame = CGRectMake(kHorizontalMargin, _eventNameLabel.frameBottomY, _eventNameLabel.frameWidth, kControlHeight);
  
  _eventDateTimeLabel.frame = CGRectMake(kHorizontalMargin, _eventNameTF.frameBottomY, _eventNameLabel.frameWidth, kLabelHeight);
  _eventDateTimeTF.frame = CGRectMake(kHorizontalMargin, _eventDateTimeLabel.frameBottomY, _eventNameLabel.frameWidth, kControlHeight);
  
  _eventPartySizeLabel.frame = CGRectMake(kHorizontalMargin, _eventDateTimeTF.frameBottomY, _eventNameLabel.frameWidth, kLabelHeight);
  _eventPartySizeTF.frame = CGRectMake(kHorizontalMargin, _eventPartySizeLabel.frameBottomY, _eventNameLabel.frameWidth, kControlHeight);
  
  _eventPublicSwitchLabel.frame = CGRectMake(kHorizontalMargin, _eventPartySizeTF.frameBottomY, _eventNameLabel.frameWidth, kLabelHeight);
  _isPubSwitch.frame = CGRectMake(kHorizontalMargin, _eventPublicSwitchLabel.frameBottomY, _eventNameLabel.frameWidth * 0.5, kControlHeight);
  
  _inviteFriendButton.frame = CGRectMake(kHorizontalMargin, _isPubSwitch.frameBottomY + kControlHeight, _eventNameLabel.frameWidth, kControlHeight);
}

- (void)updateDateTimeTF:(id)sender {
  
  UIDatePicker *picker = (UIDatePicker*)self.eventDateTimeTF.inputView;
  self.currentTextField.text = [self formatDate: picker.date];
  self.selectedDate = picker.date;
}

- (NSString*)formatDate:(NSDate*)date {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterShortStyle];
  [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
  NSString *formattedDateTime = [dateFormatter stringFromDate:date];
  return formattedDateTime;
}

#pragma mark - Keyboard notification

- (void)keyboardWillShow:(NSNotification *)n {

}

- (void)keyboardWillHide:(NSNotification *)n {

}
@end
