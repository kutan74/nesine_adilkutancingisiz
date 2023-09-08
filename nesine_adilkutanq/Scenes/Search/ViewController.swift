//
//  ViewController.swift
//  nesine_adilkutanq
//
//  Created by Adil Kutan Çıngısız on 4.09.2023.
//

import UIKit

class ViewController: UIViewController {

    private let subview = SearchView()
    private let viewModel = SearchViewModel()
    
    private var softwares: [Software] = []
    
    override func loadView() {
        view = subview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search Software"
        
        subview.collectionView.delegate = self
        subview.collectionView.dataSource = self
        subview.searchTextField.delegate = self
    }

}

extension ViewController: UITextFieldDelegate {
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let previousText:NSString = textField.text! as NSString
        let updatedText = previousText.replacingCharacters(in: range, with: string)
        
        print("searching: \(updatedText)")
        
        guard !updatedText.isEmpty else {
            subview.showNoResultView()
            return true
        }
                        
        viewModel.makeSearch(term: updatedText) { [weak self] softwares in            
            guard !softwares.isEmpty else {
                DispatchQueue.main.async {
                    self?.subview.showNoResultView()
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.subview.showSearchResults()
            }
                        
            self?.softwares = softwares
            DispatchQueue.main.async {
                self?.subview.collectionView.reloadData()
            }
        }
        
        return true
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        softwares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SoftwareCollectionViewCell {
            
            let software = softwares[indexPath.row]
            cell.showSpinner()
        
            viewModel.images(forURLs: software.screenshotUrls) { [weak self] images in
                cell.artworkImageView.image = images.first ?? UIImage(systemName: "arrow.down.circle")
                cell.hideSpinner()
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.images(forURLs: softwares[indexPath.row].screenshotUrls) { [weak self] images in
            if let image = images.first ?? UIImage(systemName: "photo.artframe") {
                let viewController = SoftwareDetailsViewController(image: image)
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

