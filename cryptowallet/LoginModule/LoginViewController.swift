
import UIKit
import SnapKit


class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    var stackView = UIStackView()
    var loginViewModel: (LoginModuleProtocolIn & LoginModuleProtocolOut)?
    
    
    // MARK: - Ovveride methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setTextFields()
        setLoginButton()
        setStackView()
        setLayout()
        
    }

    override func listenViewModel() {
        guard var loginViewModel = loginViewModel else {
            return
        }

        loginViewModel.loginCheck = { [weak self] result in
            self?.checkLogin(result: result)
        }
    }
    
    override func setLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(50)
            make.right.equalTo(-50)
        }
    }
    
    // MARK: - Methods
    
    func setTextFields() {
        loginTextField.borderStyle = .line
        loginTextField.layer.cornerRadius = 10
        
        passwordTextField.borderStyle = .line
        passwordTextField.layer.cornerRadius = 10
    }
    
    func setLoginButton() {
        loginButton.backgroundColor = .systemTeal
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
    }
    
    func setStackView() {
        stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField, loginButton ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setCustomSpacing(20, after: loginTextField)
        stackView.setCustomSpacing(50, after: passwordTextField)
    }
    
    func checkLogin (result: LoginError) {
        if result == .noInfo {
            view.backgroundColor = .green
        } else {
            view.backgroundColor = .white
        }
    }
    
    @objc func tapLoginButton () {
        loginViewModel?.getData(login: loginTextField.text, password: passwordTextField.text)
    }
}

