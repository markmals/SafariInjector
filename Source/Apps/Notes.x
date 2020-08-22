%group Notes

%hook UIApplication

- (BOOL)openURL:(NSURL *)url {
	if (SSVCShouldPresentSVC(url)) {
        return SIJPresentSVCOnRootVCWithURL(url);
	} else {
		return %orig(url);
	}
}

%end

%end