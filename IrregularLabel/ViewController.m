//
//  ViewController.m
//  IrregularLabel
//
//  Created by TinXie on 2018/4/11.
//  Copyright © 2018年 TinXie. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "TinIrregularLabel.h"

@interface ViewController () <MKMapViewDelegate>

@end

@implementation ViewController {
    __weak IBOutlet MKMapView *map;
    MKCoordinateRegion r;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    map.delegate = self;

    [self setCenterLocation];
    [self addPointAnnotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 設置當前地圖中心位子
 */
- (void)setCenterLocation {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:25.07759 longitude:121.57270];
    r.center = location.coordinate;
    r.span = MKCoordinateSpanMake(0.09, 0.09);
    [map setRegion:r animated:YES];
}

/**
 加入地圖標記
 */
- (void)addPointAnnotation {
    MKPointAnnotation * point1;
    point1 = [[MKPointAnnotation alloc] init];
    point1.title = @"這是標記1";
    point1.subtitle = @"這是副標題";
    point1.coordinate = CLLocationCoordinate2DMake(25.07759, 121.57270);
    [map addAnnotation:point1];

    MKPointAnnotation * point2;
    point2 = [[MKPointAnnotation alloc] init];
    point2.title = @"這是標記2";
    point2.subtitle = @"這是副標題";
    point2.coordinate = CLLocationCoordinate2DMake(25.07959, 121.57670);
    [map addAnnotation:point2];

}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    userLocation.title = @"用戶當前位子的標題";
    userLocation.subtitle = @"用戶當前位子的標題";
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }

    static NSString *ID2 = @"annotationView";

    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID2];

    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID2] ;

        TinIrregularLabel *lbl = [[TinIrregularLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        lbl.tag = 42; // 標記作為修改 textString 使用
        [annotationView addSubview:lbl];

        annotationView.canShowCallout = YES;
        annotationView.frame = lbl.frame;
    } else {
        annotationView.annotation = annotation;
    }
    TinIrregularLabel *lbl = (TinIrregularLabel *)[annotationView viewWithTag:42];
    lbl.text = annotation.title;
    [lbl sizeToFit];
    lbl.frame = CGRectMake(0, -5, lbl.frame.size.width + 5, lbl.frame.size.height + 15);
    [lbl changeUI];

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        annotationView.detailCalloutAccessoryView = [[UISwitch alloc] init];
    }

    return annotationView;


}


@end
