//
//  serverComm.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 8/14/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "serverComm.h"

@implementation serverComm

- (void) sendCookie: (NSHTTPURLResponse *)response {
    NSHTTPURLResponse *HTTPResponsesss = response;
    NSDictionary *fields = [HTTPResponsesss allHeaderFields];
    NSString *cookie = [fields valueForKey:@"Set-Cookie"]; // It is your cookie
    NSLog(@"%@", cookie);
}

- (void) postDict: (NSDictionary*) timerDict {
    
    NSURL *url = [NSURL URLWithString:@"https://cyfer-server-test.herokuapp.com/data/usage"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:YES];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];;
    NSString* localTime = [timerDict objectForKey:@"Local Time"];
    
    for(id key in timerDict) {
        if (![key isEqualToString:@"Local Time"]) {
            NSString* appName = key;
            NSString* usageTime = [timerDict objectForKey:key];
            NSString* testerAppName = [NSString stringWithFormat:@"tester1,%@", appName];
            [dictionary setObject:testerAppName forKey:@"keys"];
            [dictionary setObject:usageTime forKey:@"value"];
            [dictionary setObject:localTime forKey:@"submissiontime"];
            
            NSError *error = nil;
            NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                           options:kNilOptions
                                                             error:&error];
            
            NSLog(@"%@", dictionary);
            
            if (!error) {
                NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                           fromData:data
                                                                  completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                  }];
                [uploadTask resume];
            }
        }
    }
}

@end
