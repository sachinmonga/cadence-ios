//
//  LoginViewController.m
//  Cadence2
//
//  Created by Sachin Monga on 8/30/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import "LoginViewController.h"
#import "CADinputViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_friends", @"email", @"user_actions.music", @"user_actions.fitness", @"user_relationships", @"user_birthday", @"user_location"];
    
    NSLog(@"About to call FB Login");
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {

        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            
            NSLog(@"User with facebook signed up and logged in!");
            
            // Go to next screen (input view)
            CADinputViewController *inputVC = [[CADinputViewController alloc] initWithNibName:@"CADinputViewController" bundle:nil];
            [self presentViewController:inputVC animated:YES completion:nil];
            
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Store the current user's Facebook ID on the user
                    [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                             forKey:@"fbId"];
                    [[PFUser currentUser] saveInBackground];
                }
            }];
            
            
        } else if (user) {
            
            NSLog(@"FB Authentication is being called");
            
            NSLog(@"User with facebook logged in!");
            
            // Update label with user's first name
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Success! Include your code to handle the results here
                    NSString *nameString = [NSString stringWithFormat:@"Welcome, %@.", [result objectForKey:@"first_name"]];
                    NSLog(@"%@", nameString);
                } else {
                    // An error occurred, we need to handle the error
                    NSLog(@"Error getting the current user's info, error message: %@", error);
                }
            }];
            
            // Go to next screen (input view)
            CADinputViewController *inputVC = [[CADinputViewController alloc] initWithNibName:@"CADinputViewController" bundle:nil];
            [self presentViewController:inputVC animated:YES completion:nil];
            
        }
    }];
    
}


@end
