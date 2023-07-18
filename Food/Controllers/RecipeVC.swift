//
//  RecipeVC.swift
//  Food
//
//  Created by Ayberk Öz on 23.06.2023.
//

import UIKit
import SDWebImage
import Firebase

class RecipeVC: UIViewController, RecipeViewModelOutput{
        
    private let viewModel: RecipeViewModel
    private var recipe: RecipeModel!
    private let userViewModel = UserViewModel(UserService: UserService())

    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let foodImage = UIImageView()
    
    private let HStack = UIStackView()
    private let VStack = UIStackView()

    private let titleView = UIView()
    private let view1 = UIView()

    private let ingredientsButton = UIButton()
    private let HeartButton = UIButton(type: .custom)

    private let titleLabel = UILabel()
    
    private var ingTableView = UITableView()
    
    private let Features = UIStackView()
    
    private let HealthScoreLabel = UILabel()
    private let ServingLabel = UILabel()
    private let priceLabel = UILabel()
    private let vegetarianLabel = UILabel()
    private let veganLabel = UILabel()
    private let dairyFreeLabel = UILabel()
    private let glutenFreeLabel = UILabel()
    private let preparetionMinutesLabel = UILabel()
    private let cookingMinutesLabel = UILabel()
    private let healtScoreLabel = UILabel()
        
    private var FavList = [String]()

    var foodId = Int()
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(value: RecipeModel) {
        recipe = value
        DispatchQueue.main.async {
            self.titleLabel.text = self.recipe?.title
            if let recipe = self.recipe, !recipe.extendedIngredients.isEmpty {
                self.ingTableView.reloadData()
            }
            self.HealthScoreLabel.text = "Healt Score:\(String(describing: self.recipe.healthScore))"
            self.ServingLabel.text = "Serving:\(String(describing: self.recipe.servings))"
            self.priceLabel.text = "Price Per Service:\(String(describing: self.recipe.pricePerServing))"
            self.preparetionMinutesLabel.text = "Preparetion Minutes:\(String(describing: self.recipe.preparationMinutes))"
            self.cookingMinutesLabel.text = "Cooking Minutes:\(String(describing: self.recipe.cookingMinutes))"
            self.HealthScoreLabel.text = "Health Score:\(String(describing: self.recipe.healthScore))"
            self.updateBoolLabel(label: self.vegetarianLabel, value: self.recipe.vegetarian, text: "Vegetarian:")
            self.updateBoolLabel(label: self.veganLabel, value: self.recipe.vegan, text: "Vegan:")
            self.updateBoolLabel(label: self.dairyFreeLabel, value: self.recipe.dairyFree, text: "Dairy Free:")
            self.updateBoolLabel(label: self.glutenFreeLabel, value: self.recipe.glutenFree, text: "Gluten Free:")

            self.foodImage.sd_setImage(with: URL(string: self.recipe.image)) { image, error, cacheType, url in
                if error != nil {
                    self.foodImage.image = UIImage(systemName: "photo")
                }
            }
            self.setupHeartButton()
        }
    }
    
    func updateFavList(value: FavListModel) {
        self.FavList = value.favs
        DispatchQueue.main.async {
            self.setupHeartButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if foodId == 0 {
            viewModel.fetchRandomRecipe()
        } else {
            viewModel.fetchRecipe(id: foodId)
        }
        userViewModel.fetchUser()
        viewModel.fetchFavList()

        style()
        layout()
    }
    
    private func updateBoolLabel(label: UILabel, value: Bool, text: String) {
        let labelValue = value ? "\(text) ✅" : "\(text) ❌"
        label.text = labelValue
    }
    
    
    private func style() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "Recipe Detail"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.layer.borderColor = UIColor.gray.cgColor
        foodImage.layer.borderWidth = 1.0
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.layer.cornerRadius = 15
        titleView.backgroundColor = .white
                
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        
        HStack.translatesAutoresizingMaskIntoConstraints = false
        HStack.axis = .horizontal
        HStack.spacing = 2
        
        VStack.translatesAutoresizingMaskIntoConstraints = false
        VStack.axis = .vertical
        VStack.alignment = .center
        VStack.spacing = 20
        
        ingredientsButton.translatesAutoresizingMaskIntoConstraints = false
        ingredientsButton.setTitle("Ingredients ↓", for: .normal)
        ingredientsButton.setTitleColor(.black, for: UIControl.State.normal)
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.tintColor = .gray
        view1.layer.cornerRadius = 15
        view1.backgroundColor = .white
        view1.layer.borderColor = UIColor.gray.cgColor
        view1.layer.borderWidth = 1.0
        
        ingTableView.translatesAutoresizingMaskIntoConstraints = false
        ingTableView.delegate = self
        ingTableView.dataSource = self
        ingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")

        Features.translatesAutoresizingMaskIntoConstraints = false
        Features.axis = .vertical
        Features.alignment = .leading
        Features.spacing = 2
        Features.tintColor = .gray
        Features.layer.cornerRadius = 15
        Features.backgroundColor = .white
        Features.layer.borderColor = UIColor.gray.cgColor
        Features.layer.borderWidth = 1.0
        Features.isLayoutMarginsRelativeArrangement = true
        Features.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        healtScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        healtScoreLabel.font.withSize(25)
        healtScoreLabel.numberOfLines = 0
        
        ServingLabel.translatesAutoresizingMaskIntoConstraints = false
        ServingLabel.font.withSize(25)
        ServingLabel.numberOfLines = 0
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font.withSize(25)
        priceLabel.numberOfLines = 0
        
        vegetarianLabel.translatesAutoresizingMaskIntoConstraints = false
        vegetarianLabel.font.withSize(25)
        vegetarianLabel.numberOfLines = 0
        
        veganLabel.translatesAutoresizingMaskIntoConstraints = false
        veganLabel.font.withSize(25)
        veganLabel.numberOfLines = 0
        
        dairyFreeLabel.translatesAutoresizingMaskIntoConstraints = false
        dairyFreeLabel.font.withSize(25)
        dairyFreeLabel.numberOfLines = 0

        glutenFreeLabel.translatesAutoresizingMaskIntoConstraints = false
        glutenFreeLabel.font.withSize(25)
        glutenFreeLabel.numberOfLines = 0
        
        preparetionMinutesLabel.translatesAutoresizingMaskIntoConstraints = false
        preparetionMinutesLabel.font.withSize(25)
        preparetionMinutesLabel.numberOfLines = 0
        
        cookingMinutesLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingMinutesLabel.font.withSize(25)
        cookingMinutesLabel.numberOfLines = 0
        
        healtScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        healtScoreLabel.font.withSize(25)
        healtScoreLabel.numberOfLines = 0
    }
    
    private func layout() {
        
        view.addSubview(scrollView)
        view.addSubview(foodImage)
        view.addSubview(titleView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(VStack)
        
        titleView.addSubview(titleLabel)
        
        VStack.addArrangedSubview(view1)
        VStack.addArrangedSubview(Features)
        
        view1.addSubview(HStack)
        view1.addSubview(ingTableView)
        
        HStack.addArrangedSubview(ingredientsButton)
                
        Features.addArrangedSubview(healtScoreLabel)
        Features.addArrangedSubview(ServingLabel)
        Features.addArrangedSubview(priceLabel)
        Features.addArrangedSubview(vegetarianLabel)
        Features.addArrangedSubview(veganLabel)
        Features.addArrangedSubview(dairyFreeLabel)
        Features.addArrangedSubview(glutenFreeLabel)
        Features.addArrangedSubview(preparetionMinutesLabel)
        Features.addArrangedSubview(cookingMinutesLabel)
        Features.addArrangedSubview(healtScoreLabel)
        
        let height = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: view.topAnchor),
            foodImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),

            titleView.centerYAnchor.constraint(equalTo: foodImage.bottomAnchor),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            titleView.heightAnchor.constraint(equalToConstant: view.frame.height/15),

            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -8),
            
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: titleView.bottomAnchor, multiplier: 1),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            VStack.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 3),
            VStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            view1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            view1.heightAnchor.constraint(equalToConstant: view.frame.height/3),

            HStack.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
            HStack.topAnchor.constraint(equalToSystemSpacingBelow: view1.topAnchor, multiplier: 1),
            
            ingTableView.topAnchor.constraint(equalToSystemSpacingBelow: HStack.bottomAnchor, multiplier: 2),
            ingTableView.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            ingTableView.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
            ingTableView.bottomAnchor.constraint(equalTo: view1.bottomAnchor),
            
            Features.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            
        ])
    }
    
    
}

extension RecipeVC {
    
    private func setupHeartButton() {
        let hollowHeartImage = UIImage(named: "hollowHeart")
        let heartImage = UIImage(named: "heart")

        let isFilled = isRecipeInFavList()

        HeartButton.setImage(isFilled ? heartImage : hollowHeartImage, for: .normal)
        HeartButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        HeartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        containerView.addSubview(HeartButton)

        let heartBarButtonItem = UIBarButtonItem(customView: containerView)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        navigationItem.rightBarButtonItems = [flexibleSpace, heartBarButtonItem]
    }

    @objc private func heartButtonTapped() {
        let isFilled = isRecipeInFavList()

        if isFilled {
            removeFromFavs()
            HeartButton.setImage(UIImage(named: "hollowHeart"), for: .normal)
        } else {
            addToFavs()
            HeartButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    private func isRecipeInFavList() -> Bool {
        guard let recipeId = recipe?.id else {
            return false
        }
        return FavList.contains(String(recipeId))
    }

    private func removeFromFavs() {
        let id = recipe.id

        if let index = FavList.firstIndex(of: String(id)) {
            FavList.remove(at: index)

            let fbService = FBService()
            fbService.FBService(favIDs: FavList)
            print("Removed from favorites")
        }
        
    }
    
    private func addToFavs() {
        let id = recipe.id
        FavList.append(String(id))
        let fbService = FBService()
        fbService.FBService(favIDs: FavList)
        print("Added to favorites")
    }
    
}

extension RecipeVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.extendedIngredients.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellIdentifier")
        if let ingredient = recipe?.extendedIngredients[indexPath.row] {
            cell.textLabel?.text = ingredient.original
            cell.textLabel?.numberOfLines  = 0
        }
        return cell
    }

}
