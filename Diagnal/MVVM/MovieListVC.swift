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
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.prepareTextField(fontName: .Bold, size: .title)
        titleLabel.textColor = .white
        titleLabel.text = "Romantic Comedy"

        
        let titleDict = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleDict
        navigationItem.titleView = titleLabel

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    

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
        navigationItem.leftBarButtonItem = leftBarButton
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 6,left: 5,
                                           bottom: 5, right: 8)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.prepareLayout(.top)
        collectionView.prepareLayout(.bottom)
        collectionView.prepareLayout(.leading)
        collectionView.prepareLayout(.trailing)
        collectionView.registerCell()
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
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

extension MovieListVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        navigationController?.changeHeader(scrollView)
    }
}


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
    
    let paddingSpace = 8 * CGFloat(vm.itemsPerRow + 1)
    let availableWidth = view.frame.width - CGFloat(paddingSpace)
    let widthPerItem = availableWidth / CGFloat(vm.itemsPerRow)

      return CGSize(width: widthPerItem, height: widthPerItem*2.2)
  }
}
