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
#import "IdleTime.h"
#import "browserTracking.h"
#import "serverComm.h"

NSString* previousApp = nil;
NSString* currentApp = nil;

NSString* previousWebsite = nil;

NSMutableDictionary* oldDict = nil;

timerMethods *timerMethod = nil;
dataStruct *dataDict = nil;
IdleTime *idleTracker = nil;
browserTracking *browserTracker = nil;
serverComm *serverOutlet = nil;

CFTimeInterval startTime;
CFTimeInterval endTime;
CFTimeInterval previousElapsedTime;

CFTimeInterval webStartTime;
CFTimeInterval webEndTime;

float globalIdleTime = 0.0;

float websitePollingInterval = 2.0;
float appPollingInterval = 5.0;
float idleTimeThreshold = 120.0;
float timeOnCurrentApp = 0.0;

@implementation collectionMethods

+ (void) initialize {
    if(!timerMethod) {
        timerMethod = [[timerMethods alloc] init];
    }
    if(!dataDict) {
        dataDict = [[dataStruct alloc] init];
    }
    if(!oldDict) {
        oldDict = [[NSMutableDictionary alloc] init];
    }
    if (!startTime) {
        startTime = [timerMethod getCurrentTime];
    }
    if (!endTime) {
        endTime = [timerMethod getCurrentTime];
    }
    if (!webStartTime) {
        webStartTime = [timerMethod getCurrentTime];
    }
    if (!webEndTime) {
        webEndTime = [timerMethod getCurrentTime];
    }
    if (!idleTracker) {
        idleTracker = [[IdleTime alloc] init];
    }
    if (!browserTracker) {
        browserTracker = [[browserTracking alloc] init];
    }
    if (!serverOutlet) {
        serverOutlet = [[serverComm alloc] init];
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
        
        [NSTimer scheduledTimerWithTimeInterval:appPollingInterval target:self
                                                                 selector:@selector(appPolling:)
                                                                 userInfo:nil
                                                                  repeats:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:websitePollingInterval target:self
                                                                 selector:@selector(websitePolling:)
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
    CFTimeInterval elapsedTime = [timerMethod getElapsedTime: startTime andTime2:endTime] - globalIdleTime;
    startTime = endTime;
    
    NSDictionary *userInfo = [notification userInfo];
    NSString* processedInfo = [dataDict preprocessing: userInfo];
    previousApp = processedInfo;
    
    if ([browserTracker isBrowser:previousApp]) {
        webEndTime = [timerMethod getCurrentTime];
        CFTimeInterval elapsedWebTime = [timerMethod getElapsedTime: webStartTime andTime2:webEndTime] - globalIdleTime;
        [dataDict updateDict:[dataDict timerDict] andApp:previousWebsite andElapsedTime:elapsedWebTime];
        previousWebsite = nil;
    }
    
    [dataDict updateDict:[dataDict timerDict] andApp:processedInfo andElapsedTime:elapsedTime];
    globalIdleTime = 0.0;
    
    //NSLog(@"Dictionary: %@", [[dataDict timerDict] description]);
    
}

/*
 If a new application is activated, this method is called.
 */
- (void) appDidActivate:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    NSString* processedInfo = [dataDict preprocessing: userInfo];
    currentApp = processedInfo;

}

/*
 Used for continuous polling. Every couple of seconds (tba), we'll look at the front most application.
 */
- (void) appPolling:(NSNotification *)notification {
    [dataDict addLocalTime: [dataDict timerDict]];
    
    NSMutableDictionary* newDict = [dataDict timerDict];
    [serverOutlet postDict:[self getUpdatedEventsOnly:oldDict :newDict]];
    NSLog(@"Dictionary: %@", [[dataDict timerDict] description]);
    oldDict = [[dataDict timerDict] copy];
}

- (NSMutableDictionary*) getUpdatedEventsOnly:(NSMutableDictionary *) oldDict:(NSMutableDictionary *) newDict {
    NSMutableDictionary *updatedDict = nil;
    
    for (id key in newDict) {
        id oldValue = [oldDict objectForKey:key];
        id newValue = [newDict objectForKey:key];
        if (oldValue == nil || oldValue != newValue) {
            [updatedDict setObject:newValue forKey:key];
        }
    }
    
    return updatedDict;
}

- (void) websitePolling:(NSNotification *)notification {
    NSString* currentWebsite = nil;
    
    float idleTime = [idleTracker secondsIdle];
    if (idleTime > idleTimeThreshold) {
        globalIdleTime = idleTime;
    }
    
    if ([browserTracker isBrowser:currentApp]) {
        if([currentApp isEqualToString:@"Google Chrome"]) {
            currentWebsite = [browserTracker frontmostWebpageURL: @"Google Chrome"];
        }
        if([currentApp isEqualToString:@"Safari"]) {
            currentWebsite = [browserTracker frontmostWebpageURL: @"Safari"];
        }
        
        if(![currentWebsite isEqualToString:previousWebsite]) {
            webEndTime = [timerMethod getCurrentTime];
            CFTimeInterval elapsedWebTime = [timerMethod getElapsedTime: webStartTime andTime2:webEndTime] - globalIdleTime;
            if ([previousWebsite length] != 0) {
                [dataDict updateDict:[dataDict timerDict] andApp:previousWebsite andElapsedTime:elapsedWebTime];
            }
            webStartTime = webEndTime;
            previousWebsite = currentWebsite;
            globalIdleTime = 0.0;
        }
    } else {
        webStartTime = [timerMethod getCurrentTime];
    }
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
