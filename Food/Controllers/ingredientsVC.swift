//
//  ingredientsVC.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import UIKit

class ingredientsVC: UIViewController {
    
    private var tv = UITableView()
    private var button = UIButton()
    
    private let items = ["Apples", "Flour", "Sugar"]
    private var selectedItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        style()
        layout()
    }
    
    func getSelectedItems() -> [String] {
        return selectedItems
    }
    
    @objc private func button1() {
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
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("button", for: .normal)
        button.addTarget(self, action: #selector(button1), for: .touchUpInside)
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func layout() {
        
        view.addSubview(tv)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            tv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tv.widthAnchor.constraint(equalToConstant: view.frame.width),
            tv.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalToSystemSpacingBelow: tv.bottomAnchor, multiplier: 3),
            
        ])

    }

}

// MARK: - UITableViewDataSource

extension ingredientsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ingredientsTVC.reuseIdentifier, for: indexPath) as! ingredientsTVC
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        cell.isSelectedItem = selectedItems.contains(item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ingredientsVC: UITableViewDelegate {
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
