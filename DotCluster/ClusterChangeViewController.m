//
//  XYZClusterChangeViewController.m
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import "ClusterChangeViewController.h"

@interface ClusterChangeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *clustersLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@end

@implementation ClusterChangeViewController

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
    
    self.clustersLabel.text = [self.valueNumber.stringValue stringByAppendingString:@" clusters"];
    
    [self.stepper setValue:self.valueNumber.doubleValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if (sender != self.doneButton) {
        self.valueNumber = nil;
        return;
    } else {
        self.valueNumber = [NSNumber numberWithDouble:self.stepper.value];
    }
}

- (IBAction)changeValue:(UIStepper *)sender
{
    NSString *valueString = [NSNumber numberWithDouble:sender.value].stringValue;
    
    self.clustersLabel.text = [valueString stringByAppendingString:@" clusters"];
}

@end
