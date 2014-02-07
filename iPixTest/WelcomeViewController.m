//
//  WelcomeViewController.m
//  iPixTest
//
//  Created by Siavash on 2/7/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "WelcomeViewController.h"
#import "ImageViewController.h"

@interface WelcomeViewController ()

@property (strong, nonatomic) UIImage *imageTaked;
@end

@implementation WelcomeViewController

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
    self.title = @"Welcome";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoAlbum:(id)sender
{
    UIImagePickerControllerSourceType   sourceType = 0;
	sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
	
    UIImagePickerController*    imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES  completion:nil];
}

- (IBAction)camera:(id)sender
{
    UIImagePickerControllerSourceType   sourceType = 0;
	sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
	
    UIImagePickerController*    imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
	
    [self presentViewController:imagePicker animated:YES  completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageTaked = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"first");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"editImage" sender:self];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //[self dismissViewControllerAnimated:YES completion:^(void){
        
     //   [self viewDidLoad];
    //}];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editImage"]) {
        NSLog(@"second");
        ImageViewController *VC = segue.destinationViewController;
        VC.img = self.imageTaked;
    }
}
@end
