//
//  dataStruct.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/17/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataStruct.h"

static NSMutableDictionary *timerDict = nil;

@implementation dataStruct

+ (void) initialize {
    if(!timerDict) {
        timerDict = [NSMutableDictionary dictionary];
    }
}

- (NSMutableDictionary*) timerDict {
    return timerDict;
}

- (NSString*) preprocessing: (NSDictionary*) rawApplicationName {
    for(id key in rawApplicationName)
        //NSLog(@"key=%@ value=%@", key, [[rawApplicationName objectForKey:key] localizedName]);
        return([[rawApplicationName objectForKey:key] localizedName]);
    return(@"Application Name Not Received");
}

@end

