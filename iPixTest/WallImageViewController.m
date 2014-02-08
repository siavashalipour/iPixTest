//
//  WallImageViewController.m
//  iPixTest
//
//  Created by Siavash on 2/8/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "WallImageViewController.h"
#import "ImageCell.h"
#import <Parse/Parse.h>

@interface WallImageViewController ()

@property (strong, nonatomic) NSMutableArray *imagesArray;

@property (strong, nonatomic) NSMutableArray *allImages;
@end

@implementation WallImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Wall Images";
    [self query];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)query
{
    PFQuery *query = [PFQuery queryWithClassName:@"Images"];
    self.imagesArray = [NSMutableArray arrayWithCapacity:1000];
    self.imagesArray = [[query findObjects] mutableCopy];
    [query whereKey:@"image" equalTo:@"img"];
    self.allImages = [NSMutableArray arrayWithCapacity:1000];
    self.allImages = [[query findObjects] mutableCopy];
    [self.mainCollectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagesArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    [cell.spinner setHidden:NO];
    [cell.spinner startAnimating];
    PFObject *imageObject = [self.imagesArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.image.image = [UIImage imageWithData:data];
            [cell.spinner stopAnimating];
            cell.spinner.hidden = YES;
        }
    }];
    NSDictionary *imageDictionary = [self.imagesArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [imageDictionary objectForKey:@"name"];
    cell.locationLabel.text = [imageDictionary objectForKey:@"location"];
    cell.commentLabel.text = [imageDictionary objectForKey:@"comment"];
    /*if (self.shouldSpin) {
        cell.videoThumbNail.image = [UIImage imageNamed:@"emptyVideoImage.png"];
        cell.videoTitle.text = @"";
        cell.videoTime.text = @"";
        [cell.spinner setHidden:NO];
        [cell.spinner startAnimating];
    }
    else if ([self.thumbNailArray objectAtIndex:indexPath.row]){
        cell.videoThumbNail.image = [self.thumbNailArray objectAtIndex:indexPath.row];
        cell.videoTitle.text = [self.videoTitleArray objectAtIndex:indexPath.row];
        cell.videoTime.text = [self.videoDuration objectAtIndex:indexPath.row];
        [[cell saveButton] addTarget:self action:@selector(saveEvent:event:) forControlEvents:UIControlEventTouchUpInside];
        [[cell shareButton] addTarget:self action:@selector(shareEvent:event:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.spinner stopAnimating];
        [cell.spinner setHidden:YES];
    }
    */
    
    return cell;
}

@end
