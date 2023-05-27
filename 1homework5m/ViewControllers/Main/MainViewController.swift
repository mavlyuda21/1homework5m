//
//  ViewController.swift
//  1homework5m
//
//  Created by mavluda on 17/5/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var typesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.estimatedItemSize = CGSize(width: 90, height: 36)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TypesCell.self, forCellWithReuseIdentifier: "cell")
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        return collection
    }()
    
    private lazy var circleCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.estimatedItemSize = CGSize(width: 90 , height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CircleCell.self, forCellWithReuseIdentifier: "secondCell")
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        return collection
    }()
    
    let searchBar = UISearchBar()
    
    private lazy var productsTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(ProductCell.self, forCellReuseIdentifier: "productCell")
        return view
    }()
    
    private lazy var openTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .thin)
        return view
    }()
    
    private var viewModel: MainViewModel? = nil
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadProductsWithAsyncAwait()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUserInterface(){
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
    
    private func setupUI(){
        typesCollectionView.dataSource = self
        typesCollectionView.delegate = self
        
        
        searchBar.placeholder = "Find store by name"
        searchBar.layer.backgroundColor = UIColor.white.cgColor
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.backgroundColor = .white
        searchBar.layer.shadowColor = UIColor.systemGray.cgColor
        searchBar.layer.shadowRadius = 5
        searchBar.layer.shadowOpacity = 0.3
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchBar.isUserInteractionEnabled = false
        let searchView = UIView()
        
        view.addSubview(typesCollectionView)
        typesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(55)
            make.leading.equalToSuperview().offset(12)
            make.right.equalToSuperview()
        }
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(typesCollectionView.snp.bottom).offset(31)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(48)
        }
        
        let filterButton: UIButton = {
            let view = UIButton(type: .system)
            view.setBackgroundImage(UIImage(named: "filter"), for: .normal)
            view.setTitle("", for: .normal)
            return view
        }()
        
        searchView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        searchView.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.trailing.equalTo(searchView).offset(-16)
        }
        
        circleCollectionView.delegate = self
        circleCollectionView.dataSource = self
        
        view.addSubview(circleCollectionView)
        circleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.leading.equalTo(searchView)
            make.trailing.equalToSuperview()
            make.height.equalTo(115)
        }
        
        view.addSubview(openTitle)
        openTitle.snp.makeConstraints { make in
            make.top.equalTo(circleCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
        }
        
        view.addSubview(productsTableView)
        productsTableView.snp.makeConstraints { make in
            make.top.equalTo(openTitle.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(circleCollectionView){
            return viewModel?.getCircleCount() ?? 0
        }else{
            return viewModel?.getTypesCount() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(typesCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TypesCell
            cell.fill(text: viewModel?.getType(indexPath.row) ?? "")
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as! CircleCell
            cell.fill(
                title: viewModel?.getCircleTitle(indexPath.row) ?? "",
                image: viewModel?.getCircleImage(indexPath.row) ?? ""
            )
            return cell
        }
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getProductsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.fill(
            title: viewModel?.getProductTitle(indexPath.row) ?? "",
            image: viewModel?.getProductImage(indexPath.row) ?? "",
            rating: viewModel?.getProductRating(indexPath.row) ?? 0.0,
            category: viewModel?.getProductCategory(indexPath.row) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension MainViewController: UpdateUIDelegate{
    func updateUI(){
        self.updateUserInterface()
    }
}
