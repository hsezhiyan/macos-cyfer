//
//  collectionMethods.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/5/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface collectionMethods : NSObject

-(id) init;
-(void) dealloc;
-(void) appDidActivate:(NSNotification *)notification;
-(NSRunningApplication*) frontmostApplication;
-(NSMutableArray*) allRunningApplications;

@end



