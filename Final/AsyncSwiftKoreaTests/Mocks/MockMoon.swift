import Foundation

final class MockMoon: MoonProtocol {
    var direction: Direction = .front
    var face: String {
        switch direction {
        case .front:
            return "🌝"
        case .left:
            return "🌛"
        case .right:
            return "🌜"
        }
    }
    
    func playChamChamCham() {
        direction = .right
    }
}
