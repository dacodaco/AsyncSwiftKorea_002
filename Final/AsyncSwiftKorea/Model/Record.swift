import Foundation

struct Record: Codable {
    let mail: String
    let score: Int
    
    func encode() -> Data {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(self)
            return data
        } catch {
            fatalError()
        }
    }
}
