//
//  MAMapPointViewController.m
//  MutualAid
//
//  Created by foyoodo on 2022/4/25.
//

#import "MAMapPointViewController.h"
#import <MapKit/MapKit.h>
#import "MAArtwork.h"

@interface MAMapPointViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MAMapPointViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    MKMapView *mapView = [MKMapView new];
    mapView.delegate = self;
    [self.view addSubview:(_mapView = mapView)];

    // Set initial location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(24.604467099365998, 118.08799088001251), 5000, 5000);
    [self.mapView setRegion:region animated:NO];

    self.title = @"急救地图";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
}

- (void)viewDidLayoutSubviews {
    self.mapView.frame = self.view.bounds;
}

#pragma mark - Public Methods

- (void)pointToTargetAnnotation:(id<MKAnnotation>)annotation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000);
    [self.mapView setRegion:region animated:YES];

    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
}

#pragma mark - Private Methods

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (![annotation isKindOfClass:MAArtwork.class]) {
        return nil;
    }

    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"id"];
    if (!view) {
        view = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"id"];
        view.canShowCallout = YES;
        view.calloutOffset = CGPointMake(0, 20);
        ((MKMarkerAnnotationView *)view).glyphImage = [UIImage systemImageNamed:@"cross.circle.fill"];

        UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        [mapButton setBackgroundImage:[UIImage imageNamed:@"apple_map"] forState:UIControlStateNormal];
        view.rightCalloutAccessoryView = mapButton;
    }

    return view;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if (![view.annotation isKindOfClass:MAArtwork.class]) {
        return;
    }
    MAArtwork *artwork = (MAArtwork *)view.annotation;
    BOOL success = [artwork.mapItem openInMapsWithLaunchOptions:@{
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
    }];
    if (!success) {
        [MAToast showMessage:@"未安装Apple地图" inView:self.view];
    }
}

@end
