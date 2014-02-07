//
//  SignupViewController.h
//  iPixTest
//
//  Created by Siavash on 2/6/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;

- (IBAction)signup:(id)sender;

@end
