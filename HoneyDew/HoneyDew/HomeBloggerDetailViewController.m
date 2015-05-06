//
//  HomeBloggerDetailViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 5/5/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HomeBloggerDetailViewController.h"

@interface HomeBloggerDetailViewController ()

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)createUI {
  
}

@end
