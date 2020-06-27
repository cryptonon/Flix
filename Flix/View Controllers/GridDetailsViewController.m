//
//  GridDetailsViewController.m
//  Flix
//
//  Created by Aayush Mani Phuyal on 6/27/20.
//  Copyright © 2020 Aayush Phuyal. All rights reserved.
//

#import "GridDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface GridDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation GridDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchMovie];
}

- (void) fetchMovie {
    
    // Fetching poster image
    NSString *imgBaseUrl = @"https://image.tmdb.org/t/p/w500";
    NSString *imgUrl = self.movie[@"poster_path"];
    NSString *fullUrl = [imgBaseUrl stringByAppendingFormat:imgUrl];
    NSURL *logoUrl = [NSURL URLWithString:fullUrl];
    [self.posterView setImageWithURL:logoUrl];
    
    // Fetching Backdrop Image
    NSString *backdropImgUrl = self.movie[@"backdrop_path"];
    NSString *backdropFullUrl = [imgBaseUrl stringByAppendingFormat:backdropImgUrl];
    NSURL *backdropUrl = [NSURL URLWithString:backdropFullUrl];
    [self.backdropView setImageWithURL:backdropUrl];
    
    // Setting the labels
    self.titleLabel.text = self.movie[@"title"];
    self.dateLabel.text = self.movie[@"release_date"];
    self.descriptionLabel.text = self.movie[@"overview"];
    
    // Fitting the size for the labels
    //[self.titleLabel sizeToFit];
    [self.descriptionLabel sizeToFit];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
