//
//  MapaViewController.m
//  ContatosIP67
//
//  Created by ios2749 on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapaViewController.h"
#import <MapKit/MKUserTrackingBarButtonItem.h>
#import <MapKit/MKMapView.h>

@interface MapaViewController ()

@end

@implementation MapaViewController

@synthesize mapa;

-(id)init
{
    self = [super init];
    if(self)
    {
        //self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
        self.title = @"Mapa";
        self.tabBarItem.image = [UIImage imageNamed:@"mapa-contatos.png"];
        
    }
    return self;
}

-(void)centralizaMapa
{
    // do
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
    
    self.navigationItem.leftBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
