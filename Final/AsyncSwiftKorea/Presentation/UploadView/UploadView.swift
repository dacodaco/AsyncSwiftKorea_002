import SwiftUI

struct UploadView: View {
    
    @ObservedObject var viewModel: UploadViewModel
    @State private var isAlertOn: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            ScoreIndicatorView()
            EmailTextField()
            RegisterButton()
        }
        .alert(viewModel.alertMessage ?? "메세지 없음",
               isPresented: $isAlertOn) {}
    }

    // 점수를 표시하는 View
    private func ScoreIndicatorView() -> some View {
        Text("당신의 점수는 \(viewModel.score) 입니다.")
            .font(.largeTitle)
    }

    // 등록할 이메일을 적는 View
    private func EmailTextField() -> some View {
        TextField("이메일을 입력해주세요", text: $viewModel.email)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
    }
    
    // 등록 버튼을 누르는 View
    private func RegisterButton() -> some View {
        Button {
            viewModel.buttonTapped {
                isAlertOn = true
            }
        } label: {
            Text("등록하기")
        }
        .buttonStyle(.borderedProminent)
    }
}
