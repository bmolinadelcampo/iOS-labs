//
//  ViewController.m
//  Top Songs
//
//  Created by Belén Molina del Campo on 05/04/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 
@property (strong, nonatomic) NSMutableArray *songsArray;
@property (strong, nonatomic) NSMutableData *xmlData;
@property (strong, nonatomic) NSURLConnection *connectionInProgress;
@property (strong, nonatomic) NSMutableString *titleString;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (nonatomic) BOOL correctSizeImageFound;
@property (strong, nonatomic) UIActivityIndicatorView *cLoadingView;
- (void)initSpinner;
- (void)spinBegin;
- (void)spinEnd;
- (void)loadSongs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.songsArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.correctSizeImageFound = NO;
    
    [self.refreshControl addTarget:self action:@selector(loadSongs) forControlEvents:UIControlEventValueChanged];
    
    [self initSpinner];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [NSThread detachNewThreadSelector:@selector(spinBegin) toTarget:self withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self loadSongs];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.songsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell"];
    NSUInteger row = [indexPath row];
    NSString *rowString = self.songsArray[row];
    cell.textLabel.text = rowString;
    cell.textLabel.font = [UIFont systemFontOfSize:10.0];
    
    cell.imageView.image = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imagesArray[row]]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[cell imageView] setImage:image];
            [cell setNeedsLayout];
        });
    });
    
    return cell;
}

- (void)loadSongs
{
    [self.songsArray removeAllObjects];
    [[self tableView] reloadData];
    NSURL *myUrl = [NSURL URLWithString:@"https://itunes.apple.com/gb/rss/topsongs/limit=100/xml"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    if (self.connectionInProgress) {
        [self.connectionInProgress cancel];
    }
    self.xmlData = [[NSMutableData alloc] init];
    self.connectionInProgress = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self startImmediately:YES];
    NSLog(@"loading songs");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data
{
    [self.xmlData appendData:data];
}

- (void)connectionDidFinishLoading: (NSURLConnection *)connection
{
    NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:self.xmlData];
    [myParser setDelegate:self];
    [myParser parse];
    [[self tableView] reloadData];
    [self.refreshControl endRefreshing];
    [NSThread detachNewThreadSelector:@selector(spinEnd) toTarget:self withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(nonnull NSError *)error
{
    [self.refreshControl endRefreshing];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [NSThread detachNewThreadSelector:@selector(spinEnd) toTarget:self withObject:nil];
    self.connectionInProgress = nil;
    self.xmlData = nil;
    
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [myAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSArray *myArray = [attributeDict allValues];
    
    if ([elementName isEqualToString:@"im:image"] && [myArray[0] isEqualToString:@"55"]) {
        NSLog(@"Found Image!");
        self.correctSizeImageFound = YES;
        self.titleString = [[NSMutableString alloc] init];
    }
    if ([elementName isEqual:@"title"] && ![self.titleString isEqual:@"iTunes Store: Top Songs"]) {
        NSLog(@"Found Title!");
        self.titleString = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.titleString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqual:@"title"] && ![self.titleString isEqual:@"iTunes Store: Top Songs"]) {
        NSLog(@"ended title: %@", self.titleString);
        [self.songsArray addObject:[NSString stringWithString:self.titleString]];
        self.titleString = nil;
    }
    if ([elementName isEqualToString:@"im:image"] && self.correctSizeImageFound) {
        NSLog(@"ended image: %@", self.titleString);
        [self.imagesArray addObject:[NSString stringWithString:self.titleString]];
        self.titleString = nil;
        self.correctSizeImageFound = NO;
    }
}

- (void)initSpinner
{
    self.cLoadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGPoint newCentre = (CGPoint) [self.view center];
    self.cLoadingView.center= newCentre;
    [self.view addSubview:self.cLoadingView];
}

- (void)spinBegin
{
    [self.cLoadingView startAnimating];
}

- (void)spinEnd
{
    [self.cLoadingView stopAnimating];
}
@end
