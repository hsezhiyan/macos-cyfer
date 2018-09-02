//
//  possibleFixes.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/5/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 TODO!!! Using notification system. Does not currently work.
 
 [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self,
 selector:@selector(appActivated:),
 name:NSWorkspaceDidActivateApplicationNotification,
 object:nil];
 
 void appActivated:(NSNotification*) notification {
 NSRunningApplication* currentApp = [notification.userInfo valueForKey:NSWorkspaceApplicationKey];
 NSLog(@"Frontmost application: %@\n", currentApp);
 }
 
 NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
 target:self
 selector:@selector(frontmostApplication)
 userInfo:nil
 repeats:YES];
*/
