//
//  FirstViewController.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class PostsViewController: UIViewController {
    private var collectionViewWithTitle: CollectionViewWithTitle<PostCollectionViewCell, Post>!
    private var viewModel: PostViewModel!
    private var dataSource: CollectionViewDataSource<PostCollectionViewCell, Post>!
    
    private let cellIdentifier = "PostCollectionViewCell"
    
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
        viewModel = PostViewModel()
        collectionViewWithTitle = CollectionViewWithTitle(viewModel: viewModel, delegate: self)
        collectionViewWithTitle.title.text = "Posts"
        collectionViewWithTitle.addTo(view: self.view)
    }
}

extension PostsViewController: CollectionViewWithTitleDelegate {
    func didSelect(index: Int) {
        let postView = PostViewController()
        let items = dataSource.items!
        postView.titleForPost = items[index].title
        postView.body = items[index].body
        postView.id = "\(items[index].id!)"
        postView.userId = "\(items[index].userId!)"
    
        let comp = items[index].geo?.components(separatedBy: ",")
        postView.coord = comp?.count == 2 ? [comp![0], comp![1]] : []
        
        postView.viewModel = viewModel
        
        postView.modalPresentationStyle = .fullScreen
        
        present(postView, animated: true)
    }
    
    func didAdd() {
        let newPost = NewPostViewController(nibName: "NewPostViewController", bundle: nil)
        newPost.viewModel = viewModel
        newPost.numOfItems = viewModel.data.last!.id!
        newPost.modalPresentationStyle = .fullScreen
        present(newPost, animated: true)
    }
    
    func updateDataSource(items: [ModelProtocol]) {
        dataSource = CollectionViewDataSource(cellIdentifier: cellIdentifier, items: items as! [Post], configureCell: { (cell, evm) in
            cell.set(title: evm.title ?? "")
            cell.set(body: evm.body ?? "")
            
            cell.back.layer.borderWidth = 0.8
            cell.back.layer.borderColor = UIColor.black.cgColor
            
            cell.back.layer.masksToBounds = true
            cell.back.layer.cornerRadius = 8
            
            let items =  self.viewModel.data as! [Post]
            let index = items.firstIndex(where: { post in return post.id == evm.id } )!
            cell.back.backgroundColor = UIColor.getColor(index: index)
            
            cell.contentView.dropShadow(color: .black, opacity: 0.6, offSet: .init(width: -2, height: -2))
        })
        
        self.collectionViewWithTitle.reloadWith(dataSource: dataSource, id: cellIdentifier)
    }
}
