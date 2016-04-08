//
//  ViewController.m
//  Persistence
//
//  Created by Belén Molina del Campo on 08/04/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"
#define kFileName @"savedData.plist"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *townField;
@property (weak, nonatomic) IBOutlet UITextField *countyField;

- (NSURL *)pathToFile;
- (void)applicationDidEnterBackground: (NSNotification *)notification;
- (IBAction)textFieldDoneEditing:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *filePathURL = [self pathToFile];
    if ([[[NSFileManager alloc] init] fileExistsAtPath:[filePathURL path]]) {
        NSArray *myArray = [[NSArray alloc] initWithContentsOfURL:filePathURL];
        self.nameField.text = myArray[0];
        self.addressField.text = myArray[1];
        self.townField.text = myArray[2];
        self.countyField.text = myArray[3];
    }
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
}

- (NSURL *)pathToFile
{
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSError *err;
    NSURL *docsURL = [fm URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    return [docsURL URLByAppendingPathComponent:kFileName];
}

- (void)applicationDidEnterBackground: (NSNotification *)notification
{
    NSMutableArray *myArray = [[NSMutableArray alloc] init];
    [myArray addObject:self.nameField.text];
    [myArray addObject:self.addressField.text];
    [myArray addObject:self.townField.text];
    [myArray addObject:self.countyField.text];
    [myArray writeToURL:[self pathToFile] atomically:YES];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
