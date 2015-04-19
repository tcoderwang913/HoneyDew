//
//  HomeScreenViewController.m
//  HoneyDew
//
//  Created by Song Wang on 3/31/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "RestauranteCollectionViewController.h"
@interface HomeScreenViewController ()

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
    
    RestauranteCollectionViewController *restauranteVC = [[RestauranteCollectionViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:restauranteVC.view];
    [self addChildViewController:restauranteVC];
  }
  return  self;
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
