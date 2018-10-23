//
//  LoginViewController.swift
//  FirebaseChat
//
//  Created by Mobdev125 on 10/23/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var actionButton: UIButton!
    @IBOutlet var fieldBackingView: UIView!
    @IBOutlet var displayNameField: UITextField!
    @IBOutlet var actionButtonBackingView: UIView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldBackingView.smoothRoundCorners(to: 8)
        actionButtonBackingView.smoothRoundCorners(to: actionButtonBackingView.bounds.height / 2)
        
        displayNameField.tintColor = .primary
        displayNameField.addTarget(
            self,
            action: #selector(textFieldDidReturn),
            for: .primaryActionTriggered
        )
        
        registerForKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        displayNameField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func actionButtonPressed() {
        signIn()
    }
    
    @objc private func textFieldDidReturn() {
        signIn()
    }
    
    // MARK: - Helpers
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func signIn() {
        guard let name = displayNameField.text, !name.isEmpty else {
            showMissingNameAlert()
            return
        }
        
        displayNameField.resignFirstResponder()
        
        AppSettings.displayName = name
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                
            }
        }
    }
    
    private func showMissingNameAlert() {
        let ac = UIAlertController(title: "Display Name Required", message: "Please enter a display name.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.displayNameField.becomeFirstResponder()
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Notifications
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        guard let keyboardAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            return
        }
        
        let options = UIView.AnimationOptions(rawValue: keyboardAnimationCurve << 16)
        bottomConstraint.constant = keyboardHeight + 20
        
        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        guard let keyboardAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            return
        }
        
        let options = UIView.AnimationOptions(rawValue: keyboardAnimationCurve << 16)
        bottomConstraint.constant = 20
        
        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
