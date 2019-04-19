//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "CakeData.h"

@interface MasterViewController ()
@property (strong, nonatomic) NSArray *listObjects;
@end

@implementation MasterViewController

/**
 *
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL success = [self startDataFetch];
    
    if (success) {
        [self.tableView reloadData];
    }
}

/**
 *
 */
-(BOOL)startDataFetch {
    NSData *data = [CakeData getData];
    
    if (data == nil) {
        [self displayDataFetchError];
    } else {
        id result = [CakeData parseData:data];
        
        if ([result isKindOfClass:[NSError class]]) {
            [self displayDataFetchError];
        } else if ([result isKindOfClass:[NSArray class]]) {
            self.listObjects = result;
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Table View

/**
 *
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listObjects.count;
}

/**
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    
    NSAssert(cell != nil, @"Cell is nil");
    
    NSDictionary *object = self.listObjects[indexPath.row];
    cell.titleLabel.text = object[@"title"];
    cell.descriptionLabel.text = object[@"desc"];
 
    NSURL *aURL = [NSURL URLWithString:object[@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:aURL];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image == nil) {
        cell.cakeImageView.backgroundColor = UIColor.whiteColor;
        image = [UIImage imageNamed:@"icon-cake"];
    }
    
    [cell.cakeImageView setImage:image];
    
    return cell;
}

/**
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 *
 */
-(void)displayDataFetchError {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ERROR_TITLE", comment:"")
                                                                   message:NSLocalizedString(@"BAD_DATA_FETCH_MESSAGE", comment:"")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OKAY", comment:"") style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
