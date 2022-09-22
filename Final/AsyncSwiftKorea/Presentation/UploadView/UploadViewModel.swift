import SwiftUI

final class UploadViewModel: ObservableObject {
    @Published var email: String = ""
    var alertMessage: String?
    var urlSession: URLSessionProtocol
    let score: Int
    
    init(urlSession: URLSessionProtocol = URLSession.shared, score: Int) {
        self.urlSession = urlSession
        self.score = score
    }
    
    // 점수등록 버튼이 눌렸을 때 불리는 메서드
    func buttonTapped(completion: @escaping () -> Void) {
        registerScore { [weak self] result in
            self?.alertMessage = self?.makeAlertMessage(of: result)
            completion()
        }
    }

    // 점수를 서버에 등록하고 응답 결과를 분기처리하는 메서드
    func registerScore(completion: @escaping (Result<Data, UploadError>) -> Void) {
        let urlRequest = makeURLRequest()
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.sessionError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseIsNil))
                return
            }
            
            switch httpResponse.statusCode {
            case (200...299):
                guard let data = data else {
                    completion(.failure(.unexpectedData))
                    
                    return
                }
                completion(.success(data))
            case (400...499):
                completion(.failure(.status_400))
            case (500...599):
                completion(.failure(.status_500))
            default:
                completion(.failure(.unexpectedResponse))
            }
        }
        .resume()
    }
    
    // 결과에 따라 Alert에 보낼 메세지를 만들어주는 메서드
    func makeAlertMessage(of result: Result<Data, UploadError>) -> String {
        switch result {
        case .success(_):
            return "성공했습니다!"
        case let .failure(error):
            return error.rawValue
        }
    }

    // URLRequest를 만들어주는 메서드
    private func makeURLRequest() -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: "https://chamchamcham-ea677-default-rtdb.asia-southeast1.firebasedatabase.app/persons.json")!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = Record(mail: email, score: score).encode()
        return urlRequest
    }
}
