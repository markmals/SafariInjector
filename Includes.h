//
//  Includes.h
//  SafariInjector
//  
//  Created by Tanner Bennett on 2020-08-22
//  Copyright © 2020 Mark Malstrom. All rights reserved.
//

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
