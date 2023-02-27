
import UIKit

class CustomButton: UIButton {
    
    enum TapState {
        case stateOne
        case stateTwo
    }
    
    var tapState: TapState?
  
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.tapState = .stateOne
        self.backgroundColor = .systemTeal
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchTapState() {
        guard let tapState = tapState else { return }
        switch tapState {
        case .stateOne : self.tapState = .stateTwo
        case .stateTwo : self.tapState = .stateOne
        }
    }
}
