import Foundation

enum Map {
    ///Show maps data
    enum MapLoad {
        struct Response {
            let result: Result<[Feature], Error>
        }

        struct ViewModel {
            let data: MapViewModel
        }
    }
    
    /// Update map
    enum MapUpdate {
        struct Request {}
    }
}
