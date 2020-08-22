#define let __auto_type const

@import SafariServices;

void SIJPresentSVCWithURLOnVC(NSURL *url, UIViewController *vc) {
    let sfvc = [[SFSafariViewController alloc] initWithURL:url];
    [vc presentViewController:sfvc animated:YES completion:nil];
}

BOOL SIJPresentSVCOnRootVCWithURL(NSURL *url) {
    // Get the current view controller onto which we will push SFVC
	let rootVC = (UISplitViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
	let navigationVC = (UINavigationController *)rootVC.viewControllers.firstObject;
    presentSVCWithURLOnVC(url, navigationVC);
    return YES;
}

BOOL SIJShouldPresentSVC(NSURL *url) {
    // If the URL has a custom scheme (e.g. apollo://) don't open it in Safari View Controller
    if (![url.scheme hasPrefix:@"http"] || ![url.scheme hasPrefix:@"https"]) {
        return NO;
    }
    
    let excludedDomains = @[@"youtu.be", @"twitter.com", @"youtube.com", @"appsto.re"];
    
    // Skip deep links for installed apps
    for (NSString *domain in excludedDomains) {
        let matchesURL = [url.host isEqualToString:domain];
        let canOpenURL = [[UIApplication sharedApplication] canOpenURL:url];

        if (matchesURL && canOpenURL) {
            return NO;
        }
    }
    
    return YES;
}
