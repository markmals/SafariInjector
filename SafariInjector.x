#import "Include.h"

%group URLOpenable

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

%end

%ctor {
	%init;

    // let bundleID = NSBundle.mainBundle.bundleIdentifier;

    // let isMessages = [bundleID isEqualToString:@"com.apple.MobileSMS"];
    // let isMail = [bundleID isEqualToString:@"com.apple.mobilemail"];
    // let isCalendar = [bundleID isEqualToString:@"com.apple.mobilecal"];
    // let isNotes = [bundleID isEqualToString:@"com.apple.mobilenotes"];
    // let isMaps = [bundleID isEqualToString:@"com.apple.Maps"];
    // let isGitHub = [bundleID isEqualToString:@"com.github.stormbreaker.prod"];

    let isURLOpenable = YES; // isMessages || isNotes || isMaps || isGitHub;
	// let isNotURLOpenable = isMail || isCalendar;

    if (isURLOpenable) {
        %init(URLOpenable);
    }
}
