//
//  MapViewModel.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation
import MapKit

struct MapViewModel {
    let type: String
    let features: [Feature]
    let coordinates: [CLLocationCoordinate2D]
    let multiPolygon: MKMultiPolygon
}

extension MapViewModel {
    init(type: String, features: [Feature]) {
        var polygons: [MKPolygon] = []
        var coordinates: [CLLocationCoordinate2D] = []
        
        for multiPolygon in features[0].geometry.coordinates {
            var locationCoordinates: [CLLocationCoordinate2D] = []
            multiPolygon.forEach { polygon in
                polygon.forEach { points in
                    let locationCoordinate = CLLocationCoordinate2D(latitude: points[1], longitude: points[0])
                    if CLLocationCoordinate2DIsValid(locationCoordinate) {
                        locationCoordinates.append(locationCoordinate)
                        coordinates.append(locationCoordinate)
                    }
                }
            }
            let polygon = MKPolygon(coordinates: locationCoordinates, count: locationCoordinates.count)
            polygons.append(polygon)
        }
        self.type = type
        self.features = features
        self.coordinates = coordinates
        self.multiPolygon = MKMultiPolygon(polygons)
    }
}
