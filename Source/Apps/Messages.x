%group Messages

@interface SMSApplication : UIApplication
@end

%hook SMSApplication

- (BOOL)openURL:(NSURL *)url {
	if (SSVCShouldPresentSVC(url)) {
        return SSVCPresentSVC(url);
	} else {
		return %orig(url);
	}
}

%end

%end