//
//  ForthViewController.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class UsersViewController: UIViewController {
    private var collectionViewWithTitle: CollectionViewWithTitle<UserCollectionViewCell, User>!
    private var viewModel: UsersViewModel!
    private var dataSource: CollectionViewDataSource<UserCollectionViewCell, User>!
    
    private let cellIdentifier = "UserCollectionViewCell"
    
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
        viewModel = UsersViewModel()
        collectionViewWithTitle = CollectionViewWithTitle(viewModel: viewModel, delegate: self)
        collectionViewWithTitle.title.text = "Users"
        collectionViewWithTitle.addTo(view: self.view)
    }
}

extension UsersViewController: CollectionViewWithTitleDelegate {
    func didSelect(index: Int) {
        let userView = UserViewController()
        let items = dataSource.items!
        userView.name = items[index].name
        userView.userName = items[index].username
        userView.email = items[index].email
        userView.phone = items[index].phone
        userView.website = items[index].website
        userView.street = items[index].address?.street
        userView.suite = items[index].address?.suite
        userView.city = items[index].address?.city
        userView.zipCode = items[index].address?.zipcode
        userView.geo = "\(items[index].address?.geo?.lat ?? "") , \(items[index].address?.geo?.lng ?? "")"
        userView.companyName = items[index].company?.name
        userView.companyCatchPhrase = items[index].company?.catchPhrase
        userView.companyBs = items[index].company?.bs
        
        userView.id = "\(items[index].id!)"
        userView.userId = "\(items[index].userId ?? -1)"
        
        let comp = items[index].geo?.components(separatedBy: ",")
        userView.coord = comp?.count == 2 ? [comp![0], comp![1]] : []
        
        userView.viewModel = viewModel
        
        userView.modalPresentationStyle = .fullScreen
        
        present(userView, animated: true)
    }
    
    func didAdd() {
        let newUser = NewUserViewController(nibName: "NewUserViewController", bundle: nil)
        newUser.viewModel = viewModel
        newUser.numOfItems = viewModel.data.last!.id!
        newUser.modalPresentationStyle = .fullScreen
        present(newUser, animated: true)
    }
    
    func updateDataSource(items: [ModelProtocol]) {
        dataSource = CollectionViewDataSource(cellIdentifier: cellIdentifier, items: items as! [User], configureCell: { (cell, evm) in
            cell.set(user: evm)
            
            cell.back.layer.borderWidth = 0.8
            cell.back.layer.borderColor = UIColor.black.cgColor
            
            cell.back.layer.cornerRadius = 8
            
            let items =  self.viewModel.data as! [User]
            let index = items.firstIndex(where: { user in return user.id == evm.id } )!
            cell.back.backgroundColor = UIColor.getColor(index: index)
            
            cell.contentView.dropShadow(color: .black, opacity: 0.6, offSet: .init(width: -2, height: -2))
        })
        
        self.collectionViewWithTitle.reloadWith(dataSource: dataSource, id: cellIdentifier, numberOfItems: 2, height: 640)
    }
}

