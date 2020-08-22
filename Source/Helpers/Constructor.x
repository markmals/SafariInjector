%ctor {
	%init;

	NSString *appName = [[NSBundle mainBundle] localizedInfoDictionary][@"CFBundleDisplayName"];

    let appIsMessages = [appName isEqualToString:@"Messages"];
    let appIsMail = [appName isEqualToString:@"Mail"];
    let appIsMaps = [appName isEqualToString:@"Maps"];
    let appIsCalendar = [appName isEqualToString:@"Calendar"];
    let appIsNotes = [appName isEqualToString:@"Notes"];

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
