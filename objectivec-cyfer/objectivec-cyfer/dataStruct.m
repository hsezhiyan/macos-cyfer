//
//  dataStruct.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/17/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataStruct.h"

NSMutableDictionary *timerDict = nil;

@implementation dataStruct

+ (void) initialize {
    if(!timerDict) {
        timerDict = [NSMutableDictionary dictionary];
    }
}

- (NSString*) preprocessing: (NSDictionary*) rawApplicationName {
    for(id key in rawApplicationName)
        NSLog(@"key=%@ value=%@", key, [rawApplicationName objectForKey:key]);
    return @"Hello";
}

@end

