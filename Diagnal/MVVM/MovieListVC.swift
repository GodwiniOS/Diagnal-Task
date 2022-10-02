//
//  MovieListVC.swift
//  Diagnal
//
//  Created by Godwin A on 01/10/22.
//

import UIKit

class MovieListVC: UIViewController {
    
    

    let vm = MovieListViewModel()
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView(){
        

//        title = "Romantic Comedy"
        navigationController?.prepareposterNavBar()
        
        let searchImg:UIImage = UIImage(named: "SearchIcon")!
        searchImg.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let backImg:UIImage = UIImage(named: "BackIcon")!
        backImg.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      
        let RightBarButton = UIBarButtonItem(image: searchImg,
            style: .plain,target: self,action: #selector(searchAction))
        RightBarButton.tintColor = .white
        
        let leftBarButton = UIBarButtonItem(image: backImg,
            style: .plain,target: self,action: #selector(backAction))
        leftBarButton.tintColor = .white
        
        navigationItem.rightBarButtonItem = RightBarButton
        
        let play = UIBarButtonItem(title: "Romantic Comedy",
                                   style: .done, target: self, action: nil)
        play.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "TitilliumWeb-Light", size: 24)!,
            NSAttributedString.Key.foregroundColor : UIColor.white,], for: .normal)
        play.tintColor = .white

        
        navigationItem.leftBarButtonItems = [leftBarButton,play]
        

        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 6,left: 5,
//                                           bottom: 5, right: 8)
        layout.sectionInset = UIEdgeInsets(top: 36.px,left: 18.px,
                                           bottom: 0, right: 12.px)
        view.backgroundColor = .black
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.prepareLayout(.top)
        collectionView.prepareLayout(.bottom)
        collectionView.prepareLayout(.leading,constant: 12.px)
        collectionView.prepareLayout(.trailing,constant: -(18.px))
        collectionView.registerCell()
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        vm.delegate = self
    }
    
    
    @objc private func searchAction(){
        print("Search Click")
    }
    
    @objc private func backAction(){
        navigationController?.popViewController(animated: true)
    }
}



extension MovieListVC: MovieListModelDelegate {
    func loadTableView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//extension MovieListVC:UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        navigationController?.changeHeader(scrollView)
//    }
//}


// MARK: - Collection View Delegate
extension MovieListVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        vm.noSection()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.noRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCVCell", for: indexPath) as! PosterCVCell
        cell.prepare(vm.cellItem(index: indexPath))
        return cell
    }
}


// MARK: - Collection View Flow Layout Delegate
extension MovieListVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    
      let paddingSpace = 30.px * CGFloat(vm.itemsPerRow + 1)
      let availableWidth = view.frame.size.width - CGFloat(paddingSpace)
    let widthPerItem = availableWidth / CGFloat(vm.itemsPerRow)

      
      var height: CGFloat!

//      if UIApplication.shared.statusBarOrientation.isLandscape {
//          height = ((ImageSize.width.rawValue/widthPerItem) * (ImageSize.height.rawValue*3))
//
//      } else {
//          height = (ImageSize.height.rawValue/widthPerItem) * (ImageSize.width.rawValue*0.64)
//
//      }
      
//      if UIApplication.shared.statusBarOrientation.isLandscape {
      height = widthPerItem * (ImageSize.height.rawValue/ImageSize.width.rawValue) + 130.px

//      } else {
//          height = (ImageSize.height.rawValue/widthPerItem) * (ImageSize.width.rawValue)
//
//      }
      return CGSize(width: widthPerItem, height: height)


  }
}
