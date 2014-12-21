//
//  CADkeyword.h
//  Cadence2
//
//  Created by Sachin Monga on 12/14/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CADkeyword : UIViewController {
    IBOutlet UITextField *keywordText;
}

@property(nonatomic, retain) IBOutlet UITextField *keywordText;
@property(nonatomic, assign) NSString *emotionFromInput;
@property(nonatomic) NSInteger *myValue;

@end


