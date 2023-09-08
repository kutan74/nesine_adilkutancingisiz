//
//  SoftwareCollectionViewCell.swift
//  nesine_adilkutanq
//
//  Created by Adil Kutan Çıngısız on 4.09.2023.
//

import UIKit

class SoftwareCollectionViewCell: UICollectionViewCell {
    
    let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var spinner = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(artworkImageView)
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        artworkImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        artworkImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        artworkImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        artworkImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.topAnchor.constraint(equalTo: topAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        spinner.isHidden = true
    }
    
    func showSpinner() {
        spinner.isHidden = false
        artworkImageView.isHidden = true
    }
    
    func hideSpinner() {
        spinner.isHidden = true
        artworkImageView.isHidden = false
    }
}
