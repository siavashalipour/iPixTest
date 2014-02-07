//
//  ViewController.m
//  iPixTest
//
//  Created by Siavash on 2/6/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *userPass;

@end

@implementation ViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return  YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Login";
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"pushWelcomeScreen" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text block:^(PFUser *user, NSError *error){
        if (user) {
            [self performSegueWithIdentifier:@"pushWelcomeScreen" sender:self];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
}



- (IBAction)facebookLogin:(id)sender
{
    NSArray *permissionsArray = @[@"user_about_me",@"user_relationships",@"user_birthday",@"user_location",];
    //login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error){
        
        if (!user) {
            if (!error) {
                NSLog(@"uh, the user cancelled the Facebook login");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log in error" message:@"uh, the user cancelled the Facebook login" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
            else
            {
                NSLog(@"uh, an error occured: %@",error.localizedDescription);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log in error" message:error.localizedDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        }
        else if (user.isNew){
            NSLog(@"User with facebook signed up and logged in!");
            [self updateUser];
            //self performSegue....
            [self performSegueWithIdentifier:@"pushWelcomeScreen" sender:self];
            
        }
        else
        {
            NSLog(@"User with facebook loggin");
        }
    }];
}

- (void)updateUser
{
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error){
        
        if (!error) {
            NSDictionary *userData = (NSDictionary *)result;
            
            self.userID = userData[@"name"];
            
            [PFUser currentUser][@"displayName"] = self.userID;
            [PFUser currentUser][@"email"] = userData[@"email"];
            
            [PFUser currentUser].username = self.userID;
            [[PFUser currentUser] saveEventually];
        }
    }];
}
@end
