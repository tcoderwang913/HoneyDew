//
//  AppDelegate.m
//  HoneyDew
//
//  Created by Song Wang on 4/14/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeScreenViewController.h"
#import "InvitationViewController.h"
#import "SettingsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
  
  ViewController *vc = [[ViewController alloc ] initWithNibName:nil bundle:nil];
  self.window.rootViewController = vc;
  
  [FBSDKProfilePictureView class];
  
  return [[FBSDKApplicationDelegate sharedInstance] application:application
                           didFinishLaunchingWithOptions:launchOptions];
  
//    self.tabBarController = [[UITabBarController alloc]  init];
//  
//    HomeScreenViewController *homeScreenVC = [[HomeScreenViewController alloc] init];
//    InvitationViewController *invitationVC = [[InvitationViewController alloc]  init];
//    SettingsViewController *settingVC = [[SettingsViewController alloc] init];
//  
//    [[UITabBarItem appearance] setTitleTextAttributes:@{
//                                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f],
//                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:0/255.0 green:48/255.0 blue:92/255.0 alpha:1.0],}
//                                             forState:UIControlStateNormal];
//  
//    [[UITabBarItem appearance] setTitleTextAttributes:@{
//                                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f],
//                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:0/255.0 green:138/255.0 blue:196/255.0 alpha:1.0],}
//                                             forState:UIControlStateSelected];
//  
//    self.tabBarController.viewControllers = @[homeScreenVC, invitationVC,settingVC];
//    self.window.rootViewController = self.tabBarController;
//  return YES;
  
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
  [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                        openURL:url
                                              sourceApplication:sourceApplication
                                                     annotation:annotation];
}

@end
