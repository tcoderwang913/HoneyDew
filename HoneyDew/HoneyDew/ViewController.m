//
//  ViewController.m
//  HoneyDew
//
//  Created by Song Wang on 4/14/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];
  
  FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
  loginButton.center = self.view.center;
  [self.view addSubview:loginButton];
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
