//
//  SecondViewController.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class PhotosViewController: UIViewController {
    private var collectionViewWithTitle: CollectionViewWithTitle<PostCollectionViewCell, Photo>!
    private var viewModel: PhotosViewModel!
    private var dataSource: CollectionViewDataSource<PhotoCollectionViewCell, Photo>!
    
    private let cellIdentifier = "PhotoCollectionViewCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.callFuncToGetData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        collectionViewWithTitle.closeTopView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PhotosViewModel()
        collectionViewWithTitle = CollectionViewWithTitle(viewModel: viewModel, delegate: self)
        collectionViewWithTitle.title.text = "Photos"
        collectionViewWithTitle.addTo(view: self.view)
    }
}

extension PhotosViewController: CollectionViewWithTitleDelegate {
    func didSelect(index: Int) {
        let photoView = PhotoViewController()
        let items = dataSource.items!
        photoView.titleForPhoto = items[index].title
        photoView.photo = items[index].url
        photoView.id = "\(items[index].id!)"
        photoView.userId = "\(items[index].userId ?? -1)"
        
        let comp = items[index].geo?.components(separatedBy: ",")
        photoView.coord = comp?.count == 2 ? [comp![0], comp![1]] : []
        
        photoView.viewModel = viewModel
        
        photoView.modalPresentationStyle = .fullScreen
        
        present(photoView, animated: true)
    }
    
    func didAdd() {
        let newPhoto = NewPhotoViewController(nibName: "NewPhotoViewController", bundle: nil)
        newPhoto.viewModel = viewModel
        newPhoto.numOfItems = viewModel.data.last!.id!
        newPhoto.modalPresentationStyle = .fullScreen
        present(newPhoto, animated: true)
    }
    
    func updateDataSource(items: [ModelProtocol]) {
        dataSource = CollectionViewDataSource(cellIdentifier: cellIdentifier, items: items as! [Photo], configureCell: { (cell, evm) in
            cell.set(title: evm.title ?? "")
            cell.set(image: nil)
            if let url = evm.url {
                Task {
                    cell.set(image: await self.viewModel.getImageFrom(url: url))
                }
            }
            
            cell.back.layer.borderWidth = 0.8
            cell.back.layer.borderColor = UIColor.black.cgColor
            
            cell.back.layer.cornerRadius = 8
            
            let items =  self.viewModel.data as! [Photo]
            let index = items.firstIndex(where: { photo in return photo.id == evm.id } )!
            cell.back.backgroundColor = UIColor.getColor(index: index)
            
            cell.contentView.dropShadow(color: .black, opacity: 0.6, offSet: .init(width: -2, height: -2))
        })
        
        self.collectionViewWithTitle.reloadWith(dataSource: dataSource, id: cellIdentifier)
    }
}
