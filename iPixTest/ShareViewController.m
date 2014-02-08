//
//  ShareViewController.m
//  iPixTest
//
//  Created by Siavash on 2/7/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "ShareViewController.h"
#import <Parse/Parse.h>

@interface ShareViewController ()<UIAlertViewDelegate>

@end

@implementation ShareViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
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
    self.title = @"Share";
    [self.spinner setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    NSData *pictureData2 = UIImageJPEGRepresentation(self.image, 0.5);
    // Upload new picture
    // 1
    PFFile *image = [PFFile fileWithName:@"img" data:pictureData2];
    
    dispatch_queue_t queryQueue = dispatch_queue_create("query", NULL);
    dispatch_async(queryQueue, ^{
        PFObject *imageObject = [PFObject objectWithClassName:@"Images"];
        imageObject[@"image"] = image;
        imageObject[@"name"] = self.photoName.text;
        imageObject[@"location"] = self.photoLocation.text;
        imageObject[@"comment"] = self.comment.text;
        [self.spinner setHidden:NO];
        [self.spinner startAnimating];
        
        [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
           
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                
                if (succeeded) {
                    [self.spinner stopAnimating];
                    [self.spinner setHidden:YES];
                    [[[UIAlertView alloc] initWithTitle:nil message:@"Image Uploaded"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                    
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                }
            }];
        }progressBlock:^(int percentDone){
            
        }];
    });
    [self.view endEditing:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"wallView" sender:self];
    }
    
}

@end
