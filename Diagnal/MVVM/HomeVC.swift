//
//  ViewController.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import UIKit

class HomeViewController: UIViewController {


    // VC override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView(){
     
        let myButton = UIButton()
        myButton.setTitle("Movie List", for: .normal)
        myButton.setTitleColor(.blue, for: .normal)
        myButton.addTarget(self, action: #selector(pressedAction(sender:)),
                           for: .touchUpInside)

        view.addSubview(myButton)
        myButton.prepareLayout(.centerX)
        myButton.prepareLayout(.centerY)
        myButton.prepareLayout(.height,constant: 200)
        myButton.prepareLayout(.width,constant: 400)
    }
    
    
    @objc func pressedAction(sender: UIButton!) {
        
        let vc = MovieListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
