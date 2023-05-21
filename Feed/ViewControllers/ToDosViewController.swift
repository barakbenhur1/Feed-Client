//
//  ThirdViewController.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class ToDosViewController: UIViewController {
    private var collectionViewWithTitle: CollectionViewWithTitle<ToDoCollectionViewCell, ToDo>!
    private var viewModel: ToDoViewModel!
    private var dataSource: CollectionViewDataSource<ToDoCollectionViewCell, ToDo>!
    
    private let cellIdentifier = "ToDoCollectionViewCell"
    
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
        viewModel = ToDoViewModel()
        collectionViewWithTitle = CollectionViewWithTitle(viewModel: viewModel, delegate: self)
        collectionViewWithTitle.title.text = "To Do׳s"
        collectionViewWithTitle.addTo(view: self.view)
    }
}

extension ToDosViewController: CollectionViewWithTitleDelegate {
    func didSelect(index: Int) {
        let toDoView = ToDoViewController()
        let items = dataSource.items!
        
        toDoView.toDo = items[index].title
        toDoView.id = "\(items[index].id!)"
        toDoView.userId = "\(items[index].userId!)"
        
        let comp = items[index].geo?.components(separatedBy: ",")
        toDoView.coord = comp?.count == 2 ? [comp![0], comp![1]] : []
        
        toDoView.viewModel = viewModel
        
        toDoView.modalPresentationStyle = .fullScreen
        
        present(toDoView, animated: true)
    }
    
    func didAdd() {
        let newToDo = NewToDoViewController(nibName: "NewToDoViewController", bundle: nil)
        newToDo.viewModel = viewModel
        newToDo.numOfItems = viewModel.data.last!.id!
        newToDo.modalPresentationStyle = .fullScreen
        present(newToDo, animated: true)
    }
    
    func updateDataSource(items: [ModelProtocol]) {
        dataSource = CollectionViewDataSource(cellIdentifier: cellIdentifier, items: items as! [ToDo], configureCell: { (cell, evm) in
            cell.set(title: evm.title ?? "")
            cell.back.layer.borderWidth = 0.8
            cell.back.layer.borderColor = UIColor.black.cgColor
            
            cell.back.layer.cornerRadius = 8
            
            let items =  self.viewModel.data as! [ToDo]
            let index = items.firstIndex(where: { toDo in return toDo.id == evm.id } )!
            cell.back.backgroundColor = UIColor.getColor(index: index)
            
            cell.contentView.dropShadow(color: .black, opacity: 0.6, offSet: .init(width: -2, height: -2))
        })
        
        self.collectionViewWithTitle.reloadWith(dataSource: dataSource, id: cellIdentifier)
    }
}
