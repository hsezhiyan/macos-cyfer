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

- (NSMutableDictionary*) addLocalTime: (NSMutableDictionary*) preprocessedDict {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle]; // Set date and time styles
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    [preprocessedDict setObject:dateString forKey:@"Local Time"];
    return preprocessedDict;
}

- (void) updateDict:(NSMutableDictionary *) timerDict andApp:(NSString *) processedInfo andElapsedTime:(CFTimeInterval) elapsedTime {
    if (![timerDict objectForKey:processedInfo]) {
        [timerDict setObject:[NSNumber numberWithFloat:elapsedTime] forKey:processedInfo];
    } else {
        NSNumber* previousElapsedTime = [timerDict valueForKey:processedInfo];
        double previousTime = [previousElapsedTime doubleValue];
        CFTimeInterval newElapsedTime = previousTime + elapsedTime;
        [timerDict setObject:[NSNumber numberWithFloat:newElapsedTime] forKey:processedInfo];
    }
}

@end




