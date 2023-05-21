//
//  TableViewHendler.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class CollectionViewDataSource<CELL : UICollectionViewCell,T> : NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
    
    private var cellIdentifier : String!
    var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
}
