import SwiftUI

final class ChamChamViewModel: ObservableObject {

    @Published var fingerDirection: Direction = .front
    @Published var isDirectionMatched: Bool = false
    @Published var score: Int = 0
    let moon: MoonProtocol
    
    init(moon: MoonProtocol) {
        self.moon = moon
    }

    var fingerRotationAngle: Angle {
        switch fingerDirection {
        case .front:
            return Angle(degrees: 0)
        case .left:
            return Angle(degrees: -30)
        case .right:
            return Angle(degrees: 30)
        }
    }
    
    func playGame(with direction: Direction) {
        fingerDirection = direction
        moon.playChamChamCham()
        isDirectionMatched = checkDirectionMatched()
        score += giveScore(isMatched: isDirectionMatched)
    }
    
    func giveScore(isMatched: Bool) -> Int {
        return isMatched ? 10 : -5
    }

    func checkDirectionMatched() -> Bool {
        return moon.direction == fingerDirection ? true : false
    }
}
