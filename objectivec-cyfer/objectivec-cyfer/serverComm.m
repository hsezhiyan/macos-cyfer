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

- (void) postDict: (NSDictionary*) timerDict {
    
    if (timerDict == nil) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:@"https://cyfer-server-test.herokuapp.com/data"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSDictionary *dictionary = timerDict;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                       // Handle response here
                                                                   }];
        [uploadTask resume];
    }
    NSLog(@"Finished posting data to server");
    
}

@end
