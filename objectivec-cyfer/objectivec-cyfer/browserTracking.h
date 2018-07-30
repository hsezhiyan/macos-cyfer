//
//  browserTracking.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/29/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface browserTracking : NSObject

- (Boolean) isBrowser: (NSString*) appName;
- (NSString*) frontmostWebpageURL: (NSString*) appName;

@end
