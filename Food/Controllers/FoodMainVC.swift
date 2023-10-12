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
    private var maxFatButton = UIButton()
    private var numberButton = UIButton()
    private var dietButton = UIButton()
    private var searchButton = UIButton()

    private var searchLabel = UILabel()
    private var emptyLabel = UILabel()
    
    private var buttonScrollView = UIScrollView()
    
    private var FoodsCV : UICollectionView!
    private var ButtonCV : UICollectionView!
    
    var searchParameters = SearchParameters()
    
    let maxFatMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "0","10","15","20","25","30","35","40","45","50","60","70","80","90","100","200"
        ]
        return menu
    }()

    let Numbermenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"
        ]
        return menu
    }()
    
    let DietMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "Gluten Free","Vegetarian","Lacto-Vegetarian","Ovo-Vegetarian","Vegan","Pescetarian","Paleo","Primal","Low FODMAP","Whole30","Ketogenic"
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
            self.FoodsCV.reloadData()
            self.updateEmptyLabelVisibility()
            self.updateSearchLabelVisibility()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestureRecognizer()
        setupDropdownMenu()
        style()
        layout()
    }
    
    private func setupDropdownMenu() {
        maxFatMenu.anchorView = maxFatButton
        maxFatMenu.selectionAction = { [weak self] index, item in
            self?.searchParameters.maxFat = Int(item)
        }
        
        Numbermenu.anchorView = numberButton
        Numbermenu.selectionAction = { [weak self] index, item1 in
            self?.searchParameters.number = Int(item1)
        }
        
        DietMenu.anchorView = dietButton
        DietMenu.selectionAction = { [weak self] index, item1 in
            self?.searchParameters.diet = item1
        }
    }
    
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        searchController.searchBar.resignFirstResponder()
    }

    @objc private func showDropdownMenu() {
        maxFatMenu.show()
    }
    
    @objc private func showNumberdownMenu() {
        Numbermenu.show()
    }
    
    @objc private func showDietdownMenu() {
        DietMenu.show()
    }

    @objc private func searchButtonPressed() {
        let query = searchController.searchBar.text
        viewModel.fetchFoods(query: query, parameters: searchParameters)
        maxFatMenu.clearSelection()
        Numbermenu.clearSelection()
        DietMenu.clearSelection()
    }

    func style() {
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Foods🥘"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Character"
        
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
        
        ButtonStack.translatesAutoresizingMaskIntoConstraints = false
        ButtonStack.axis = .horizontal
        ButtonStack.spacing = 10
        
        buttonScrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.showsHorizontalScrollIndicator = false
        buttonScrollView.contentSize = CGSize(width: (view.frame.width / 2.5 + 15) * 4, height: 50)
        
        maxFatButton.translatesAutoresizingMaskIntoConstraints = false
        maxFatButton.setTitle("Max Fat", for: .normal)
        maxFatButton.addTarget(self, action: #selector(showDropdownMenu), for: .touchUpInside)
        maxFatButton.setTitleColor(.white, for: UIControl.State.normal)
        maxFatButton.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        maxFatButton.layer.cornerRadius = 5
        maxFatButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        numberButton.translatesAutoresizingMaskIntoConstraints = false
        numberButton.setTitle("Number", for: .normal)
        numberButton.addTarget(self, action: #selector(showNumberdownMenu), for: .touchUpInside)
        numberButton.setTitleColor(.white, for: UIControl.State.normal)
        numberButton.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        numberButton.layer.cornerRadius = 5
        numberButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

        dietButton.translatesAutoresizingMaskIntoConstraints = false
        dietButton.setTitle("Diet", for: .normal)
        dietButton.addTarget(self, action: #selector(showDietdownMenu), for: .touchUpInside)
        dietButton.setTitleColor(.white, for: UIControl.State.normal)
        dietButton.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        dietButton.layer.cornerRadius = 5
        dietButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.setTitleColor(.white, for: UIControl.State.normal)
        searchButton.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        searchButton.layer.cornerRadius = 5
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        let layout1 = UICollectionViewFlowLayout()
        FoodsCV = UICollectionView(frame: .zero, collectionViewLayout: layout1)
        FoodsCV.translatesAutoresizingMaskIntoConstraints = false
        FoodsCV.register(FoodsMainCVC.self, forCellWithReuseIdentifier: FoodsMainCVC.identifier)
        FoodsCV.delegate = self
        FoodsCV.dataSource = self
        FoodsCV.backgroundColor = .systemBackground
        
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
        
        view.addSubview(buttonScrollView)
        view.addSubview(FoodsCV)
        view.addSubview(searchLabel)
        
        buttonScrollView.addSubview(ButtonStack)
        
        ButtonStack.addArrangedSubview(maxFatButton)
        ButtonStack.addArrangedSubview(dietButton)
        ButtonStack.addArrangedSubview(numberButton)
        ButtonStack.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            buttonScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonScrollView.heightAnchor.constraint(equalToConstant: 50),

            maxFatButton.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            maxFatButton.leadingAnchor.constraint(equalTo: ButtonStack.leadingAnchor, constant: 10),
            maxFatButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
            maxFatButton.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),

            numberButton.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            numberButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
            numberButton.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),

            searchButton.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
            searchButton.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),

            dietButton.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            dietButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
            dietButton.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),

            FoodsCV.topAnchor.constraint(equalToSystemSpacingBelow: buttonScrollView.bottomAnchor, multiplier: 5),
            FoodsCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            FoodsCV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FoodsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            FoodsCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! FoodsMainCVC
        cell.configure(with: foods[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = RecipeViewModel(foodService: FoodService(), favListService: FavListService())
        let recipeVC = RecipeVC(viewModel: viewModel)
        recipeVC.foodId = foods[indexPath.row].id
        navigationController?.pushViewController(recipeVC, animated: true)
    }

}
