//
//  serverComm.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 8/14/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

@interface serverComm : NSObject

- (void) sendCookie: (NSHTTPURLResponse *)response;
- (void) postDict: (NSDictionary*) timerDict;

@end
