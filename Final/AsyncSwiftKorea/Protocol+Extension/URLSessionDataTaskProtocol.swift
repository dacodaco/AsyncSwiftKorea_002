import Foundation

// URLSessionDataTask의 추상 타입 생성
protocol URLSessionDataTaskProtocol {
    func resume()
}

// URLSessionDataTask가 추상 타입에 포함될 수 있도록 프로토콜 채택
extension URLSessionDataTask: URLSessionDataTaskProtocol {}
