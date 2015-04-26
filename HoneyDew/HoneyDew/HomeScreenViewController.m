//
//  HomeScreenViewController.m
//  HoneyDew
//
//  Created by Song Wang on 3/31/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HomeScreenViewController.h"

static const CGFloat kImageSize = 80;
static const CGFloat kHorizontalMargin = 10;
static const CGFloat kVerticalMargin = 10;
static const CGFloat kLabelHeight = 40;

@interface HomeScreenViewController ()

@property (nonatomic, strong) UILabel *topYelpRatedLabel;
@property (nonatomic, strong) UILabel *bloggerLabel;
@property (nonatomic, strong) UILabel *diningDealsLabel;

@end

@implementation HomeScreenViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  if (self) {
    UIView *homeScreenView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    homeScreenView.backgroundColor = [UIColor whiteColor];
    self.title = @"Home";
    self.tabBarItem.image = [UIImage imageNamed:@"Home-25"];
    self.view = homeScreenView;
    
    [homeScreenView addSubview:self.topYelpRatedLabel];
    [homeScreenView addSubview:self.bloggerLabel];
    [homeScreenView addSubview:self.diningDealsLabel];
  
  }
  return  self;
}


- (UILabel*)topYelpRatedLabel
{
  if (_topYelpRatedLabel == nil)
  {
    _topYelpRatedLabel = [[UILabel alloc] initWithFrame: CGRectMake(kHorizontalMargin, kVerticalMargin + 44, self.view.bounds.size.width, kLabelHeight)];
    _topYelpRatedLabel.textAlignment = NSTextAlignmentCenter;
    _topYelpRatedLabel.backgroundColor = [UIColor clearColor];
    _topYelpRatedLabel.textColor = [UIColor colorWithRed:0 green:0.2 blue:0.8 alpha:1.0];
    _topYelpRatedLabel.numberOfLines = 1;
    _topYelpRatedLabel.text = @"Top Yelp Rated";
    _topYelpRatedLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"  size:14];
  }
  return _topYelpRatedLabel;
}

- (UILabel *)bloggerLabel
{
  if (_bloggerLabel == nil) {
    _bloggerLabel = [[UILabel alloc] initWithFrame:CGRectMake(kHorizontalMargin, self.topYelpRatedLabel.frame.origin.y + self.topYelpRatedLabel.frame.size.height + kVerticalMargin + kImageSize, self.view.bounds.size.width, kLabelHeight)];
    _bloggerLabel.textAlignment = NSTextAlignmentCenter;
    _bloggerLabel.backgroundColor = [UIColor clearColor];
    _bloggerLabel.textColor = [UIColor colorWithRed:0 green:0.2 blue:0.8 alpha:1.0];
    _bloggerLabel.numberOfLines = 1;
    _bloggerLabel.text = @"Blogger Food";
    _bloggerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"  size:14];
  }
  return _bloggerLabel;
}

- (UILabel *)diningDealsLabel
{
  if (_diningDealsLabel == nil) {
    _diningDealsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kHorizontalMargin, self.bloggerLabel.frame.origin.y + self.bloggerLabel.frame.size.height + kVerticalMargin + kImageSize, self.view.bounds.size.width, kLabelHeight)];
    _diningDealsLabel.textAlignment = NSTextAlignmentCenter;
    _diningDealsLabel.backgroundColor = [UIColor clearColor];
    _diningDealsLabel.textColor = [UIColor colorWithRed:0 green:0.2 blue:0.8 alpha:1.0];
    _diningDealsLabel.numberOfLines = 1;
    _diningDealsLabel.text = @"Dining Deals";
    _diningDealsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"  size:14];
  }
  return _diningDealsLabel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
