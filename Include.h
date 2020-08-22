#define let __auto_type const

#pragma mark Imports

@import SafariServices;
@import Foundation;
@import UIKit;

#pragma mark Project Symbols

void SIJPresentSVCWithURLOnVC(NSURL *url, UIViewController *vc);
BOOL SIJPresentSVCOnRootVCWithURL(NSURL *url);
BOOL SIJShouldPresentSVC(NSURL *url);

#pragma mark Interfaces

@interface MKPlaceInfoViewController : UIViewController
@end

@interface CNPropertySimpleCell : UITableViewCell
@property (retain) UILabel *labelLabel;
@property (retain) UILabel *valueLabel;
@end
