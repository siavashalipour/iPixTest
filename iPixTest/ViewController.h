//
//  ViewController.h
//  iPixTest
//
//  Created by Siavash on 2/6/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;


- (IBAction)facebookLogin:(id)sender;
@end
