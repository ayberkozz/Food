//
//  IngredientsVC.swift
//  Food
//
//  Created by Ayberk Öz on 15.06.2023.
//

import UIKit

class IngredientsVC: UIViewController, IngredientsViewModelOutput {
    
    private let viewModel : IngredientsViewModel
    private lazy var foodsByIngredients : [IngredientsModel] = []
    
    private var tv = UITableView()
    
    private let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    private var selectedItems: [String] = []
    
    
    init(viewModel: IngredientsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(values: [IngredientsModel]) {
        foodsByIngredients = values
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchFoodsByIngredients(query: ["apple","flour","sugar"], number: 2)
        
        style()
        layout()
    }
    
    func getSelectedItems() -> [String] {
        return selectedItems
    }

    
    func style() {
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Ingredients🌽"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(IngredientsTVC.self, forCellReuseIdentifier: IngredientsTVC.reuseIdentifier)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsMultipleSelection = true
    }
    
    func layout() {
        
        view.addSubview(tv)
        
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.topAnchor),
            tv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tv.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
}

// MARK: - UITableViewDataSource

extension IngredientsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTVC.reuseIdentifier, for: indexPath) as! IngredientsTVC
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        cell.isSelectedItem = selectedItems.contains(item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension IngredientsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        selectedItems.append(selectedItem)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedItem = items[indexPath.row]
        if let index = selectedItems.firstIndex(of: deselectedItem) {
            selectedItems.remove(at: index)
        }
    }
}


