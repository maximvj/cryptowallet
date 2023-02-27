
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    let label = UILabel()
    var loginViewModel: (LoginModuleProtocolIn & LoginModuleProtocolOut)?
    private let loginButton = CustomButton()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private var stackView = UIStackView()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        listenViewModel()
        setLayout()
        setTextFields()
        setLoginButton()
        setLabel()
        setStackView()
        setLayout()
    }
    
    // MARK: - Methods
    
    func listenViewModel() {
        guard var loginViewModel = loginViewModel else {
            return
        }
        
        loginViewModel.loginCheck = { [weak self] result in
            self?.checkLogin(result: result)
            
        }
    }
    
    func setLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.left.equalTo(50)
            make.right.equalTo(-50)
        }
    }
    
    func setTextFields() {
        loginTextField.borderStyle = .line
        loginTextField.placeholder = "Login"
        loginTextField.inputAccessoryView = setToobar()
        passwordTextField.borderStyle = .line
        passwordTextField.placeholder = "Password"
        passwordTextField.inputAccessoryView = setToobar()
        passwordTextField.isSecureTextEntry = true
    }
    
    func setToobar() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                         target: self,
                                         action: #selector(hideKeyboard))
        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }
    
    func setLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
    }
    
    func setLabel() {
        label.text = "Enter login and password"
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    func setStackView() {
        stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField, loginButton, label])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setCustomSpacing(20, after: loginTextField)
        stackView.setCustomSpacing(30, after: passwordTextField)
        stackView.setCustomSpacing(20, after: loginButton)
    }
    
    func checkLogin (result: LoginResponce) {
        label.text = result.getInfo(responceType: result)
    }
    
    // MARK: - Objc methods
    
    @objc func tapLoginButton () {
        loginViewModel?.getData(login: loginTextField.text, password: passwordTextField.text)
    }
    
    @objc func hideKeyboard () {
        if loginTextField.isFirstResponder {
            loginTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
}
