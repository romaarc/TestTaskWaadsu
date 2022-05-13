//
//  MapViewModel.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation
import MapKit

struct MapViewModel {
    let multiPolygon: MKMultiPolygon
    let distance: String
}

extension MapViewModel {
    init(features: [Feature]) {
        var fullDistance: Double = 0
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
            polygons.append(MKPolygon(
                coordinates: locationCoordinates,
                count: locationCoordinates.count
            ))
            
            for index in 0...locationCoordinates.count - 2 {
                let startLocation = MKMapPoint(locationCoordinates[index])
                let dest = MKMapPoint(locationCoordinates[index + 1])
                
                let distance = startLocation.distance(to: dest) / 1000
                fullDistance += distance
            }
        }
        self.multiPolygon = MKMultiPolygon(polygons)
        self.distance = "\(Int(fullDistance)) км"
    }
}
