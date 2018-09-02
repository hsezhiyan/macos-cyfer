//
//  collectionMethods.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/5/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface collectionMethods : NSObject

extern CFTimeInterval startTime;
extern CFTimeInterval endTime;

- (id) init;
- (void) dealloc;
- (void) appDidActivate:(NSNotification *)notification;
- (NSMutableArray*) allRunningApplications;

@end



