//
//  CollectionViewWithTitle.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

protocol CollectionViewWithTitleDelegate: AnyObject {
    func updateDataSource(items: [ModelProtocol])
    func didAdd()
    func didSelect(index: Int)
}

class CollectionViewWithTitle<T: UICollectionViewCell, M: ModelProtocol>: UIView, UICollectionViewDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Class Params
    private var viewModel: ViewModel!
    private var dataSource: CollectionViewDataSource<T,M>!
    
    private weak var delegate: CollectionViewWithTitleDelegate?
    
    init(viewModel: ViewModel, delegate: CollectionViewWithTitleDelegate) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        self.delegate = delegate
        
        self.commonInit()
        self.callToViewModelForUIUpdate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func closeTopView() {
        topView.close()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("CollectionViewWithTitle", owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func callToViewModelForUIUpdate() {
        self.viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.delegate?.updateDataSource(items: self.viewModel.data)
        }
    }
    
    func reloadWith(dataSource: UICollectionViewDataSource, id: String, numberOfItems: CGFloat = 3, height: CGFloat? = nil) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 24) / numberOfItems
        flowLayout.itemSize = CGSize(width: itemWidth, height: height ?? itemWidth)
        
        topView.delegete = self
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.dataSource = dataSource
        
        collectionView.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(index: indexPath.row)
    }
}

extension CollectionViewWithTitle: TopViewDelegete {
    func didAdd() {
        delegate?.didAdd()
    }
    
    func filter(title: String?, id: String?, userId: String?) {
        DispatchQueue.main.async {
            self.delegate?.updateDataSource(items: self.viewModel.filter(title: title, id: id, userId: userId))
        }
    }
    
    func filter(geo: String) {
        DispatchQueue.main.async {
            self.delegate?.updateDataSource(items: self.viewModel.filter(geo: geo))
        }
    }
}
