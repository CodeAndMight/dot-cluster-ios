//
//  XYZDotClusterViewController.m
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import "DotClusterViewController.h"
#import "ClusterChangeViewController.h"
#import "ClusterView.h"

#import "Cluster.h"

@interface DotClusterViewController ()

@property (strong, nonatomic) Cluster *cluster;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *testBarButtonItem;

- (IBAction)cleanupPoints:(id)sender;

@end

@implementation DotClusterViewController

- (IBAction)unwindToCluster:(UIStoryboardSegue *)segue
{
    ClusterChangeViewController *source = [segue sourceViewController];
    NSNumber *valueNumber = source.valueNumber;
    
    if (valueNumber != nil) {
        self.testBarButtonItem.title = valueNumber.stringValue;
        self.cluster.number = valueNumber;
    }
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
    // Do any additional setup after loading the view.
    
    self.cluster = [[Cluster alloc] init];
    self.clusterView.cluster = self.cluster;
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
    UINavigationController *nc = [segue destinationViewController];
    
    for (UIViewController *vc in nc.viewControllers) {
        if ([vc isKindOfClass:[ClusterChangeViewController class]]) {
            ClusterChangeViewController *controller = (ClusterChangeViewController *)vc;
            controller.valueNumber = self.cluster.number;
        }
    }
}

- (IBAction)cleanupPoints:(id)sender
{
    [self.cluster clear];
    [self.clusterView setNeedsDisplay];
}

- (IBAction)testCluster:(id)sender
{
    if (![self.cluster isValid]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The number of points is less than the number of clusters." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        
        [alertView show];
        return;
    }
    
    [self.cluster test];
    [self.clusterView setNeedsDisplay];
}

@end
