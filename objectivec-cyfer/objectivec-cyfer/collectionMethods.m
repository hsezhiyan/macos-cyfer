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
                                                               selector:@selector(appDidActivate:)
                                                                   name:NSWorkspaceDidActivateApplicationNotification
                                                                 object:nil];
        //NSLog(@"here");
    }
    return self;
}

- (void) dealloc {
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
    //[super dealloc];
}

- (void) appDidActivate:(NSNotification *)notification {
    endTime = [timerMethod getCurrentTime];
    CFTimeInterval elapsedTime = [timerMethod getElapsedTime: startTime andTime2:endTime];
    NSDictionary *userInfo = [notification userInfo];
    NSString* processedInfo = [dataDict preprocessing: userInfo];
    NSLog(@"Processed application name: %@", processedInfo);
    NSLog(@"Amount of time spent on app: %f", elapsedTime);
    NSLog(@"userInfo == %@", userInfo);
    startTime = endTime;
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
