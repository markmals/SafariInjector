//
//  SafariInjector.x
//  SafariInjector
//  
//  Created by Tanner Bennett on 2020-08-22
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#import "Includes.h"

%group Maps
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

%group All
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

	NSString *appName = NSBundle.mainBundle.localizedInfoDictionary[@"CFBundleDisplayName"];
    BOOL appIsMaps = [appName isEqualToString:@"Maps"];

    %init(All);

	if (appIsMaps) {
        %init(Maps);
    }
}
