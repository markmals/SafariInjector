%group Calendar

@interface Application : UIApplication
@end

%hook Application

- (BOOL)openURL:(NSURL *)url {
	if (SIJShouldPresentSVC(url)) {
        return SIJPresentSVCOnRootVCWithURL(url);
	} else {
		return %orig(url);
	}
}

%end

%end