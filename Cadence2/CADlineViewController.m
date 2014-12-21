//
//  CADlineViewController.m
//  Cadence2
//
//  Created by Sachin Monga on 8/30/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import "CADlineViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface CADlineViewController ()

@property (nonatomic, weak) IBOutlet UILabel *moodLabel;

@end

@implementation CADlineViewController

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
    
    // Set up string for mood label and allow multiple lines
    NSMutableString* moodLabelString = [NSMutableString string];
    self.moodLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.moodLabel.numberOfLines = 0;

    
    // Get current user moods
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d moods.", objects.count);
            // Update label view with mood values
            for (PFObject *object in objects) {
                //NSLog(@"%@", object[@"moodValue"]);
                [moodLabelString appendFormat:@"%@, ", object[@"moodValue"]];
                self.moodLabel.text = moodLabelString;
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)drawRect:(CGRect)rect
{
    // Create an oval shape to draw.
    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:
                           CGRectMake(0, 0, 200, 100)];
    
    // Set the render colors.
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    
    // If you have content to draw after the shape,
    // save the current state before changing the transform.
    //CGContextSaveGState(aRef);
    
    // Adjust the view's origin temporarily. The oval is
    // now drawn relative to the new origin point.
    CGContextTranslateCTM(aRef, 50, 50);
    
    // Adjust the drawing options as needed.
    aPath.lineWidth = 5;
    
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [aPath fill];
    [aPath stroke];
    
    // Restore the graphics state before drawing any other content.
    //CGContextRestoreGState(aRef);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
