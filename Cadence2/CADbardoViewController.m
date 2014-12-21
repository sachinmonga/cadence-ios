//
//  CADbardoViewController.m
//  Cadence2
//
//  Created by Sachin Monga on 9/1/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import "CADbardoViewController.h"
#import "CADgraphViewController.h"
#import "CADsettingsViewController.h"
#import "CADinputViewController.h"

@interface CADbardoViewController ()

@property (nonatomic, weak) IBOutlet UILabel *countdownLabel;

@end

@implementation CADbardoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSString *stringCountdown = [self.countdown stringValue];
        NSLog(@"Countdown from init is: %@", self.countdown);
        // self.countdownLabel.text = stringCountdown;
    }
    return self;
}

- (IBAction)seeCadence:(id)sender
{
    // Go to output view
    CADgraphViewController *graphVC = [[CADgraphViewController alloc] init];
    [self presentViewController:graphVC animated:YES completion:nil];
}

- (IBAction)seeSettings:(id)sender
{
    // Go to output view
    CADsettingsViewController *settingsVC = [[CADsettingsViewController alloc] init];
    [self presentViewController:settingsVC animated:YES completion:nil];
}

- (IBAction)gotoInput:(id)sender
{
    // Go to input view anyways
    CADinputViewController *inputVC = [[CADinputViewController alloc] init];
    inputVC.overwriteBardo = YES;
    [self presentViewController:inputVC animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    int hours = floor([self.countdown doubleValue]);
    int minutes = ([self.countdown doubleValue] - hours) * 60;
    
    // NSString *stringCountdown = [self.countdown stringValue];
    NSLog(@"Countdown from viewDidLoad is: %@", self.countdown);
    
    // Allow multiple lines in the date label
    self.countdownLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.countdownLabel.numberOfLines = 0;
    
    self.countdownLabel.text = [NSString stringWithFormat:@"Your last entry was only %d hours and %d minutes ago.", hours, minutes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
