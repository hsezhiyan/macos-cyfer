//
//  runLoop.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 8/16/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>
#import "collectionMethods.h"
#import "runLoop.h"

@implementation runLoop

- (void) runProgram {
    static collectionMethods *collectionMethod;
    collectionMethod = [[collectionMethods alloc] init];
    @autoreleasepool
    {
        NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
        while ([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]]);
    };
}

@end
