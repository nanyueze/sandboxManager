//
//  NANAppDelegate.m
//  NANSandboxManager
//
//  Created by nanyueze on 04/16/2018.
//  Copyright (c) 2018 nanyueze. All rights reserved.
//

#import "NANAppDelegate.h"
#import <NANSandboxManager/NANSandboxManagerHeader.h>

@implementation NANAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NANSandboxManager showSandboxEntranceWithOffset:CGPointMake(60, 0)];
    return YES;
}

@end
