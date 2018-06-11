//
//  AppDelegate.m
//  FEJSFixDemo
//
//  Created by FlyElephant on 2018/6/11.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import "AppDelegate.h"
#import "Aspects.h"
#import "FixUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self testAspects];
//    [self fixBug];
    [self fixBeforeMethod];
    return YES;
}

- (void)testAspects {
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        NSLog(@"AspectPositionBefore View Controller %@ will appear animated: %tu", aspectInfo.instance, animated);
    } error:NULL];
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        NSLog(@"AspectPositionAfter View Controller %@ will appear animated: %tu", aspectInfo.instance, animated);
    } error:NULL];
}

- (void)fixBug {
    [FixUtil fix];
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"fixMethod" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [FixUtil runJavaScript:jsString];
}

- (void)fixBeforeMethod {
    [FixUtil fix];
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"runBeforeInstanceMethod" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [FixUtil runJavaScript:jsString];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
