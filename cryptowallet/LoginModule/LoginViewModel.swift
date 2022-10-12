
import Foundation

// In ViewModel
protocol LoginModuleProtocolIn {
    init (router: RouterProtocol)
    func getData(login: String?, password: String?)
}

// From ViewModel
protocol LoginModuleProtocolOut {
    var loginCheck: (LoginResponce) -> () { get set }
}

enum LoginResponce: String {
    case shortInfo
    case noInfo
    case success
    
    func getInfo (responceType: LoginResponce) -> String {
        switch responceType {
        case .shortInfo:
            return "Password and login must be more than 4 characters "
        case .noInfo:
            return "Enter login and password"
        case .success: return String()
        }
    }
}

class LoginViewModel: LoginModuleProtocolIn, LoginModuleProtocolOut {
    
    var router: RouterProtocol?
    var loginCheck: (LoginResponce) -> () = {_ in }
    
    required init(router: RouterProtocol) {
        self.router = router 
    }
    
    func getData(login: String?, password: String?) {
        guard let login = login, let password =  password else { return }
        
        let logPass = (login, password)
        
        switch logPass {
        case let (login, pass) where login.count == 0 || pass.count == 0: self.loginCheck(.noInfo)
        case let (login, pass) where login.count <= 4 || pass.count <= 4: self.loginCheck(.shortInfo)
        default: router?.mainViewController()
        }
    }
    
}
