//
//  dataStruct.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/17/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

@interface dataStruct : NSObject

- (NSMutableDictionary*) timerDict;
- (NSString*) preprocessing: (NSDictionary*) rawApplicationName;
- (void) updateDict:(NSMutableDictionary *) timerDict andApp:(NSString *) processedInfo andElapsedTime:(CFTimeInterval) elapsedTime;

@end
