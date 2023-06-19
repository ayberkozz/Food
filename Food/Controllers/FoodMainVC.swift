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
    
    private var searchLabel = UILabel()
    private var emptyLabel = UILabel()
    
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
            self.updateEmptyLabelVisibility()
            self.updateSearchLabelVisibility()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
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
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Food🥘"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
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
        dropdownButton.setTitleColor(.white, for: UIControl.State.normal)
        dropdownButton.backgroundColor = .systemGreen
        dropdownButton.layer.cornerRadius = 10
        dropdownButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        numberButton.translatesAutoresizingMaskIntoConstraints = false
        numberButton.setTitle("Number", for: .normal)
        numberButton.addTarget(self, action: #selector(showNumberdownMenu), for: .touchUpInside)
        numberButton.setTitleColor(.white, for: UIControl.State.normal)
        numberButton.backgroundColor = .systemGreen
        numberButton.layer.cornerRadius = 10
        numberButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.setTitleColor(.white, for: UIControl.State.normal)
        searchButton.backgroundColor = .systemGreen
        searchButton.layer.cornerRadius = 10
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "We can't find anything😞"
        emptyLabel.textColor = UIColor.systemGray
        emptyLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        searchLabel.text = "Welcome! Start by searching foods😋"
        searchLabel.textColor = UIColor.systemGray
        searchLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
    }
    
    func layout() {
        
        view.addSubview(ButtonStack)
        view.addSubview(collectionView)
        view.addSubview(searchLabel)
        
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
            
            searchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func updateSearchLabelVisibility() {
        if searchController.searchBar.text?.isEmpty ?? true {
            searchLabel.isHidden = false
        } else {
            searchLabel.isHidden = true
        }
    }

    
    private func updateEmptyLabelVisibility() {
        if foods.isEmpty && emptyLabel.superview == nil {
            view.addSubview(emptyLabel)
            NSLayoutConstraint.activate([
                emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        } else if !foods.isEmpty && emptyLabel.superview != nil {
            emptyLabel.removeFromSuperview()
        }
    }
    
}

//MARK: - Collection View
extension FoodMainVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if foods.isEmpty {
            return 0
        } else {
            return foods.count
        }
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
