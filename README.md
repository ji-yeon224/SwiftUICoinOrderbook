# SwiftUICoinOrderbook
SwiftUI Study✨

## 💻 WalletView
<img src = "https://github.com/ji-yeon224/SwiftUICoinOrderbook/assets/69784492/08724c52-295e-4f5c-ba4b-1d92f38c4486" width="50%"/> </br>
업비트 Open API 활용하기

### 수평 스크롤 이동 시 애니메이션
`.visualEffect, GeometryProxy` </br>
<img src="https://github.com/ji-yeon224/SwiftUICoinOrderbook/assets/69784492/c473a019-5d9e-4bfc-82f5-8491bd4e4e20" width="50%"/>
<img src="https://github.com/ji-yeon224/SwiftUICoinOrderbook/assets/69784492/2019e638-f4fe-4fe6-8688-1784af2b2f6b" width="30%" />

### overlay를 활용하여 디자인 하기

```swift
Rectangle()
    .fill(
        LinearGradient(gradient: Gradient(colors: [viewModel.banner.color, Color.blue]), startPoint: .bottomLeading, endPoint: .trailing)
    )
    .overlay {
        Circle()
            .fill(.white.opacity(0.2))
            .offset(x: -40, y: 80)
            .scaleEffect(1.8, anchor: .center)
    }
    .clipShape(RoundedRectangle(cornerRadius: 25))
    .frame(maxWidth: .infinity)
    .frame(height: 200)
```
<img src="https://github.com/ji-yeon224/SwiftUICoinOrderbook/assets/69784492/897a3b22-8b11-4cec-befa-0d52c424f00e" width="30%" />

</br></br>
## 💻 Wallet Animation
<img src="https://github.com/ji-yeon224/SwiftUICoinOrderbook/assets/69784492/1c599381-c30d-40e1-8814-0a62edf2f91c" width="25%" />
<img src="https://github.com/ji-yeon224/SwiftUICoinOrderbook/assets/69784492/c8417cc6-893e-4764-82fb-139a833c4d90" width="50%" />

### Title
```swift
struct WalletView: View {
    
    @State private var isExpandable = false
    
    var body: some View {
        VStack {
            topTitle()
            Spacer()
            Button("AnimationOn") {
                print("on")
                withAnimation(.smooth) { // 타이틀 이동 애니메이션
                    isExpandable = false
                }
                
            }
            Button("AnimationOff") {
                print("off")
                withAnimation(.spring(duration: 0.5)) {
                    isExpandable = true
                }
            }
        }
        
    }
    
    func topTitle() -> some View {
        Text("My Wallet")
            .font(.largeTitle)
            .bold()
            
            .frame(
                maxWidth: .infinity,
                alignment: isExpandable ? .leading : .center
            )
            .overlay(alignment: .trailing) {
                topOverlayButton()
                    .padding()
            }
            .padding()
    }
    
    func topOverlayButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding(10)
                .background(Color.black, in: Circle())
        }
        .rotationEffect(.degrees(isExpandable ? 225 : 45)) // 회전
        .opacity(isExpandable ? 1 : 0) // 사라졌다가 등장 투명도 조절
    }
    
}
```
### Card

<img src="https://github.com/ji-yeon224/SwiftUICoinOrderbook/assets/69784492/cd86aa6a-ed37-4cbc-8fb1-d38b7b2b6ccd" width="70%"/> </br>
offset 값을 이용하여 y축 조절

`.matchedGeometryEffect(id:, in:(Namespace))`
-> 애니메이션을 지정하면서 데이터 전달하기
```swift
// WalletView.swift

@State private var currentWallet = WalletModel(name: "", index: 0)  // 사용자가 탭한 카드가 무엇인지 알기 위함
@Namespace var animation

func cardView(_ data: WalletModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(data.color)
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .offset(
                y: CGFloat(data.index) * (isExpandable ? 0 : -120)
            )
            .onTapGesture { 
                withAnimation(.spring(duration: 0.5)) {
                    // 카드 탭 시 다음 화면 전환
                    showDetail = true
                    currentWallet = data
                    
                }
            }
            .matchedGeometryEffect(id: data, in: animation) // "animation" 네임스페이스를 통해 data값 전달
            
    }
```

```swift
// WalletDetailView.swift

let currentWallet: WalletModel // WalletView에서 선택한 카드 정보
var animation: Namespace.ID // 동일한 그룹입을 인식
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(currentWallet.color)
                    .frame(height: 150)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        showDetail = false
                    }
                    .matchedGeometryEffect(id: currentWallet, in: animation)
                Text(currentWallet.name)
                Spacer()
            }
            
            
        }
    }
```














