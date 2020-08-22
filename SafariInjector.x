#import "Include.h"


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
