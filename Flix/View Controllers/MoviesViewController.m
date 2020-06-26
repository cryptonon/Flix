//
//  MoviesViewController.m
//  Flix
//
//  Created by Aayush Mani Phuyal on 6/25/20.
//  Copyright © 2020 Aayush Phuyal. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MoviesViewController () <UITableViewDelegate, UITableViewDataSource>
// tableView outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;
// Declaring property to store array of movies
@property (nonatomic, strong) NSArray *movies;
// Declaring property for refresh on scrolls
@property (nonatomic, strong) UIRefreshControl *refreshControl;
// Declaring property for Network alert
@property (nonatomic, strong) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting delegate and dataSource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // fetching network request
    [self fetchNetworkRequest];
    
    // Scroll to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchNetworkRequest) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // Network Alert
    self.alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
           message:@"No Internet Connection!"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again"
      style:UIAlertActionStyleCancel
    handler:^(UIAlertAction * _Nonnull action) {
        [self fetchNetworkRequest];
    }];
    // add the tryAgain action to the alertController
    [self.alert addAction:tryAgain];
    
    
    
}

// to fetch the network request 
- (void)fetchNetworkRequest {
    [self.activityIndicator startAnimating];
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               [self presentViewController:self.alert animated:YES completion:^{
                   // optional code for what happens after the alert controller has finished presenting
               }];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

               // Get the array of movies and store in the property
               self.movies = dataDictionary[@"results"];
               
               // Reloading the data after network request is completed
               [self.tableView reloadData];
           }
        [self.activityIndicator stopAnimating];
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.descriptionLabel.text = movie[@"overview"];
    
    cell.posterView.image = nil;
    
    if ([movie[@"poster_path"] isKindOfClass:[NSString class]]) {
        NSString *imgBaseUrl = @"https://image.tmdb.org/t/p/w500";
        NSString *imgUrl = movie[@"poster_path"];
        NSString *fullUrl = [imgBaseUrl stringByAppendingFormat:imgUrl];
        NSURL *posterUrl = [NSURL URLWithString:fullUrl];
        
        [cell.posterView setImageWithURL:posterUrl];
    }
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    // Get the new view controller using [segue destinationViewController].
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
    // Pass the selected object to the new view controller.
}

@end
