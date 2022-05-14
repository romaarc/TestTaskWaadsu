//
//  MapInteractorSpec.swift
//  TestTaskWaadsuTests
//
//  Created by Roman Gorshkov on 15.05.2022.
//

import Quick
import Nimble
import PromiseKit
@testable import TestTaskWaadsu

class MapInteractorSpec: QuickSpec {
    override func spec() {
        
        // MARK: - Subject Under Test (SUT)
        var sut: MapInteractor!
        
        // MARK: - Test Doubles
        var presenterSpy: MapPresenterProtocolSpy!
        var providerSpy: MapProviderProtocolSpy!
        
        // MARK: - Tests
        beforeEach {
            setup()
        }
        
        afterEach {
            sut = nil
        }
        
        // MARK: Use Cases
        describe("Fetch geoJSON data from provider") {
            beforeEach {
                //when
                sut.doMapUpdate(request: .init())
            }
            it("should ask provider to fetch maps data and presenter to present maps data") {
                expect(providerSpy.methodWasRun).to(beTrue())
                providerSpy.fetch().done { _ in
                    expect(presenterSpy.presentMapCalled).to(beTrue())
                }.catch { _ in
                    expect(presenterSpy.presentMapCalled).to(beTrue())
                }
            }
        }
        
        // MARK: - Test Helpers
        func setup() {
            presenterSpy = MapPresenterProtocolSpy()
            providerSpy = MapProviderProtocolSpy()
            sut = MapInteractor(
                presenter: presenterSpy,
                provider: providerSpy)
        }
    }
}

extension MapInteractorSpec {
    class MapPresenterProtocolSpy: MapPresenterProtocol {
        //MARK: Spied Method
        var presentMapCalled = false
        var presentMapResponse: Map.MapLoad.Response?
        func presentMap(response: Map.MapLoad.Response) {
            presentMapCalled = true
            presentMapResponse = response
        }
    }
    
    class MapProviderProtocolSpy: MapProviderProtocol {
        //MARK: Spied Method
        var methodWasRun = false
        func fetch() -> Promise<[Feature]> {
            methodWasRun = true
            return Promise { seal in
                seal.fulfill([Feature(
                    type: "Feature",
                    properties: Properties(scalerank: 0, featurecla: "", labelrank: 1, sovereignt: "", sovA3: "", adm0DIF: 7, level: 7, type: "", admin: "", adm0A3: "", geouDIF: 7, geounit: "", guA3: "", suDIF: 7, subunit: "", suA3: "", brkDiff: 7, name: "", nameLong: "", brkA3: "", brkName: "", brkGroup: nil, abbrev: "", postal: "", formalEn: "", formalFr: nil, noteAdm0: nil, noteBrk: nil, nameSort: "", nameAlt: nil, mapcolor7: 1, mapcolor8: 7, mapcolor9: 1, mapcolor13: 1, popEst: 1, gdpMdEst: 1, popYear: 1, lastcensus: 1, gdpYear: 1, economy: "", incomeGrp: "", wikipedia: 1, fips10_: "", isoA2: "", isoA3: "", isoN3: "", unA3: "", wbA2: "", wbA3: "", woeID: 1, woeIDEh: 1, woeNote: "", adm0A3Is: "", adm0A3Us: "", adm0A3Un: 1, adm0A3Wb: 1, continent: "", regionUn: "", subregion: "", regionWb: "", nameLen: 1, longLen: 1, abbrevLen: 1, tiny: 1, homepart: 1, filename: ""),
                    geometry: Geometry(type: "LineString", coordinates: [[[[132.44898522200018,42.845404364],[132.44988040500007,42.82811107000001],[132.4674585300002,42.81093984600007],[132.47771243600013,42.803900458]]]]))])
            }
        }
    }
}
