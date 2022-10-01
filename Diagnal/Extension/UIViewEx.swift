//
//  UIViewEx.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import UIKit


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
                          align:  NSTextAlignment = .left) {
        font = UIFont(name:fontName.rawValue,size:15)
        textAlignment = align
        textColor = .black
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
        
//        if (scrollView.contentOffset.y <= 0){       }


        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            navigationBar.setGradientBackground(colors: [.black, .clear], startPoint: .topLeft, endPoint: .bottomRight)
//            let navigationBar = navigationController?.navigationBar
//            let navigationBarAppearance = UINavigationBarAppearance()
//            navigationBarAppearance.shadowColor = .clear
//            navigationBar?.scrollEdgeAppearance = navigationBarAppearance

        }
        
//        (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {

    }
    
    func image(fromLayer layer: CALayer) -> UIImage {

        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}

class UINavigationBarGradientView: UIView {

    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
                case .topRight: return CGPoint(x: 1, y: 0)
                case .topLeft: return CGPoint(x: 0, y: 0)
                case .bottomRight: return CGPoint(x: 1, y: 1)
                case .bottomLeft: return CGPoint(x: 0, y: 1)
                case .custom(let point): return point
            }
        }
    }

    private weak var gradientLayer: CAGradientLayer!

    convenience init(colors: [UIColor], startPoint: Point = .topLeft,
                     endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        self.init(frame: .zero)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        backgroundColor = .clear
    }

    func set(colors: [UIColor], startPoint: Point = .topLeft,
             endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        parentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.frame = frame
        superview?.addSubview(self)
    }
}

extension UINavigationBar {
    func setGradientBackground(colors: [UIColor],
                               startPoint: UINavigationBarGradientView.Point = .topLeft,
                               endPoint: UINavigationBarGradientView.Point = .bottomLeft,
                               locations: [NSNumber] = [0, 1]) {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard let gradientView = backgroundView.subviews.first(where: { $0 is UINavigationBarGradientView }) as? UINavigationBarGradientView else {
            let gradientView = UINavigationBarGradientView(colors: colors, startPoint: startPoint,
                                                           endPoint: endPoint, locations: locations)
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            return
        }
        gradientView.set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
    }
}


