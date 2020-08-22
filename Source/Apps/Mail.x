%group Mail

@interface MailAppController : UIApplication
@end

%hook MailAppController

- (BOOL)openURL:(NSURL *)url {
	if (SSVCShouldPresentSVC(url)) {
        return SSVCPresentSVC(url);
	} else {
		return %orig(url);
	}
}

%end

%end