//
//  ViewController.swift
//  Food
//
//  Created by Ayberk Öz on 9.06.2023.
//

import UIKit
import DropDown

class FoodMainVC: UIViewController, FoodViewModelOutput {
    
    private let viewModel: FoodViewModel
    private lazy var foods: [FoodDetailModel] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var ButtonStack = UIStackView()
    private var dropdownButton = UIButton()
    private var numberButton = UIButton()
    private var searchButton = UIButton()
    
    private var collectionView : UICollectionView!
    
    var maxFat = Int()
    var number = Int()
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "25",
            "2",
            "3"
        ]
        return menu
    }()

    let Numbermenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "5",
            "2",
            "3"
        ]
        return menu
    }()
    
    init(viewModel: FoodViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(values: [FoodDetailModel]) {
        foods = values
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        self.navigationItem.title = "Food🥘"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
                
        setupDropdownMenu()
        style()
        layout()
    }
    
    private func setupDropdownMenu() {
        menu.anchorView = dropdownButton
        menu.selectionAction = { [weak self] index, item in
            self?.maxFat = Int(item)!
        }
        
        Numbermenu.anchorView = numberButton
        Numbermenu.selectionAction = { [weak self] index, item1 in
            self?.number = Int(item1)!
        }
    }

    @objc private func showDropdownMenu() {
        menu.show()
    }
    
    @objc private func showNumberdownMenu() {
        Numbermenu.show()
    }

    @objc private func searchButtonPressed() {
        viewModel.fetchFoods(query: searchController.searchBar.text, maxFat: maxFat, number: number)
    }
    
    
    
    func style() {
        
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Character"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
        
        ButtonStack.translatesAutoresizingMaskIntoConstraints = false
        ButtonStack.axis = .horizontal
        ButtonStack.spacing = 3
        ButtonStack.distribution = .fillEqually
        
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        dropdownButton.setTitle("Max Fat", for: .normal)
        dropdownButton.addTarget(self, action: #selector(showDropdownMenu), for: .touchUpInside)
        dropdownButton.setTitleColor(.black, for: UIControl.State.normal)
        dropdownButton.backgroundColor = .white
        dropdownButton.layer.cornerRadius = 10
        dropdownButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        numberButton.translatesAutoresizingMaskIntoConstraints = false
        numberButton.setTitle("Number", for: .normal)
        numberButton.addTarget(self, action: #selector(showNumberdownMenu), for: .touchUpInside)
        numberButton.setTitleColor(.black, for: UIControl.State.normal)
        numberButton.backgroundColor = .white
        numberButton.layer.cornerRadius = 10
        numberButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.setTitleColor(.black, for: UIControl.State.normal)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 10
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGreen
    }
    
    func layout() {
        view.addSubview(ButtonStack)
        view.addSubview(collectionView)
        
        ButtonStack.addArrangedSubview(dropdownButton)
        ButtonStack.addArrangedSubview(numberButton)
        ButtonStack.addArrangedSubview(searchButton)

        NSLayoutConstraint.activate([

            ButtonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ButtonStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            ButtonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: ButtonStack.bottomAnchor, multiplier: 5),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
        ])
    }
}

//MARK: - Collection View
extension FoodMainVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.configure(with: foods[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 250)
    }
    

}
