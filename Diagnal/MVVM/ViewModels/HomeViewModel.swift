//
//  HomeViewModel.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import Foundation

protocol MovieListModelDelegate:AnyObject {
    func loadTableView()
}

class MovieListViewModel{
    
    
    var pageNumber = 0
    let itemsPerRow = 3

    let pagePrefix = "CONTENTLISTINGPAGE-PAGE"
    weak var delegate: MovieListModelDelegate?
    
    private var items: [ContentModel] = []
    var currentItems = [[ContentModel]]() {
        didSet {
            delegate?.loadTableView()
        }
    }
    
    init(){ pageLoad() }
    
    
    private func appendItems(itemsNew: [ContentModel]){
        
        items += itemsNew
        currentItems = items.reduce(into: [[]]) { (row, item) in
          if row.isEmpty || row.last!.count == itemsPerRow { row.append([item]) }
          else { row[row.count-1].append(item) }
        }
    }
    
    public func noSection() ->Int {
        return currentItems.count
    }
    
    public func noRows(_ section: Int) ->Int {
        return currentItems[section].count
    }
    
    public func cellItem(index: IndexPath) -> ContentModel {
        if index.section == (currentItems.count - 1) {
            pageLoad(pageNumber) // Pagingnation
        }
        return currentItems[index.section][index.row]
    }
    
    
    
    public func pageLoad(_ page: Int = 0){
        
        do {
            guard let path = Bundle.main.path(forResource: pagePrefix + "\(page+1)", ofType: "json") else {
                print("Page Number Excess")
            return }

            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let base = try JSONDecoder().decode(BaseModel.self, from: data)
            guard let newItems = base.page?.contentitems?.content else { return }
            pageNumber = page + 1
            appendItems(itemsNew: newItems)
            
        } catch(let error) { print(error.localizedDescription) }
        
    }
}
