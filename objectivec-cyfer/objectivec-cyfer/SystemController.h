//
//  SystemController.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 8/26/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

@interface SystemController : NSObject

- (void) forceQuitApp: (NSString*)appName;
- (void) forceActivateApp: (NSString*)appName;
- (void) closeChromeTab: (NSString*)url;
- (void) pushNotification: (NSString*)notification andTitle:(NSString*)title andSubTitle:(NSString*)subtitle;

@end
