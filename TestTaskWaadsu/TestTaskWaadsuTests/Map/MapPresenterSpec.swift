//
//  MapPresenterSpec.swift
//  TestTaskWaadsuTests
//
//  Created by Roman Gorshkov on 14.05.2022.
//
import Quick
import Nimble
@testable import TestTaskWaadsu

class MapPresenterSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: MapPresenter!
        
        // MARK: - Test Doubles
        var viewControllerProtocol: MapViewControllerProtocolSpy!
        
        // MARK: - Tests
        ///Перед тестом устанавливаем переменные
        beforeEach {
            setupPresenter()
            setupDisplayLogic()
        }
        ///После теста зануляем объект под тестирование
        afterEach {
            sut = nil
        }
        
        // MARK: Use Cases
        describe("present fetch maps data from interactor") {
            it("should ask view controller to display", closure: {
                // given
                let features = [Feature(
                    type: "Feature",
                    properties: Properties(scalerank: 0, featurecla: "", labelrank: 1, sovereignt: "", sovA3: "", adm0DIF: 7, level: 7, type: "", admin: "", adm0A3: "", geouDIF: 7, geounit: "", guA3: "", suDIF: 7, subunit: "", suA3: "", brkDiff: 7, name: "", nameLong: "", brkA3: "", brkName: "", brkGroup: nil, abbrev: "", postal: "", formalEn: "", formalFr: nil, noteAdm0: nil, noteBrk: nil, nameSort: "", nameAlt: nil, mapcolor7: 1, mapcolor8: 7, mapcolor9: 1, mapcolor13: 1, popEst: 1, gdpMdEst: 1, popYear: 1, lastcensus: 1, gdpYear: 1, economy: "", incomeGrp: "", wikipedia: 1, fips10_: "", isoA2: "", isoA3: "", isoN3: "", unA3: "", wbA2: "", wbA3: "", woeID: 1, woeIDEh: 1, woeNote: "", adm0A3Is: "", adm0A3Us: "", adm0A3Un: 1, adm0A3Wb: 1, continent: "", regionUn: "", subregion: "", regionWb: "", nameLen: 1, longLen: 1, abbrevLen: 1, tiny: 1, homepart: 1, filename: ""),
                    geometry: Geometry(type: "LineString", coordinates: [[[[132.44898522200018,42.845404364],[132.44988040500007,42.82811107000001],[132.4674585300002,42.81093984600007],[132.47771243600013,42.803900458]]]]))]
                let response = Map.MapLoad.Response(result: .success(features))
                
                // when
                sut.presentMap(response: response)
                
                // then
                expect(viewControllerProtocol.displayWasMap).to(beTrue())
            })
        }
        
        // MARK: - Test Helpers
        func setupPresenter() {
            sut = MapPresenter()
        }
        
        func setupDisplayLogic() {
            viewControllerProtocol = MapViewControllerProtocolSpy()
            sut.viewController = viewControllerProtocol
        }
    }
}

// MARK: - Test Doubles
extension MapPresenterSpec {
    class MapViewControllerProtocolSpy: MapViewControllerProtocol {
        
        // MARK: Spied Methods
        var displayWasMap = false
        var displayMapViewModel: MapViewModel?
        func displayMap(viewModel: Map.MapLoad.ViewModel) {
            displayWasMap = true
            displayMapViewModel = viewModel.data
        }
        
    }
}
