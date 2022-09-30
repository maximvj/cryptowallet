//
//  BaseViewController.swift
//  cryptowallet
//
//  Created by Maxim on 29.09.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listenViewModel()
        setLayout()
        
    }

    func listenViewModel() {}

    func setLayout() {}

}
