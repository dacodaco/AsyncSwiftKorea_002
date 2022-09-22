import Foundation

enum UploadError: String, Error {
    case sessionError = "네트워크 통신에 문제가 있습니다."
    case responseIsNil = "서버 응답이 오지 않았습니다."
    case unexpectedResponse = "예상치못한 서버응답이 왔습니다."
    case unexpectedData = "예상치못한 데이터를 수신했습니다."
    case status_200 = "예상한 응답이 왔습니다."
    case status_400 = "잘못된 요청입니다."
    case status_500 = "서버 오류입니다."
}
