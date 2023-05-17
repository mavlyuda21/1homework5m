//
//  ViewController.swift
//  1homework5m
//
//  Created by mavluda on 17/5/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
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
    
    private let types = ["Delivery","Pickup","Catering","Curbside"]
    private let circles = [
        Circle(name: "Takeaways", image: "1"),
        Circle(name: "Grocery", image: "2"),
        Circle(name: "Convenience", image: "3"),
        Circle(name: "Pharmacy", image: "4")
    ]
    
    private var products: [Product] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
    }
    
    private func loadData(){
        NetworkManager.shared.downloadProductsWithCompletion { products in
            self.products = products
            self.openTitle.text = "\(products.count) stores Open"
            self.reloadView()
        }
        
    }
    func reloadView(){
            self.productsTableView.reloadData()
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(circleCollectionView){
            return circles.count
        }else{
            return types.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(typesCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TypesCell
            cell.fill(text: types[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as! CircleCell
            cell.circle = circles[indexPath.row]
            return cell
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.fill(title: products[indexPath.row].title, image: products[indexPath.row].images.randomElement() ?? "", rating: products[indexPath.row].rating, category: products[indexPath.row].category)
        return cell
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 300
        }
}


