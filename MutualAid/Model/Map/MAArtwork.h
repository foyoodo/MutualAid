//
//  MAArtwork.h
//  MutualAid
//
//  Created by foyoodo on 2022/4/25.
//

#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAArtwork : NSObject <MKAnnotation>

- (instancetype)initWithFeature:(MKGeoJSONFeature *)feature;

- (instancetype)initWithTitle:(NSString *)title
                   coordinate:(CLLocationCoordinate2D)coordinate;

- (instancetype)initWithTitle:(NSString *)title
                 locationName:(nullable NSString *)locationName
                   coordinate:(CLLocationCoordinate2D)coordinate;

@property (nonatomic, readonly, strong) UIImage *image;
@property (nonatomic, readonly, strong) MKMapItem *mapItem;

@end

NS_ASSUME_NONNULL_END
