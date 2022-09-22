import XCTest
import SwiftUI
@testable import AsyncSwiftKorea

class UploadViewModelTests: XCTestCase {
    
    var uploadViewModel: UploadViewModel?
    let urlSession = MockURLSession()
    
    func test_statusCode200인경우_Error가_나오지않는가() {
        let expectation = XCTestExpectation()
        var error: UploadError? = .unexpectedData
        urlSession.condition = .status_200
        uploadViewModel = UploadViewModel(urlSession: urlSession, score: 100)
        uploadViewModel?.registerScore { result in
            switch result {
            case .success:
                error = nil
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(error)
    }

    func test_statusCode400인경우_status400Error가_반환되는가() {
        let expectation = XCTestExpectation()
        var error: UploadError? = .unexpectedData
        urlSession.condition = .status_400
        uploadViewModel = UploadViewModel(urlSession: urlSession, score: 100)
        uploadViewModel?.registerScore { result in
            switch result {
            case .success:
                XCTFail()
            case let .failure(failureError):
                error = failureError
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(error, .status_400)
    }
    
    func test_statusCode500인경우_status500Error가_반환되는가() {
        let expectation = XCTestExpectation()
        var error: UploadError? = .unexpectedData
        urlSession.condition = .status_500
        uploadViewModel = UploadViewModel(urlSession: urlSession, score: 100)
        uploadViewModel?.registerScore { result in
            switch result {
            case .success:
                XCTFail()
            case let .failure(failureError):
                error = failureError
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(error, .status_500)
    }
    
    func test_sessionError시_원하는에러결과가도출되는가() {
        let expectation = XCTestExpectation()
        var error: UploadError? = nil
        urlSession.condition = .sessionError
        uploadViewModel = UploadViewModel(urlSession: urlSession, score: 100)
        uploadViewModel?.registerScore { result in
            switch result {
            case .success:
                XCTFail()
            case let .failure(failureError):
                error = failureError
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(error, .sessionError)
    }
    
    func test_unexpectedResponseCode일시_원하는에러결과가도출되는가() {
        let expectation = XCTestExpectation()
        var error: UploadError? = nil
        urlSession.condition = .unexpectedResponse
        uploadViewModel = UploadViewModel(urlSession: urlSession, score: 100)
        uploadViewModel?.registerScore { result in
            switch result {
            case .success:
                XCTFail()
            case let .failure(failureError):
                error = failureError
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(error, .unexpectedResponse)
    }

    func test_unexpectedData일시_원하는에러결과가도출되는가() {
        let expectation = XCTestExpectation()
        var error: UploadError? = nil
        urlSession.condition = .unexpectedData
        uploadViewModel = UploadViewModel(urlSession: urlSession, score: 100)
        uploadViewModel?.registerScore { result in
            switch result {
            case .success:
                XCTFail()
            case let .failure(failureError):
                error = failureError
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(error, .unexpectedData)
    }
    
    func test_response가_오지않은경우_원하는에러가도출되는가() {
        let expectation = XCTestExpectation()
        var error: UploadError? = nil
        urlSession.condition = .responseIsNil
        uploadViewModel = UploadViewModel(urlSession: urlSession, score: 100)
        uploadViewModel?.registerScore { result in
            switch result {
            case .success:
                XCTFail()
            case let .failure(failureError):
                error = failureError
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(error, .responseIsNil)
    }

}
