//
//  HomeViewController.swift
//  TakingPictures
//
//  Created by Catherine Nguyen on 9/30/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let logoView: UIImageView = {
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        logo.image = UIImage(named: "PageLogo")
        return logo
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.backgroundColor = .secondarySystemBackground
        view.addSubview(logoView)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoView.center = view.center
        animate()
        
        //this will delay  the image for a couple of seconds
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
            self.animate()
        })
    }
    
    private func animate() {
        UIView.animate(withDuration: 7.0, animations: {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.logoView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size)
            
        })
        UIView.animate(withDuration: 7.0, animations: {
            self.logoView.alpha = 0
        })
        
        let viewController = ViewController()
        //viewController.modalPresentationStyle
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController,animated: true)
        
    }

}
