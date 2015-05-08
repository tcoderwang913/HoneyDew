//
//  HomeBloggerDetailViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 5/5/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HomeBloggerDetailViewController.h"

const static CGFloat kBorderLRMargin = 10;
const static CGFloat kRatingStarMargin = 5;
const static CGFloat kBorderTopMargin = 20;

@interface HomeBloggerDetailViewController ()
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *ratingReviewBgView;
@property (nonatomic, strong) NSMutableArray *ratingStarArray;
@property (nonatomic, strong) UILabel *ratingReviewLabel;
@property (nonatomic, strong) UILabel *rstrtNameLabel;
@property (nonatomic, strong) UILabel *rstrtSummaryLabel;
@property (nonatomic, strong) UILabel *openHourLabel;
@end

@implementation HomeBloggerDetailViewController

- (id)init {
  if (self = [super init]) {
    [self createUI];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self updateUIWithData];
  [self manuallyLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - private methods
- (void)createUI {
  _mainScrollView = [[UIScrollView alloc] init];
  _mainScrollView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
  
  _rstrtNameLabel = [[UILabel alloc] init];
  _rstrtNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"  size:25];
  _rstrtNameLabel.textColor = [UIColor colorWithRed:0 green:0.2 blue:0.8 alpha:1.0];
  _rstrtNameLabel.backgroundColor = [UIColor clearColor];
  _rstrtSummaryLabel = [[UILabel alloc] init];
  _rstrtSummaryLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"  size:20];
  _rstrtSummaryLabel.textColor = [UIColor blackColor];
  _rstrtSummaryLabel.backgroundColor = [UIColor clearColor];
  _ratingReviewBgView = [[UIView alloc] init];
  _ratingReviewBgView.backgroundColor = [UIColor clearColor];
  if (!_ratingStarArray) _ratingStarArray = [NSMutableArray array];
  for (int i = 0; i < 5; i++) {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rating_0.png"]];
    [_ratingStarArray addObject:imageView];
    [_ratingReviewBgView addSubview:imageView];
  }
  _ratingReviewLabel = [[UILabel alloc] init];
  _ratingReviewLabel.textColor = [UIColor blackColor];
  _ratingReviewLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:15];
  [_ratingReviewBgView addSubview:_ratingReviewLabel];
  
  _openHourLabel = [[UILabel alloc] init];
  _openHourLabel.textColor = [UIColor blackColor];
  _openHourLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:15];
  
  [self.view addSubview:_mainScrollView];
  [_mainScrollView addSubview:_rstrtNameLabel];
  [_mainScrollView addSubview:_rstrtSummaryLabel];
  [_mainScrollView addSubview:_ratingReviewBgView];
  [_mainScrollView addSubview:_openHourLabel];
}

- (void)updateUIWithData {
  self.rstrtNameLabel.text = @"Saigon Seafood Harbor Restaurant";
  self.rstrtSummaryLabel.text = @"Seafood, Dim Sum";
  int reviewCount = 1196;
  self.ratingReviewLabel.text = [NSString stringWithFormat:@"%d Reviews", reviewCount];
  self.openHourLabel.text = @"Hours Today: 11:00 AM - 3:00 PM";
}

- (void)manuallyLayoutSubviews {
  self.mainScrollView.frame = self.view.bounds;
  self.rstrtNameLabel.frame = CGRectMake(kBorderLRMargin, kBorderTopMargin, self.view.frame.size.width - kBorderLRMargin * 2, self.rstrtNameLabel.font.lineHeight + 2);
  self.rstrtSummaryLabel.frame = CGRectMake(kBorderLRMargin, kBorderTopMargin + self.rstrtNameLabel.frame.size.height + kBorderLRMargin, self.view.frame.size.width - kBorderLRMargin * 2, self.rstrtSummaryLabel.font.lineHeight + 2);
 
  self.ratingReviewBgView.frame = CGRectMake(kBorderLRMargin, self.rstrtSummaryLabel.frame.origin.y + self.rstrtSummaryLabel.frame.size.height + kBorderLRMargin, self.rstrtSummaryLabel.frame.size.width, 30);
  UIImageView *imgView;
  for (int i = 0; i < 5; i++) {
    imgView = (UIImageView *)[self.ratingStarArray objectAtIndex:i];
    imgView.image = [UIImage imageNamed:@"rating_1.png"];
    imgView.frame = CGRectMake(i * (25 + kRatingStarMargin), 2, 25, 25);
  }
  self.ratingReviewLabel.frame = CGRectMake(imgView.frame.origin.x + imgView.frame.size.width + kBorderLRMargin, 5, 100, 20);
  self.openHourLabel.frame = CGRectMake(kBorderLRMargin, self.ratingReviewBgView.frame.origin.y + self.ratingReviewBgView.frame.size.height + kBorderLRMargin, self.view.frame.size.width - kBorderLRMargin * 2, self.openHourLabel.font.lineHeight + 2);
}

@end