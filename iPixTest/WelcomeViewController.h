//
//  WelcomeViewController.h
//  iPixTest
//
//  Created by Siavash on 2/7/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)photoAlbum:(id)sender;
- (IBAction)camera:(id)sender;

@end
