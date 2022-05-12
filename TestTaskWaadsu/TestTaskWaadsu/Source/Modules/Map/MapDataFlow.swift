import Foundation

enum Map {
    enum SomeAction {
        struct Request { }

        struct Response {
            let result: Result<[Feature], Error>
        }

        struct ViewModel {
            let data: MapViewModel
        }
    }
}
