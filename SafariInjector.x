//
//  SafariInjector.x
//  SafariInjector
//  
//  Created by Mark Malstrom on 2020-08-22
//  Copyright © 2020 Mark Malstrom. All rights reserved.
//

#import "Includes.h"

%hook UIApplication

- (BOOL)openURL:(NSURL *)url {
	if (SIJShouldPresentSVC(url)) {
        return SIJPresentSVCOnRootVCWithURL(url);
	} else {
		return %orig(url);
	}
}

- (void)openURL:(NSURL *)url
        options:(NSDictionary *)options
		completionHandler:(void (^)(BOOL success))completion {

	if (SIJShouldPresentSVC(url)) {
        SIJPresentSVCOnRootVCWithURL(url);
		completion(true);
	} else {
		%orig(url, options, completion);
	}
}

%end
