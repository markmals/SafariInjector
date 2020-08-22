%group Messages

@interface MKPlaceInfoViewController : UIViewController
@end

@interface CNPropertySimpleCell : UITableViewCell
@property (retain) UILabel *labelLabel;
@property (retain) UILabel *valueLabel;
@end

%hook MKPlaceInfoViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	let cell = (CNPropertySimpleCell *)[tableView cellForRowAtIndexPath: indexPath];
    let isHomepage = [cell.labelLabel.text isEqual:@"Homepage"]

	if (isHomepage) {
		let url = [NSURL URLWithString:cell.valueLabel.text];
		if (SIJShouldPresentSVC(url)) {
			return SIJPresentSVCWithURLOnVC(url, self);
		}
	}

	return %orig(tableView, indexPath);
}

%end

%end