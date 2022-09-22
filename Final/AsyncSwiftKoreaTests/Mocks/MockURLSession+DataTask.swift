import Foundation

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var resumeDidCall: () -> Void = {}
    
    func resume() {
        resumeDidCall()
    }
}

final class MockURLSession: URLSessionProtocol {
    
    let dummyData = "DummyData".data(using: .utf8)
    let url = URL(string: "https://chamchamcham-ea677-default-rtdb.asia-southeast1.firebasedatabase.app/persons.json")!
    var condition: UploadError?
    
    private func makeResultValues(of condition: UploadError?) -> (Data?, HTTPURLResponse?, UploadError?) {
        switch condition {
        case .sessionError:
            return (nil, nil, .sessionError)
        case .responseIsNil:
            return (nil, nil, nil)
        case .unexpectedResponse:
            return (nil, HTTPURLResponse(url: url, statusCode: 300, httpVersion: "2", headerFields: nil), nil)
        case .unexpectedData:
            return (nil, HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2", headerFields: nil), nil)
        case .status_200:
            return (dummyData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2", headerFields: nil), nil)
        case .status_400:
            return (nil, HTTPURLResponse(url: url, statusCode: 404, httpVersion: "2", headerFields: nil), nil)
        case .status_500:
            return (nil, HTTPURLResponse(url: url, statusCode: 501, httpVersion: "2", headerFields: nil), nil)
        default:
            return (nil, nil, nil)
        }
    }
    
    func dataTask(
        with request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        let dataTask = MockURLSessionDataTask()
        dataTask.resumeDidCall = {
            let resultValues = self.makeResultValues(of: self.condition)

            completion(resultValues.0,
                       resultValues.1,
                       resultValues.2)
        }
        return dataTask
    }
}
