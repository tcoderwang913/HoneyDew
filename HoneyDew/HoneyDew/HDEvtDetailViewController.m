//
//  HDEvtDetailViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/24/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtDetailViewController.h"
#import "UIView+Position.h"
#import "iOSMacro.h"

static const CGFloat kVerticalMargin = 20;
static const CGFloat kLabelHeight = 40;
static const CGFloat kControlHeight = 45;
static const CGFloat kHorizontalMargin = 10;

@interface HDEvtDetailViewController ()

@property (nonatomic) UILabel *eventName;
@property (nonatomic) UILabel *eventContent;

@property (nonatomic) UILabel *eventDateTime;
@property (nonatomic) UILabel *eventPartySize;

@property (nonatomic) Event *event;
@end

@implementation HDEvtDetailViewController

- (id)initWithEvent:(Event *)event {
  if (self = [super init]) {
    _event = event;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)commonInit {
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"Event Detail";
  
  _eventName = [[UILabel alloc] init];
  _eventName.textColor = [UIColor blackColor];
  _eventContent = [[UILabel alloc] init];
  _eventContent.textColor = [UIColor blackColor];
  _eventDateTime = [[UILabel alloc] init];
  _eventDateTime.textColor = [UIColor blackColor];
  _eventPartySize = [[UILabel alloc] init];
  _eventPartySize.textColor = [UIColor blackColor];
  
  [self.view addSubview:_eventName];
  [self.view addSubview:_eventContent];
  [self.view addSubview:_eventDateTime];
  [self.view addSubview:_eventPartySize];
}

- (void)manuallyLayoutSubviews {
  _eventName.frame = CGRectMake(kHorizontalMargin, kVerticalMargin + 60, self.view.frameWidth - 2 * kHorizontalMargin, kLabelHeight);
  _eventContent.frame = CGRectMake(kHorizontalMargin, _eventName.frameBottomY, _eventName.frameWidth, kControlHeight);
  _eventDateTime.frame = CGRectMake(kHorizontalMargin, _eventContent.frameBottomY, _eventName.frameWidth, kControlHeight);
  _eventPartySize.frame = CGRectMake(kHorizontalMargin, _eventDateTime.frameBottomY, _eventName.frameWidth, kControlHeight);
  
  _eventName.text = @"Event Name:";
  _eventContent.text = [self.event eventTitle];
  _eventPartySize.text = [NSString stringWithFormat:@"%ld", self.event.eventPartySize];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
  _eventDateTime.text = [formatter stringFromDate:self.event.eventDateTime];
}

@end
