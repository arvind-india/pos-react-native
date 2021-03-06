/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"
#import <Pos/Pos.h>

#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

#import "SplashScreen.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

  //启动基本SDK
  [[PgyManager sharedPgyManager] startManagerWithAppId:@"6915c225020b6dd7ea231522740480e3"];
  //启动更新检查SDK
  [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"6915c225020b6dd7ea231522740480e3"];
  
  [[PgyUpdateManager sharedPgyManager] checkUpdate];
  
  
  NSString* path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                        NSUserDomainMask,
                                                        YES) objectAtIndex:0];
  P2PosInit(path);
  
  
//  NSString* result = P2PosCall(@"pp:///account/login?username=admin&password=123qwe");
//  NSLog(@"AppDelegate log: %@",result);
  
  NSURL *jsCodeLocation;

  
  #ifdef DEBUG
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  #else
    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"bundle/index.ios" withExtension:@"jsbundle"];
  #endif
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"pangpangPos"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  [SplashScreen show];
  return YES;
}

@end
