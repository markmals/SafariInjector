@import SafariServices;

void SIJPresentSVCWithURLOnVC(NSURL *url, UIViewController *vc) {
    SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:url];
    [vc presentViewController:sfvc animated:YES completion:nil];
}

BOOL SIJPresentSVCOnRootVCWithURL(NSURL *url) {
    // Get the current view controller onto which we will push SFVC
	UISplitViewController *rootVC = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
	UINavigationController *navigationVC = (id)rootVC.viewControllers.firstObject;
    SIJPresentSVCWithURLOnVC(url, navigationVC);
    return YES;
}

BOOL SIJShouldPresentSVC(NSURL *url) {
    // If the URL has a custom scheme (e.g. apollo://) don't open it in Safari View Controller
    if (![url.scheme hasPrefix:@"http"] || ![url.scheme hasPrefix:@"https"]) {
        return NO;
    }
    
    NSArray *excludedDomains = @[@"youtu.be", @"twitter.com", @"youtube.com", @"appsto.re"];
    
    // Skip deep links for installed apps
    for (NSString *domain in excludedDomains) {
        BOOL matchesURL = [url.host isEqualToString:domain];
        BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:url];

        if (matchesURL && canOpenURL) {
            return NO;
        }
    }
    
    return YES;
}

%group Messages

@interface SMSApplication : UIApplication
@end

%hook SMSApplication

- (BOOL)openURL:(NSURL *)url {
	if (SIJShouldPresentSVC(url)) {
        return SIJPresentSVCOnRootVCWithURL(url);
	} else {
		return %orig(url);
	}
}

%end

%end

%group Mail

@interface MailAppController : UIApplication
@end

%hook MailAppController

- (BOOL)openURL:(NSURL *)url {
	if (SIJShouldPresentSVC(url)) {
        return SIJPresentSVCOnRootVCWithURL(url);
	} else {
		return %orig(url);
	}
}

%end

%end

%group Maps

@interface MKPlaceInfoViewController : UIViewController
@end

@interface CNPropertySimpleCell : UITableViewCell
@property (retain) UILabel *labelLabel;
@property (retain) UILabel *valueLabel;
@end

%hook MKPlaceInfoViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	CNPropertySimpleCell *cell = (id)[tableView cellForRowAtIndexPath: indexPath];
    BOOL isHomepage = [cell.labelLabel.text isEqual:@"Homepage"];

	if (isHomepage) {
		NSURL *url = [NSURL URLWithString:cell.valueLabel.text];
		if (SIJShouldPresentSVC(url)) {
			return SIJPresentSVCWithURLOnVC(url, self);
		}
	}

	return %orig(tableView, indexPath);
}

%end

%end

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

%group Notes

%hook UIApplication

- (BOOL)openURL:(NSURL *)url {
	if (SIJShouldPresentSVC(url)) {
        return SIJPresentSVCOnRootVCWithURL(url);
	} else {
		return %orig(url);
	}
}

%end

%end

%ctor {
	%init;

	NSString *appName = [[NSBundle mainBundle] localizedInfoDictionary][@"CFBundleDisplayName"];

    BOOL appIsMessages = [appName isEqualToString:@"Messages"];
    BOOL appIsMail = [appName isEqualToString:@"Mail"];
    BOOL appIsMaps = [appName isEqualToString:@"Maps"];
    BOOL appIsCalendar = [appName isEqualToString:@"Calendar"];
    BOOL appIsNotes = [appName isEqualToString:@"Notes"];

	if (appIsMessages) {
		%init(Messages);
	} else if (appIsMail) {
        %init(Mail);
    } else if (appIsMaps) {
        %init(Maps);
    } else if (appIsCalendar) {
        %init(Calendar);
    } else if (appIsNotes) {
        %init(Notes);
    }
}
