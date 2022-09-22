import Foundation

// URLSession의 추상 타입 생성
protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

// URLSession이 추상 타입에 포함될 수 있도록 프로토콜 채택
extension URLSession: URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completion)
    }
}
