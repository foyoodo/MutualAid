//
//  MAMapViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/17.
//

#import "MAMapViewController.h"
#import "MAMapPanView.h"
#import "MASearchBar.h"
#import "MASearchViewController.h"
#import "MASearchNavigationControllerDelegate.h"
#import <MapKit/MapKit.h>

@interface MAMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, MASearchBarDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) MAMapPanView *panView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) MASearchNavigationControllerDelegate *navigationControllerDelegate;

@end

@implementation MAMapViewController

@synthesize searchBar = _searchBar;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    self.panView.searchBar = self.searchBar;
    [self.panView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.panView);
    }];

    [self.panView presentInView:self.view];

    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];

    self.navigationController.delegate = self.navigationControllerDelegate;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location.coordinate, 1000, 1000);
        [self.mapView setRegion:region animated:YES];
    });
}

#pragma mark - Private Methods

#pragma mark - MASearchBarDelegate

- (void)searchBarDidClick {
    MASearchViewController *searchVC = [MASearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - Getter & Setter

- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}

- (MAMapPanView *)panView {
    if (!_panView) {
        _panView = [MAMapPanView new];
        _panView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    }
    return _panView;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (MASearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [MASearchBar new];
        _searchBar.frame = CGRectMake(0, 0, 0, _searchBar.height);
        _searchBar.backgroundColor = UIColor.systemGroupedBackgroundColor;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (MASearchNavigationControllerDelegate *)navigationControllerDelegate {
    if (!_navigationControllerDelegate) {
        _navigationControllerDelegate = [MASearchNavigationControllerDelegate new];
    }
    return _navigationControllerDelegate;
}

@end
