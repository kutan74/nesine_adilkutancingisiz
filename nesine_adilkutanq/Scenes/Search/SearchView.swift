//
//  SearchView.swift
//  nesine_adilkutanq
//
//  Created by Adil Kutan Çıngısız on 4.09.2023.
//

import UIKit

class SearchView: UIView {
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        return textField
    }()
    
    var collectionView: UICollectionView!
    
    private let noResultView = NoResultView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        [searchTextField, noResultView].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        noResultView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noResultView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.size.width - 150, height: 150)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 40
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SoftwareCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 25).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func showNoResultView() {
        noResultView.isHidden = false
        collectionView.isHidden = true
    }
    
    func showSearchResults() {
        noResultView.isHidden = true
        collectionView.isHidden = false
    }
}
