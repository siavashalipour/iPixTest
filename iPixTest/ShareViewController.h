//
//  ShareViewController.h
//  iPixTest
//
//  Created by Siavash on 2/7/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) IBOutlet UITextField *photoName;
@property (strong, nonatomic) IBOutlet UITextField *photoLocation;
@property (strong, nonatomic) IBOutlet UITextView *comment;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)done:(id)sender;

@end
