
import Foundation

enum LoginError {
    case shortInfo
    case noInfo
    case success
}

protocol LoginModuleProtocol {
    init (router: RouterProtocol)
}

// In ViewModel
protocol LoginModuleProtocolIn {
    func getData(login: String?, password: String?)
}

// From ViewModel
protocol LoginModuleProtocolOut {
    var loginCheck: (LoginError) -> () { get set }
}


class LoginViewModel: LoginModuleProtocolIn, LoginModuleProtocolOut, LoginModuleProtocol {
    
    var router: RouterProtocol?
    
    required init(router: RouterProtocol) {
        self.router = router 
    }
    
    
    var loginCheck: (LoginError) -> () = {_ in }
    
    func getData(login: String?, password: String?) {
        guard let login = login, let password =  password else { return }
        
        let logPass = (login, password)
        
        switch logPass {
        case let (login, pass) where login.count == 0 || pass.count == 0: self.loginCheck(.noInfo)
        case let (login, pass) where login.count < 4 || pass.count < 4: self.loginCheck(.shortInfo)
        default:  router?.mainViewController() 
        }
    }
    
}
