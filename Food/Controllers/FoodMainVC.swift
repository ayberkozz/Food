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
    private var searchButton = UIButton()
    private var button = UIButton()

    private var searchLabel = UILabel()
    private var emptyLabel = UILabel()
    
    private var buttonScrollView = UIScrollView()
    
    private var FoodsCV : UICollectionView!
    private var ButtonCV : UICollectionView!
    
    var maxFat = Int()
    var number = Int()
    
    let menu: DropDown = {
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
        menu.anchorView = maxFatButton
        menu.selectionAction = { [weak self] index, item in
            self?.maxFat = Int(item)!
        }
        
        Numbermenu.anchorView = numberButton
        Numbermenu.selectionAction = { [weak self] index, item1 in
            self?.number = Int(item1)!
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
        menu.show()
    }
    
    @objc private func showNumberdownMenu() {
        Numbermenu.show()
    }

    @objc private func searchButtonPressed() {
        if number == 0 {
            viewModel.fetchFoods(query: searchController.searchBar.text, maxFat: maxFat, number: nil)
        } else {
            viewModel.fetchFoods(query: searchController.searchBar.text, maxFat: maxFat, number: number)
        }
    }
    
    func style() {
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Food🥘"
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
        
        let layout = UICollectionViewFlowLayout()
        ButtonCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ButtonCV.translatesAutoresizingMaskIntoConstraints = false
        ButtonCV.register(FoodsMainTVC.self, forCellWithReuseIdentifier: ButtonCVC.identifier)
        ButtonCV.delegate = self
        ButtonCV.dataSource = self
        ButtonCV.backgroundColor = .systemBackground
        
        ButtonStack.translatesAutoresizingMaskIntoConstraints = false
        ButtonStack.axis = .horizontal
        ButtonStack.spacing = 10
        
        buttonScrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.showsHorizontalScrollIndicator = false
        buttonScrollView.contentSize = CGSize(width: (view.frame.width / 1.5 + 3 + 2) * 3, height: 50)
        
        maxFatButton.translatesAutoresizingMaskIntoConstraints = false
        maxFatButton.setTitle("Max Fat", for: .normal)
        maxFatButton.addTarget(self, action: #selector(showDropdownMenu), for: .touchUpInside)
        maxFatButton.setTitleColor(.white, for: UIControl.State.normal)
        maxFatButton.backgroundColor = .systemGreen
        maxFatButton.layer.cornerRadius = 10
        maxFatButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
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
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        let layout1 = UICollectionViewFlowLayout()
        FoodsCV = UICollectionView(frame: .zero, collectionViewLayout: layout1)
        FoodsCV.translatesAutoresizingMaskIntoConstraints = false
        FoodsCV.register(FoodsMainTVC.self, forCellWithReuseIdentifier: FoodsMainTVC.identifier)
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
        
//        view.addSubview(ButtonStack)
        view.addSubview(buttonScrollView)
        view.addSubview(FoodsCV)
        view.addSubview(searchLabel)
        
        buttonScrollView.addSubview(ButtonStack)
        
        ButtonStack.addArrangedSubview(maxFatButton)
        ButtonStack.addArrangedSubview(numberButton)
        ButtonStack.addArrangedSubview(button)
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

            button.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            button.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
            button.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! FoodsMainTVC
        cell.configure(with: foods[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 250)
    }

}
