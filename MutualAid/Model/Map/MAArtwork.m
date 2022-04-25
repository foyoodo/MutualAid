//
//  MAArtwork.m
//  MutualAid
//
//  Created by foyoodo on 2022/4/25.
//

#import "MAArtwork.h"
#import <Contacts/Contacts.h>

@interface MAArtwork ()

@property (nonatomic, copy) NSString *locationName;
@property (nonatomic, copy) NSString *discipline;

@end


@implementation MAArtwork

@synthesize title = _title;
@synthesize coordinate = _coordinate;

#pragma mark - Init Methods

- (instancetype)initWithFeature:(MKGeoJSONFeature *)feature {
    MKPointAnnotation *point = feature.geometry.firstObject;
    NSData *propertiesData = feature.properties;
    NSDictionary *properties = [NSJSONSerialization JSONObjectWithData:propertiesData options:0 error:nil];

    MAArtwork *ret = [self initWithTitle:properties[@"title"] locationName:properties[@"location"] coordinate:point.coordinate];
    ret.discipline = properties[@"discipline"];

    return ret;
}

- (instancetype)initWithTitle:(NSString *)title
                   coordinate:(CLLocationCoordinate2D)coordinate {
    return [self initWithTitle:title locationName:@"" coordinate:coordinate];
}

- (instancetype)initWithTitle:(NSString *)title
                 locationName:(NSString *)locationName
                   coordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [super init]) {
        _title = title;
        _locationName = locationName;
        _coordinate = coordinate;
    }
    return self;
}

#pragma mark - Getter

- (NSString *)subtitle {
    return self.locationName;
}

- (UIImage *)image {
    NSString *discipline = self.discipline;

    if ([discipline isEqualToString:@"aed"]) {
        return [UIImage imageNamed:@"aed"];
    } else if ([discipline isEqualToString:@"aid"]) {
        return [UIImage imageNamed:@"aid"];
    }

    return [UIImage imageNamed:@"aed"];
}

- (MKMapItem *)mapItem {
    MKPlacemark *plcemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:@{
        CNPostalAddressStreetKey: self.locationName
    }];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:plcemark];
    mapItem.name = self.title;
    return mapItem;
}

@end
