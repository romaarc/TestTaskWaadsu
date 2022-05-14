//
//  MapProviderSpec.swift
//  TestTaskWaadsuTests
//
//  Created by Roman Gorshkov on 14.05.2022.
//

import Quick
import Nimble
import PromiseKit
@testable import TestTaskWaadsu

class MapProviderSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: MapProvider!
        
        // MARK: - Test Doubles
        var providerSpy: MapProviderProtocolSpy!
        
        // MARK: - Tests
        beforeEach {
            setup()
        }
        
        afterEach {
            remove()
            sut = nil
        }
        
        // MARK: Use Cases
        describe("fetch data") {
            it("should fetch data from API") {
                //when
                sut.fetch().done { _ in }.catch { _ in }
                //then
                providerSpy.fetch().done { _ in }.catch { _ in }
            }
        }
        
        // MARK: - Test Helpers
        func setup() {
            providerSpy = MapProviderProtocolSpy()
            sut = MapProvider(mapNetworkService: NetworkService())
        }
        
        func remove() {
            providerSpy = nil
        }
    }
}

// MARK: - Test Doubles
extension MapProviderSpec {
    class MapProviderProtocolSpy: MapProviderProtocol {
        //MARK: Spied Method
        func fetch() -> Promise<[Feature]> {
            return Promise { seal in
                seal.fulfill([Feature(
                    type: "Feature",
                    properties: Properties(scalerank: 0, featurecla: "", labelrank: 1, sovereignt: "", sovA3: "", adm0DIF: 7, level: 7, type: "", admin: "", adm0A3: "", geouDIF: 7, geounit: "", guA3: "", suDIF: 7, subunit: "", suA3: "", brkDiff: 7, name: "", nameLong: "", brkA3: "", brkName: "", brkGroup: nil, abbrev: "", postal: "", formalEn: "", formalFr: nil, noteAdm0: nil, noteBrk: nil, nameSort: "", nameAlt: nil, mapcolor7: 1, mapcolor8: 7, mapcolor9: 1, mapcolor13: 1, popEst: 1, gdpMdEst: 1, popYear: 1, lastcensus: 1, gdpYear: 1, economy: "", incomeGrp: "", wikipedia: 1, fips10_: "", isoA2: "", isoA3: "", isoN3: "", unA3: "", wbA2: "", wbA3: "", woeID: 1, woeIDEh: 1, woeNote: "", adm0A3Is: "", adm0A3Us: "", adm0A3Un: 1, adm0A3Wb: 1, continent: "", regionUn: "", subregion: "", regionWb: "", nameLen: 1, longLen: 1, abbrevLen: 1, tiny: 1, homepart: 1, filename: ""),
                    geometry: Geometry(type: "LineString", coordinates: [[[[132.44898522200018,42.845404364],[132.44988040500007,42.82811107000001],[132.4674585300002,42.81093984600007],[132.47771243600013,42.803900458]]]]))])
            }
        }
    }
}
