//
//  SignupViewController.m
//  iPixTest
//
//  Created by Siavash on 2/6/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()<UITextFieldDelegate>


@end

@implementation SignupViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return  YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Signup";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signup:(id)sender
{
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    user.email = self.email.text;
    
    if (![@"" isEqualToString:self.username.text] &&
        ![@"" isEqualToString:self.password.text] &&
        ![@"" isEqualToString:self.email.text]) {
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
           
            if (!error) {
                [self performSegueWithIdentifier:@"pushWelcomeScreen" sender:self];
            }
            else
            {
                //[error userInfo][@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please fill out all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

@end
