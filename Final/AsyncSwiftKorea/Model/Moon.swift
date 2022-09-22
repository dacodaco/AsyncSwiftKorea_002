import Foundation

final class Moon: MoonProtocol {
    // 달이 바라보는 방향
    private(set) var direction: Direction = .front
    
    // 달의 얼굴 모습
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
    
    // 외부와 소통해 참참참을 진행하는 메서드
    func playChamChamCham() {
        direction = selectRandomDirection()
    }
    
    // 랜덤한 방향을 반환하는 메서드
    private func selectRandomDirection() -> Direction {
        return Direction.allCases.randomElement()!
    }
}
