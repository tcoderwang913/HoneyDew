//
//  RsrtDishViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/3/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "RsrtDishViewController.h"
#import "DishTableViewCell.h"

@interface RsrtDishViewController ()
@property (nonatomic) UITableView *dishesTableView;
@end

@implementation RsrtDishViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self manuallyLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 10;
}

- (void)commonInit {
  _dishesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  _dishesTableView.dataSource = self;
  _dishesTableView.delegate = self;
  _dishesTableView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_dishesTableView];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *detailCellIdentifier = @"DetailCellIdentifier";
  DishTableViewCell *cell = (DishTableViewCell*)[tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
  if (cell == nil) {
    cell = [[DishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
  }
  // TODO: fill cell content
  return cell;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (void)manuallyLayoutSubviews {
  self.dishesTableView.frame = self.view.bounds;
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
