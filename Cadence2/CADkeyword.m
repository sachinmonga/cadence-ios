//
//  CADkeyword.m
//  Cadence2
//
//  Created by Sachin Monga on 12/14/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import "CADkeyword.h"
#import "CADinputViewController.h"
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface CADkeyword ()

@end

@implementation CADkeyword

@synthesize keywordText;
@synthesize emotionFromInput;

-(IBAction)saveKeywords:(id)sender
{

    NSString *keywordTextInput;
    
    if([keywordText.text length] == 0)
    {
        keywordTextInput = @"None";
    }
    else
    {
        keywordTextInput = keywordText.text;
    }
    
    PFObject *emotion = [PFObject objectWithClassName:@"Emotion"];
    [emotion setObject:emotionFromInput forKey:@"feeling"];
    [emotion setObject:[PFUser currentUser] forKey:@"user"];
    [emotion setObject:keywordTextInput forKey:@"keywords"];
    [emotion saveInBackground];
    
    NSLog(keywordTextInput);
    NSLog(emotionFromInput);
    
    keywordText.text = @"Saved.";
    
    [self.keywordText endEditing:YES];
    
}

-(IBAction)goBack:(id)sender
{
    CADinputViewController *inputVC = [[CADinputViewController alloc] initWithNibName:@"CADinputViewController" bundle:nil];
    [self presentViewController:inputVC animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.keywordText becomeFirstResponder];
    self.keywordText.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/* - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
} */

@end


