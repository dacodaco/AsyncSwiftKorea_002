import Foundation

class MockURLSession: URLSessionProtocol {
    let dummyData = "dummy".data(using: .utf8)
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockURLSessionDataTask {
        let successResponse = HTTPURLResponse(url: URL(string: "https://chamchamcham-ea677-default-rtdb.asia-southeast1.firebasedatabase.app/persons.json")!,
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        var dataTask = MockURLSessionDataTask()
        dataTask.resumeDidCall = {
            completionHandler(self.dummyData, successResponse, nil)
        }
        return dataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var resumeDidCall: () -> Void = {}

    func resume() {
        resumeDidCall()
    }
}
