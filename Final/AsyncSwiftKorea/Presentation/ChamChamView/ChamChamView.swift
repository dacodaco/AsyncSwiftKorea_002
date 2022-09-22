import SwiftUI

struct ChamChamView: View {
    
    @ObservedObject var viewModel: ChamChamViewModel
    @State var isSheetOpened: Bool = false
    
    var body: some View {
        VStack {
            MoonView()
            InformationView()
            FingerMotionView()
        }
        .sheet(isPresented: $isSheetOpened) {
            let score = viewModel.score
            let uploadViewModel = UploadViewModel(score: score)
            UploadView(viewModel: uploadViewModel)
        }
        .overlay {
            ParticleView()
        }
    }

    // 손가락의 방향을 결정하는 버튼
    private func SelectDirectionButton(with direction: Direction) -> some View {
        Button {
            viewModel.playGame(with: direction)
        } label: {
            Text(direction.rawValue)
                .font(.system(size: 100))
        }
    }
    
    // 달의 방향에 따른 모습을 표시하는 View
    private func MoonView() -> some View {
        Text(viewModel.moon.face)
            .font(.system(size: 150))
    }
    
    // 연속 점수, 등록 버튼을 표시하는 View
    @ViewBuilder
    private func InformationView() -> some View {
        Spacer()
        Text("연속 점수: \(viewModel.score)")
        OpenRegisterSheetButton()
        Spacer()
    }
    
    // 손가락의 방향에 따른 모습을 표시하는 View
    @ViewBuilder
    private func FingerMotionView() -> some View {
        SelectDirectionButton(with: .front)
        HStack {
            SelectDirectionButton(with: .left)
            Text("👆")
                .font(.system(size: 150))
                .rotationEffect(viewModel.fingerRotationAngle)
            SelectDirectionButton(with: .right)
        }
    }

    // 점수 등록 Sheet를 띄우는 버튼
    private func OpenRegisterSheetButton() -> some View {
        Button {
            isSheetOpened = true
        } label: {
            Text("점수 등록하기")
        }
        .buttonStyle(.bordered)
    }
    
    // 애니메이션을 활용하기 위한 버튼
    @ViewBuilder
    private func ParticleView() -> some View {
        if viewModel.isDirectionMatched {
            Circle()
                .fill(.red)
                .frame(width: 12, height: 12)
                .modifier(ParticlesModifier())
            
            Circle()
                .fill(.green)
                .frame(width: 12, height: 12)
                .modifier(ParticlesModifier())
        }
    }
}

struct ChamChamView_Previews: PreviewProvider {
    static var previews: some View {
        ChamChamView(viewModel: ChamChamViewModel(moon: Moon()))
    }
}
