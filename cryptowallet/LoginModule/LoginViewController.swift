
import UIKit
import SnapKit


class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    let label = UILabel()
    let loginButton = UIButton()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    var stackView = UIStackView()
    var loginViewModel: (LoginModuleProtocolIn & LoginModuleProtocolOut)?
    
    // MARK: - Ovveride methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setTextFields()
        setLoginButton()
        setLabel()
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
            make.top.equalTo(150)
            make.left.equalTo(50)
            make.right.equalTo(-50)
        }
    }
    
    // MARK: - Methods
    
    func setTextFields() {
        loginTextField.borderStyle = .line
        loginTextField.placeholder = "Login"
        loginTextField.inputAccessoryView = setToobar()
        passwordTextField.borderStyle = .line
        passwordTextField.placeholder = "Password"
        passwordTextField.inputAccessoryView = setToobar()
        
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
        loginButton.backgroundColor = .systemTeal
        loginButton.layer.cornerRadius = 10
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

