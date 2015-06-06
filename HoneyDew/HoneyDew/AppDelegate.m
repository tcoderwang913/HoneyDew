//
//  AppDelegate.m
//  HoneyDew
//
//  Created by Song Wang on 4/14/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

//FB login code from :http://www.appcoda.com/ios-programming-facebook-login-sdk/

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeScreenViewController.h"
#import "PublicEventsViewController.h"
#import "SettingsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
//  [FBLoginView class];
//  [FBProfilePictureView class];
  
//  return YES;
  
  ViewController *vc = [[ViewController alloc ] initWithNibName:nil bundle:nil];
  self.window.rootViewController = vc;
    self.tabBarController = [[UITabBarController alloc]  init];

  HomeScreenViewController *homeScreenVC = [[HomeScreenViewController alloc] init];
  UINavigationController *homeScreenNavigationController = [[UINavigationController alloc] initWithRootViewController:homeScreenVC];
  
  
  
  PublicEventsViewController *publicVC = [[PublicEventsViewController alloc]  init];
  UINavigationController *publicScreenNavigationController = [[UINavigationController alloc] initWithRootViewController:publicVC];
  
  SettingsViewController *settingVC = [[SettingsViewController alloc] init];
  UINavigationController *settingScreenNavigationController = [[UINavigationController alloc] initWithRootViewController:settingVC];
  
  
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f],
                                                      NSForegroundColorAttributeName : [UIColor colorWithRed:0/255.0 green:48/255.0 blue:92/255.0 alpha:1.0],}
                                           forState:UIControlStateNormal];

  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f],
                                                      NSForegroundColorAttributeName : [UIColor colorWithRed:0/255.0 green:138/255.0 blue:196/255.0 alpha:1.0],}
                                           forState:UIControlStateSelected];

  self.tabBarController.viewControllers = @[homeScreenNavigationController, publicScreenNavigationController,settingScreenNavigationController];
  self.window.rootViewController = self.tabBarController;
  

  return YES;
  
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
  
  return [FBAppCall handleOpenURL:url
                sourceApplication:sourceApplication];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
