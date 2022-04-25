//
//  MAMapViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/17.
//

#import "MAMapViewController.h"
#import <MapKit/MapKit.h>
#import "MAMapPanView.h"
#import "MASearchBar.h"
#import "MASearchViewController.h"
#import "MASearchNavigationControllerDelegate.h"
#import "MAArtwork.h"

@interface MAMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, MASearchBarDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) MAMapPanView *panView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) MASearchNavigationControllerDelegate *navigationControllerDelegate;

@property (nonatomic, strong) NSMutableArray<MAArtwork *> *artworks;

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

    // Set initial location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(24.604467099365998, 118.08799088001251), 5000, 5000);
    [self.mapView setRegion:region animated:NO];

    [self loadInitialArtworks];
    [self.mapView addAnnotations:self.artworks];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location.coordinate, 1000, 1000);
        [self.mapView setRegion:region animated:YES];
    });
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (![annotation isKindOfClass:MAArtwork.class]) {
        return nil;
    }

    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"id"];
    if (!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"id"];
        view.canShowCallout = YES;
        view.calloutOffset = CGPointMake(0, 5);

        UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        [mapButton setBackgroundImage:[UIImage imageNamed:@"apple_map"] forState:UIControlStateNormal];
        view.rightCalloutAccessoryView = mapButton;
    }

    MAArtwork *artwork = annotation;
    view.image = artwork.image;

    return view;
}

#pragma mark - Private Methods

- (void)loadInitialArtworks {
    NSURL *fileName = [[NSBundle mainBundle] URLForResource:@"PublicArt" withExtension:@"geojson"];
    NSData *artworkData = [NSData dataWithContentsOfURL:fileName];

    MKGeoJSONDecoder *decoder = [[MKGeoJSONDecoder alloc] init];
    NSError *error = nil;
    NSArray *features = [decoder geoJSONObjectsWithData:artworkData error:&error];

    if (!error) {
        [features enumerateObjectsUsingBlock:^(id<MKGeoJSONObject>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MKGeoJSONFeature *feature = obj;
            MAArtwork *artwork = [[MAArtwork alloc] initWithFeature:feature];
            [self.artworks addObject:artwork];
        }];
    } else {
        NSLog(@"%@", error);
    }
}

#pragma mark - MASearchBarDelegate

- (void)searchBarDidClick {
    MASearchViewController *searchVC = [MASearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - MKMapViewDelegate

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

- (NSMutableArray *)artworks {
    if (!_artworks) {
        _artworks = [NSMutableArray array];
    }
    return _artworks;
}

@end
