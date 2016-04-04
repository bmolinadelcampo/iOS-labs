//
//  ViewController.m
//  Top Songs JSON
//
//  Created by Belén Molina del Campo on 04/04/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *jsonFeed;
@property (strong, nonatomic) NSDictionary *songFeed;
@property (strong, nonatomic) NSMutableArray *songList;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSMutableArray *savedImages;
@property (strong, nonatomic) NSMutableArray *tasksArray;
@property (strong, nonatomic) UIActivityIndicatorView *myActivityView;
@property BOOL downloading;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSpinner];
    [self.refreshControl addTarget:self action:@selector(refreshJsonFeed) forControlEvents:UIControlEventValueChanged];
    self.downloading = YES;
    [self fetchJsonFeed];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.songList count] != [self.savedImages count])
    {
        self.savedImages = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < [self.songList count]; i++) {
            [self.savedImages addObject:[NSNull null]];
        }
    }
    return [self.songList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell"];
    NSDictionary *myEntry = self.songList[indexPath.row];
    NSDictionary *titleEntry = [myEntry objectForKey:@"title"];
    NSString *title = [titleEntry objectForKey:@"label"];
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont systemFontOfSize:10.0];
    cell.imageView.image =nil;
    if (self.savedImages[indexPath.row] != [NSNull null]) {
        [[cell imageView] setImage:self.savedImages[indexPath.row]];
    }
    return  cell;
}

- (void)fetchJsonFeed
{
    self.jsonFeed = nil;
    self.songFeed = nil;
    self.songList = nil;
    [self.myActivityView startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.session = [NSURLSession sharedSession];
    NSURL *myURL = [NSURL URLWithString:@"https://itunes.apple.com/gb/rss/topalbums/limit=50/json"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:myURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.jsonFeed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"%@", self.jsonFeed);
        self.songFeed = [self.jsonFeed objectForKey:@"feed"];
        self.songList = [self.songFeed objectForKey:@"entry"];
        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
        [self fetchImages];
    }];
    [dataTask resume];
}

- (void)fetchImages
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.tasksArray = [[NSMutableArray alloc] init];
    sessionConfig.HTTPMaximumConnectionsPerHost = 3;
    sessionConfig.timeoutIntervalForResource = 120;
    sessionConfig.timeoutIntervalForRequest = 120;
    self.session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    for (int i = 0; i < [self.songList count]; i++) {
        NSDictionary *myEntry = self.songList[i];
        NSArray *allImages = [myEntry objectForKey:@"im:image"];
        NSDictionary *myImageDetails = allImages[0];
        NSString *myImage = [myImageDetails objectForKey:@"label"];
        NSURLSessionDownloadTask *sessionDownladTask = [self.session downloadTaskWithURL:[NSURL URLWithString:myImage]];
        [self.tasksArray addObject:sessionDownladTask];
        [sessionDownladTask resume];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error) {
        NSLog(@"task %lu: finished!", (long)[self.tasksArray indexOfObject:task]);
    } else if (error.code == NSURLErrorTimedOut){
        NSLog(@"task %lu: timed out!", (long)[self.tasksArray indexOfObject:task]);
    }
    [self checkForRemainingTasks];
}

- (void)URLSession: (NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
{
    NSLog(@"task %lu: downloaded!", (long)[self.tasksArray indexOfObject:downloadTask]);
    NSUInteger taskID = [self.tasksArray indexOfObject:downloadTask];
    
    self.savedImages[taskID] = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
    
    dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
}

- (void)refreshJsonFeed
{
    if (!self.downloading) {
        self.downloading = YES;
        [self fetchJsonFeed];
    }
}

- (void)checkForRemainingTasks
{
    [self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        NSLog(@"Outstanding tasks are %lu", (long)[downloadTasks count]);
        if ([downloadTasks count] == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myActivityView stopAnimating];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self.refreshControl endRefreshing];
                self.downloading = NO;
            });
        }
    }];
}

- (void)initSpinner
{
    self.myActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGPoint newCentre = [self.view center];
    self.myActivityView.center = newCentre;
    [self.view addSubview:self.myActivityView];
}
@end
