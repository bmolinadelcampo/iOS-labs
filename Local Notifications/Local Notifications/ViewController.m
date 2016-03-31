//
//  ViewController.m
//  Local Notifications
//
//  Created by Belén Molina del Campo on 31/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventText;
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)scheduleEvent:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnteredForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    NSLog(@"rows is %lu", (long)rows);
    rows = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    NSLog(@"Again rows is %lu", (long)rows);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellIdentifier = @"basicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    
    NSArray *listOfNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *myNotification = listOfNotifications[indexPath.row];
    
    cell.textLabel.text = myNotification.alertBody;
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [myDateFormatter setDateFormat:@"MMMM dd, yyyy HH:mm:ss"];
    
    NSString *message = [myDateFormatter stringFromDate:myNotification.fireDate];
    cell.detailTextLabel.text = message;
    
    return cell;
}

- (IBAction)scheduleEvent:(id)sender {
    [self.eventText resignFirstResponder];
    
    UIUserNotificationSettings *currentSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (currentSettings.types & UIUserNotificationTypeAlert) {
        NSLog(@"Notifications enabled %@", currentSettings);
        
        NSDate *selectedDate = [self.myDatePicker date];
        
        UILocalNotification *myLocalNotification = [[UILocalNotification alloc] init];
        if (myLocalNotification == nil){
            return;
        }
        myLocalNotification.fireDate = selectedDate;
        myLocalNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        myLocalNotification.alertBody = self.eventText.text;
        
        myLocalNotification.alertAction = @"View";
        
        myLocalNotification.soundName = UILocalNotificationDefaultSoundName;
        myLocalNotification.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count]+1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification: myLocalNotification];
    }else{
        NSLog(@"Notfications disabled %@", currentSettings);
    }
    
    [self.myTableView reloadData];
    self.eventText.text = @"";
}

- (void)applicationEnteredForeground: (NSNotification *)notification {
    NSLog(@"Application Entered Foreground");
    [self.myTableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
