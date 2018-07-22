//
//  collectionMethods.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/5/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>
#import "collectionMethods.h"
#import "timerMethods.h"
#import "dataStruct.h"

NSString* previousApp = nil;
NSString* currentApp = nil;
timerMethods *timerMethod = nil;
dataStruct *dataDict = nil;
CFTimeInterval startTime;
CFTimeInterval endTime;
CFTimeInterval previousElapsedTime;

@implementation collectionMethods

+ (void) initialize {
    if(!timerMethod) {
        timerMethod = [[timerMethods alloc] init];
    }
    if(!dataDict) {
        dataDict = [[dataStruct alloc] init];
    }
    if (!startTime) {
        startTime = [timerMethod getCurrentTime];
    }
    if (!endTime) {
        endTime = [timerMethod getCurrentTime];
    }
}

- (id) init {
    if ((self = [super init])) {
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                               selector:@selector(appDidDeactivate:)
                                                                   name:NSWorkspaceDidDeactivateApplicationNotification
                                                                 object:nil];
        
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                               selector:@selector(appDidActivate:)
                                                                   name:NSWorkspaceDidActivateApplicationNotification
                                                                 object:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:15.0f target:self
                                                    selector:@selector(polling:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    return self;
}

- (void) dealloc {
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
    //[super dealloc];
}

/*
 If a new application is closed (removed from forefront), this method is called.
 */
- (void) appDidDeactivate:(NSNotification *)notification {
    
    endTime = [timerMethod getCurrentTime];
    CFTimeInterval elapsedTime = [timerMethod getElapsedTime: startTime andTime2:endTime];
    startTime = endTime;

    NSDictionary *userInfo = [notification userInfo];
    NSString* processedInfo = [dataDict preprocessing: userInfo];
    previousApp = processedInfo;
    
    if (![[dataDict timerDict] objectForKey:processedInfo]) {
        [[dataDict timerDict] setObject:[NSNumber numberWithFloat:elapsedTime] forKey:processedInfo];
    } else {
        NSNumber* previousElapsedTime = [[dataDict timerDict] valueForKey:processedInfo];
        double previousTime = [previousElapsedTime doubleValue];
        CFTimeInterval newElapsedTime = previousTime + elapsedTime;
        [[dataDict timerDict] setObject:[NSNumber numberWithFloat:newElapsedTime] forKey:processedInfo];
    }
    
    NSLog(@"Dictionary: %@", [[dataDict timerDict] description]);
    
}

/*
 If a new application is activated, this method is called.
 */
- (void) appDidActivate:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSString* processedInfo = [dataDict preprocessing: userInfo];
    currentApp = processedInfo;
    
    NSLog(@"Current application running: %@", currentApp);
    
}

/*
 Used for continuous polling. Every couple of seconds (tba), we'll look at the front most application.
 */
- (void) polling:(NSNotification *)notification {
    //NSLog(@"Poll Reached");
}

/*
 (Supposed to) return the frontmost application. Currently does not get updated after first application.
 */
- (NSRunningApplication*) frontmostApplication {
    return [NSWorkspace sharedWorkspace].frontmostApplication;
}

/*
 The following function returns a mutable array (an array without a fixed size) containing paths to all running applications.
 TODO: Processing of this data (we only want applications from the applications folder)
 */
- (NSMutableArray*) allRunningApplications {
    NSMutableArray *applications = [NSMutableArray array];
    for (NSRunningApplication *app in
         [[NSWorkspace sharedWorkspace] runningApplications]) {
        [applications addObject: [NSString stringWithFormat: @"%@", [[app bundleURL] absoluteString]]];
    }
    return applications;
}

@end

