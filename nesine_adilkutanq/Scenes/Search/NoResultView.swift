//
//  NoResultView.swift
//  nesine_adilkutanq
//
//  Created by Adil Kutan Çıngısız on 5.09.2023.
//

import UIKit

final class NoResultView: UIView {
    
    private let image: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo.artframe"))
        return imageView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.text = "No Result"
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [image, title].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        title.centerXAnchor.constraint(equalTo: image.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
