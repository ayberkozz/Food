//
//  ingredientsVC.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import UIKit

class IngredientsVC: UIViewController {
    
    private var tv = UITableView()
    private var searchButtonIng = UIButton()
    private let searchController = UISearchController(searchResultsController: nil)
    private var items: [Ingredients] = []
    private var selectedItems: [String] = []
    private var DeSelectedItems: [String] = []
    private var filteredItems: [Ingredients] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadIngredients()
        style()
        layout()
        setupSearchController()
    }
    
    func loadIngredients() {
        items = loadCSV(from: "top-1k-ingredients")
    }
    
    @objc private func searchButtonIngre() {
        let viewModel = FoodsByIngredientsViewModel(foodService: FoodService())
        let nextViewController = FoodsByIngredientsVC(viewModel: viewModel)
        nextViewController.ingredients = selectedItems
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func style() {
        view.backgroundColor = .white
        self.navigationItem.title = "Ingredients🌽"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ingredientsTVC.self, forCellReuseIdentifier: ingredientsTVC.reuseIdentifier)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsMultipleSelection = true
        
        searchButtonIng.translatesAutoresizingMaskIntoConstraints = false
        searchButtonIng.setTitle("Search🥄", for: .normal)
        searchButtonIng.addTarget(self, action: #selector(searchButtonIngre), for: .touchUpInside)
        searchButtonIng.setTitleColor(.white, for: .normal)
        searchButtonIng.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        searchButtonIng.layer.cornerRadius = 10
        searchButtonIng.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func layout() {
        view.addSubview(tv)
        view.addSubview(searchButtonIng)
        
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tv.bottomAnchor.constraint(equalTo: searchButtonIng.topAnchor, constant: -10),
            
            searchButtonIng.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButtonIng.widthAnchor.constraint(equalToConstant: view.frame.width / 1.1),
            searchButtonIng.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Ingredients"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
}

// MARK: - UITableView

extension IngredientsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredItems.count
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ingredientsTVC.reuseIdentifier, for: indexPath) as! ingredientsTVC
        let item: Ingredients
        
        if isFiltering() {
            item = filteredItems[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        
        cell.textLabel?.text = item.IngredientName
        cell.isSelectedItem = selectedItems.contains(item.IngredientName)
        cell.selectionStyle = .none
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem: String
        if isFiltering() {
            selectedItem = filteredItems[indexPath.row].IngredientName
        } else {
            selectedItem = items[indexPath.row].IngredientName
        }

        if let cell = tableView.cellForRow(at: indexPath) as? ingredientsTVC {
            if selectedItems.contains(selectedItem) {
                if let index = selectedItems.firstIndex(of: selectedItem) {
                    selectedItems.remove(at: index)
                }
                cell.isSelectedItem = false
            } else {
                selectedItems.append(selectedItem)
                cell.isSelectedItem = true
            }

            moveSelectedItemToTop(selectedItem)
        }
    }

    private func moveSelectedItemToTop(_ selectedItem: String) {
        guard let index = items.firstIndex(where: { $0.IngredientName == selectedItem }) else {
            return
        }

        let selectedItem = items.remove(at: index)
        items.insert(selectedItem, at: 0)

        // Reload the table view to reflect the changes
        tv.reloadData()
    }
}

// MARK: - UISearchResultsUpdating

extension IngredientsVC: UISearchResultsUpdating,UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text)
    }
    
    func filterContentForSearchText(_ searchText: String?) {
        if let searchText = searchText, !searchText.isEmpty {
            filteredItems = items.filter { $0.IngredientName.lowercased().contains(searchText.lowercased()) }
        } else {
            filteredItems = items
        }
        tv.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

