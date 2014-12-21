//
//  CADgraphViewController.m
//  Cadence2
//
//  Created by Sachin Monga on 8/31/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import "CADgraphViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface CADgraphViewController ()

@end

@implementation CADgraphViewController

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
    // Do any additional setup after loading the view.
    
    
    // Get array of current user's mood values
    
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            // figure out the max values and increment values based on # of moods
            
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenWidth = screenRect.size.width;
            CGFloat screenHeight = screenRect.size.height;
            double startingHeight = screenHeight / 2;
            
            double xIncrement = screenWidth / objects.count;
            
            NSLog(@"x-increment is %f", xIncrement);
            
            // Create path and starting point
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0.0, startingHeight)];
            
            CGPoint nextPoint;
            nextPoint.x = 0.0;
            nextPoint.y = 284.0;
            
            CGPoint controlPoint;
            controlPoint.x = 0.0;
            controlPoint.y = 284.0;
            
            
            // Loop through moods
            
            for (PFObject *object in objects) {
                
                // convert value from array into int
                int currentMood = [object[@"moodValue"] intValue];
                NSLog(@"%@", object[@"moodValue"]);
                
                // increment x-value regardless by the xIncrement amount
                nextPoint.x = nextPoint.x + xIncrement;
                
                // determine y-value increment
                if (currentMood == 1) {
                    nextPoint.y = nextPoint.y - 20.0;
                    // controlPoint.y = controlPoint.y - 20.0;
                } else if (currentMood == -1) {
                    nextPoint.y = nextPoint.y + 20.0;
                    // controlPoint.y = controlPoint.y + 20.0;
                } else {
                    nextPoint.y = nextPoint.y;
                }
                
                // determine control point
                // controlPoint.x = nextPoint.x - (xIncrement / 2);
                
                
                // draw next line segment
                [path addLineToPoint:CGPointMake(nextPoint.x, nextPoint.y)];
                
                // draw line using quadratic curve
                // [path addQuadCurveToPoint:CGPointMake(nextPoint.x, nextPoint.y)
                //             controlPoint:CGPointMake(controlPoint.x, controlPoint.y)];
            }
            
            for (int i = 0; i < objects.count; i++) {
                
            }
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
            shapeLayer.lineWidth = 3.0;
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            
            [self.view.layer addSublayer:shapeLayer];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
