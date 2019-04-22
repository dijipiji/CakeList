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
            CakeData.sourcedCellImages = [NSMutableArray arrayWithCapacity:[result count]];
            
            for (int i = 0; i < [result count]; i++) {
                [CakeData.sourcedCellImages addObject:[NSNull null]];
            }
            
            CakeData.listObjects = result;
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
    return CakeData.listObjects.count;
}

/**
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    
    NSAssert(cell != nil, @"Cell is nil");
    
    NSDictionary *object = CakeData.listObjects[indexPath.row];
    cell.titleLabel.text = object[@"title"];
    cell.descriptionLabel.text = object[@"desc"];
    cell.cakeImageView.backgroundColor = UIColor.whiteColor;

    // read: https://stackoverflow.com/questions/16663618/async-image-loading-from-url-inside-a-uitableview-cell-image-changes-to-wrong/16663759
    
    if (CakeData.sourcedCellImages[indexPath.row] == [NSNull null]) {
        
        NSURL *url = [NSURL URLWithString:object[@"image"]];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData * _Nullable data,
                                                                                 NSURLResponse * _Nullable response,
                                                                                 NSError * _Nullable error) {
                                                                 if (data) {
                                                                     UIImage *image = [UIImage imageWithData:data];
                                                                     
                                                                     if (image == nil) {
                                                                         image = [UIImage imageNamed:@"icon-cake"];
                                                                     }
                                                                     
                                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                                         CakeCell *updateCell = (CakeCell*)[tableView cellForRowAtIndexPath:indexPath];
                                                                         
                                                                         if (updateCell) {
                                                                             [updateCell.cakeImageView setImage:image];
                                                                         }
                                                                     });
                                                                     
                                                                     CakeData.sourcedCellImages[indexPath.row] = image;
                                                                 }
                                                             }];
        [task resume];
        
    } else {
        [cell.cakeImageView setImage:CakeData.sourcedCellImages[indexPath.row]];
    }

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
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView.indexPathsForVisibleRows indexOfObject:indexPath] == NSNotFound) {
        CakeCell *cakeCell = (CakeCell *)cell;
        [cakeCell.cakeImageView setImage: [UIImage imageNamed:@"icon-cake"]];
    }
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
