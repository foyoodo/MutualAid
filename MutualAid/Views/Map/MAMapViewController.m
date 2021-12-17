//
//  MAMapViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/17.
//

#import "MAMapViewController.h"
#import <MapKit/MapKit.h>

@interface MAMapViewController ()

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MAMapViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    MKMapView *mapView = [MKMapView new];
    [self.view addSubview:(_mapView = mapView)];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    mapView.userTrackingMode = MKUserTrackingModeFollow;
}

#pragma mark - Private Methods



@end
