//
//  SecondViewController.swift
//  GCD
//
//  Created by Владимир on 13.09.2021.
//

import UIKit
import Foundation

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageURL: URL?
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    func fetchImage() {
        imageURL = URL(string: "https://i.ibb.co/fCPQxdv/4.jpg")
        if let url = imageURL {
            self.activityIndicator.startAnimating()
            
            DispatchQueue.global(qos: .utility).async {
            let imageData = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
            if imageData != nil {
                self.image = UIImage(data: imageData!)
            } else {
                self.image = nil
            }
                }}
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        
        delay(delay: 3, closure: {
        let ac = UIAlertController(title: "Registered?", message: "Enter your login and password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Your Login"
        }
        
        ac.addTextField { (passwordTF) in
            passwordTF.placeholder = "Your password"
            passwordTF.isSecureTextEntry = true
        }
        self.present(ac, animated: true, completion: nil)
        
    })
        }
        func delay(delay: Double, closure: @escaping ()->()) {
            let when = DispatchTime.now() + delay
               DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
        }
    
    
}

