//
//  AppDelegate.m
//  AbstractClock
//
//  Created by curos on 2/12/13.
//  Copyright (c) 2013 curos. All rights reserved.
//

#import "Project.h"
#import "AppDelegate.h"

#import "MainViewController.h"

#import "Constants.h"



@implementation AppDelegate

static NSString* const oFIRST_RUN = @"FirstRun" ;



+(void) initialize
{
    NSUserDefaults* oUserDef = [ NSUserDefaults standardUserDefaults ] ;
    if( nil != [oUserDef objectForKey:oFIRST_RUN] )
        return ;
    
    [ oUserDef setObject:[NSDate date] forKey:oFIRST_RUN] ;
    [ oUserDef synchronize ] ;
    
    NSDictionary* oDic =
    @{
        CLOCK_OPTION_SHAPE: @(iCLOCK_SHAPE_SQURE),
        CLOCK_OPTION_24HOUR: @NO,
        CLOCK_OPTION_DATE_DISPLAY: @NO,
        CLOCK_OPTION_AUTOLOCK: @NO
    };
    [ oUserDef registerDefaults:oDic ] ;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect bounds = [ UIScreen mainScreen ].bounds ;
    TakeScreenSize( &bounds.size ) ;
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    // Override point for customization after application launch.
    self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    
    BOOL autolockOn = [ [NSUserDefaults standardUserDefaults] boolForKey:CLOCK_OPTION_AUTOLOCK ] ;
    [ UIApplication sharedApplication ].idleTimerDisabled = NO==autolockOn ;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
