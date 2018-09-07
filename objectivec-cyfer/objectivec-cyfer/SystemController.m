//
//  SystemController.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 8/26/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemController.h"

@implementation SystemController

- (void) runScript: (NSString*)source {
    NSAppleScript *script= [[NSAppleScript alloc] initWithSource:source];
    NSDictionary *scriptError = nil;
    [script executeAndReturnError:&scriptError];
}

- (void) forceQuitApp: (NSString*)appName {
    NSString * source = [NSString stringWithFormat:@"tell application \"%@\" to quit", appName];
    [self runScript:source];
    NSLog(@"%@ has successfully quit.", appName);
}

- (void) forceActivateApp: (NSString*)appName {
    NSString * source = [NSString stringWithFormat:@"tell application \"%@\" to activate", appName];
    [self runScript:source];
    NSLog(@"%@ has successfully been activated.", appName);
}

// ToDo - Implement this for Safari
- (void) forceCloseTab: (NSString*)appName andUrl: (NSString*)url {
    NSString * source = [NSString stringWithFormat:
              @"tell application \"%@\"\n"
                "set windowList to every tab of every window whose URL starts with \"%@\"\n"
                "repeat with tabList in windowList\n"
                    "set tabList to tabList as any\n"
                    "repeat with tabItr in tabList\n"
                        "set tabItr to tabItr as any\n"
                        "delete tabItr\n"
                    "end repeat\n"
                "end repeat\n"
              "end tell\n", appName, url];
    [self runScript:source];
    NSLog(@"Tab has been closed.");
}

- (void) forceOpenTab: (NSString*)appName andCompleteUrl: (NSString*)url {
    
}

- (void) pushNotification: (NSString*)notification andTitle:(NSString*)title andSubTitle:(NSString*)subtitle   {
    
    NSString* source = [NSString stringWithFormat:@"tell application \"Xcode\" to display notification \"Encoding complete\" subtitle \"The encoded files are in the folder\""];
    [self runScript:source];
}
// ToDo - Research the different apple scripts we can use 

@end
