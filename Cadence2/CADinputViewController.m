//
//  CADinputViewController.m
//  Cadence2
//
//  Created by Sachin Monga on 8/20/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import "CADinputViewController.h"
#import "CADgraphViewController.h"
#import "CADsettingsViewController.h"
#import "CADbardoViewController.h"
#import "LoginViewController.h"
#import "CADkeyword.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <CoreLocation/CoreLocation.h>

@interface CADinputViewController ()

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@end

@implementation CADinputViewController {
 
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *currentCity;
    
}

- (void)startSignificantChangeUpdates
{
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    [locationManager startMonitoringSignificantLocationChanges];
    
}

- (NSString *)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    NSLog(@"Some stuff is happening in locationManager");
    
    if (location != nil) {
        
        NSLog(@"Latitude: %f, Longitude: %f", location.coordinate.latitude, location.coordinate.longitude);
        
        // Reverse geocode to get city name
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
                currentCity = placemark.locality;
                NSLog(@"%@", currentCity);
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
        
    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    [self viewDidAppear:YES];
    
    return currentCity;
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    // Update label to reflect today's date and location
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    [timeFormat setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [timeFormat stringFromDate:date];
    
    dateString = [NSString stringWithFormat:@"It's %@ on %@, wherever you are.\r\rHow was your day, compared to yesterday?", currentTime, dateString];
    self.dateLabel.text = dateString;
    
}

- (IBAction)setLove:(id)sender
{
    NSLog(@"Love");

    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Love";
    [self presentViewController:keywordVC animated:YES completion:nil];
    
}

- (IBAction)setFear:(id)sender
{
    NSLog(@"Fear");

    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Fear";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setExcitement:(id)sender
{
    NSLog(@"Excitement");

    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Excitement";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setAnxiety:(id)sender
{
    NSLog(@"Anxiety");
    
    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Anxiety";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setJoy:(id)sender
{
    NSLog(@"Joy");

    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Joy";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setSadness:(id)sender
{
    NSLog(@"Sadness");
    
    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Sadness";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setGratitude:(id)sender
{
    NSLog(@"Gratitude");
    
    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Gratitude";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setAnger:(id)sender
{
    NSLog(@"Anger");
    
    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Anger";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setContentment:(id)sender
{
    NSLog(@"Contentment");
    
    CADkeyword *keywordVC = [[CADkeyword alloc] initWithNibName:@"CADkeyword" bundle:nil];
    keywordVC.emotionFromInput = @"Contentment";
    [self presentViewController:keywordVC animated:YES completion:nil];
}

- (IBAction)setMood:(id)sender
{
    
    // Trigger actions for different targets
    
    /*
    UISegmentedControl *segmentedControl = sender;
    
    if ([segmentedControl selectedSegmentIndex] == 0) {
        NSLog(@"Anxiety");
        PFObject *emotion = [PFObject objectWithClassName:@"Emotion"];
        [emotion setObject:@"Anxiety" forKey:@"feeling"];
        [emotion saveInBackground];
        /*
         PFObject *mood = [PFObject objectWithClassName:@"Mood"];
        [mood setObject:@-1 forKey:@"moodValue"];
        if (currentCity)
            [mood setObject:currentCity forKey:@"location"];
        [mood setObject:[PFUser currentUser] forKey:@"author"];
        [mood saveInBackground];
     
    }
    
    else if ([segmentedControl selectedSegmentIndex] == 1) {
        NSLog(@"The Same");
        PFObject *mood = [PFObject objectWithClassName:@"Mood"];
        [mood setObject:@0 forKey:@"moodValue"];
        if (currentCity)
            [mood setObject:currentCity forKey:@"location"];
        [mood setObject:[PFUser currentUser] forKey:@"author"];
        [mood saveInBackground];
    }
    
    else if ([segmentedControl selectedSegmentIndex] == 2) {
        NSLog(@"Better");
        PFObject *mood = [PFObject objectWithClassName:@"Mood"];
        [mood setObject:@1 forKey:@"moodValue"];
        if (currentCity)
            [mood setObject:currentCity forKey:@"location"];
        [mood setObject:[PFUser currentUser] forKey:@"author"];
        [mood saveInBackground];
    }

    */
    
    // Go to output view
    CADgraphViewController *graphVC = [[CADgraphViewController alloc] init];
    [self presentViewController:graphVC animated:YES completion:nil];
    
}

- (IBAction)settingsPage:(id)sender
{
    
     CADsettingsViewController *settingsVC = [[CADsettingsViewController alloc] initWithNibName:@"CADsettingsViewController" bundle:nil];
    [self presentViewController:settingsVC animated:YES completion:nil];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // self.overwriteBardo = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    /*
     
    if ([PFUser currentUser]) {
        //NSLog(@"%", [PFUser currentUser.id]);
        // Check if there is already a mood object for today and redirect to the Bardo
        
        if ([PFUser currentUser])
        {
            PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
            [query whereKey:@"author" equalTo:[PFUser currentUser]];
            [query orderByDescending:@"createdAt"];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (!object) {
                    NSLog(@"The getFirstObject request failed.");
                } else {
                    // The find succeeded.
                    NSDate *lastMoodDate = object.createdAt;
                    NSTimeInterval timeDeltaSeconds = [lastMoodDate timeIntervalSinceNow];
                    float timeDeltaHours = (timeDeltaSeconds / 3600) * (-1);
                    NSLog(@"Last mood created at: %@", object.createdAt);
                    NSLog(@"Time in hours since last entry: %f", timeDeltaHours);
                    
                    if (timeDeltaHours < 18) {
                        NSLog(@"Overwrite boolean set to: %d", self.overwriteBardo);
                        if (self.overwriteBardo == NO) {
                            //float waitTime = 18 - timeDeltaHours;
                            NSNumber *timeDeltaNumber = [NSNumber numberWithFloat:timeDeltaHours];
                            
                            CADbardoViewController *bardoVC = [[CADbardoViewController alloc] initWithNibName:@"CADbardoViewController" bundle:nil];
                            
                            bardoVC.countdown = timeDeltaNumber;
                            NSLog(@"Here's the value of bardoVC.countdown before being passed: %@", bardoVC.countdown);
                            [self presentViewController:bardoVC animated:YES completion:nil];
                        }
                    }
                }
            }];
        }
    }
    else {
        LoginViewController *inputVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self presentViewController:inputVC animated:YES completion:nil];
    }
    
    // Allow multiple lines in the date label
    self.dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.dateLabel.numberOfLines = 0;
    
    // Update label with user's first name
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // Success! Include your code to handle the results here
            NSString *nameString = [NSString stringWithFormat:@"Welcome, %@.", [result objectForKey:@"first_name"]];
            self.nameLabel.text = nameString;
        } else {
            // An error occurred, we need to handle the error
            NSLog(@"Error getting the current user's info, error message: %@", error);
        }
    }];
    
    */
    
    if (!currentCity) {
        // Get location data
        NSLog(@"No current city, getting location...");
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        geocoder = [[CLGeocoder alloc] init];
    }
    
    // Update label to reflect today's date and location
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    [timeFormat setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [timeFormat stringFromDate:date];
    
    dateString = [NSString stringWithFormat:@"It's %@ on %@.", currentTime, dateString];
    self.dateLabel.text = dateString;
    
    /*
    dateString = [NSString stringWithFormat:@"It's %@ on %@ in %@.\r\rWhat are you feeling right now?", currentTime, dateString, currentCity];
    self.dateLabel.text = dateString;
    */
    
    
}


@end
