//
//  browserTracking.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/29/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "browserTracking.h"
#import "timerMethods.h"

@implementation browserTracking

- (Boolean) isBrowser: (NSString*) appName {
    if ([appName isEqualToString:@"Google Chrome"] || [appName isEqualToString:@"Safari"]) {
        return true;
    } else {
        return false;
    }
}

- (NSString*) frontmostWebpageURL: (NSString*) appName {
    NSString * source;
    if ([appName isEqualToString: @"Safari"]) {
        source = [NSString stringWithFormat:@"tell application \"%@\" to return URL of front document as string", appName];
    } else if ([appName isEqualToString: @"Google Chrome"]) {
        source = [NSString stringWithFormat:@"tell application \"%@\" to return URL of active tab of front window", appName];
    }
//    NSLog(@"%@",source);
    NSAppleScript *script= [[NSAppleScript alloc] initWithSource:source];
    NSDictionary *scriptError = nil;
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:&scriptError];
    if(scriptError) {
        return @"Error in receiving data.";
    } else {
        // Use apple script to get the entire URL
        NSAppleEventDescriptor *unicode = [descriptor coerceToDescriptorType:typeUnicodeText];
        NSData *data = [unicode data];
        NSString *rawUrl = [[NSString alloc] initWithCharacters:(unichar*)[data bytes] length:[data length] / sizeof(unichar)];
        
        // Get the main URL parts
        NSArray *separatedUrl = [rawUrl componentsSeparatedByString:@"/"];
        NSString *mainUrl = [separatedUrl objectAtIndex:2];
        
        return mainUrl;
    }
}

@end
