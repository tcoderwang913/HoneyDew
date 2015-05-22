//
//  BloggerMapViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 5/21/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "BloggerMapViewController.h"
#import <MapKit/MapKit.h>

@interface BloggerMapViewController ()
@property (nonatomic) MKMapView *mapView;
@end

@implementation BloggerMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:_mapView];
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
