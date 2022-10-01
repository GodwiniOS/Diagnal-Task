//
//  UIViewEx.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import UIKit

// 272/182
extension UIView {
    
    func prepareLayout(_ attribute: NSLayoutConstraint.Attribute,
                       toItem :UIView? = nil,
                       toAttribute: NSLayoutConstraint.Attribute? = nil,
                       constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        var withItem: UIView! =  toItem != nil ? toItem! : superview
        var withAttribute: NSLayoutConstraint.Attribute! = toAttribute ?? attribute

        if attribute == .height,attribute == .width {
            withItem = nil
            withAttribute = .notAnAttribute
        }
        let layout = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: withItem,
                                        attribute: withAttribute,
                                        multiplier: 1,
                                        constant: constant)
        NSLayoutConstraint.activate([layout])
    }
    
}



extension UICollectionView{

    func registerCell() {
        register(PosterCVCell.self,
                 forCellWithReuseIdentifier: String(describing: PosterCVCell.self))
    }
}



extension UIViewController{
    
    func topbarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
    }
}

extension UILabel{


    func prepareTextField(fontName: TitilliumWeb,size: FontSize,
                          align:  NSTextAlignment = .left,color:UIColor = .white) {
        font = UIFont(name:fontName.rawValue,size:15)
        textAlignment = align
        textColor = color
    }
}


extension UIImageView {
    
    func preparePosterImage(name: String?) {
        guard let name = name else { return }
        image = UIImage(named: "placeholder_for_missing_posters")
        if let img = UIImage(named: name) {
            image = img
        }
    }
}

extension UINavigationController{
    func changeHeader(_ scrollView: UIScrollView) {

        if (scrollView.contentOffset.y <= 0){}


        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){

//            let gradientLayer = CAGradientLayer()
//
//            gradientLayer.frame = view.frame
//              gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
//
//
//              gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//              gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//
//              UIGraphicsBeginImageContext(gradientLayer.bounds.size)
//              gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
//              let image = UIGraphicsGetImageFromCurrentImageContext()
//              UIGraphicsEndImageContext()
//            let img  = UIImage(named: "nav_bar")
//            let imgV = UIImageView(frame: view.frame)
//            imgV.contentMode = .scaleAspectFit
//            imgV.image = img
//            let aView = ImageViewWithGradient(frame: view.frame)
//            navigationBar.setBackgroundImage(img, for: .default)
        }

//        (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {

    }
    
    func prepareposterNavBar(){
        

        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        appearance.backgroundImage =  UIImage(named: "nav_bar")
        let titleDict = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
        appearance.titleTextAttributes = titleDict
        navigationBar.standardAppearance = appearance
        
//        let titleLabel = UILabel()
//        titleLabel.textAlignment = .left
//        titleLabel.prepareTextField(fontName: .Light, size: .title,
//                                    color: .white)
//        titleLabel.text = "Romantic"
//        titleLabel.backgroundColor = .clear
//        navigationItem.titleView = UIImageView(image: UIImage(named: "nav_bar"))
    }
}
