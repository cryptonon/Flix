//
//  GridViewController.m
//  Flix
//
//  Created by Aayush Mani Phuyal on 6/26/20.
//  Copyright © 2020 Aayush Phuyal. All rights reserved.
//

#import "GridViewController.h"
#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchNetworkRequest];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    CGFloat postersPerLine = 1;
    CGFloat itemWidth = layout.itemSize.width/postersPerLine;
    
    layout.itemSize = CGSizeMake(itemWidth, itemWidth*1.5);
}

// to fetch the network request
- (void)fetchNetworkRequest {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/603/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

               // Get the array of movies and store in the property
               self.movies = dataDictionary[@"results"];
               [self.collectionView reloadData];
               
               // Reloading the data after network request is completed
               [self.collectionView reloadData];
           }
       }];
    [task resume];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];
    
    
    NSString *imgBaseUrl = @"https://image.tmdb.org/t/p/w500";
    NSString *imgUrl = movie[@"poster_path"];
    NSString *fullUrl = [imgBaseUrl stringByAppendingFormat:imgUrl];
    NSURL *posterUrl = [NSURL URLWithString:fullUrl];
    
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterUrl];
    
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
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
