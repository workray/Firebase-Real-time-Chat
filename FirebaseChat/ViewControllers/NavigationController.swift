//
//  NavigationController.swift
//  FirebaseChat
//
//  Created by Mobdev125 on 10/23/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    init(_ rootVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        pushViewController(rootVC, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = .primary
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = navigationBar.titleTextAttributes
        } else {
            
        }
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary]
        
        toolbar.tintColor = .primary
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
}
