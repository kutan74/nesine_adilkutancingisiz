//
//  SearchViewModel.swift
//  nesine_adilkutanq
//
//  Created by Adil Kutan Çıngısız on 4.09.2023.
//

import UIKit

class SearchViewModel {
    
    private let networking = Network()
    
    private var searchTask: DispatchWorkItem?
    
    var softwares: [Software] = []
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    func makeSearch(term: String, completion: @escaping ([Software]) -> Void) {
        pendingRequestWorkItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.networking.search(term: term) { softwares in
                completion(softwares ?? [])
            }
        }
        
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(350),
                                      execute: requestWorkItem)
    }
    
    func images(forURLs urls: [String], completion: @escaping ([UIImage?]) -> Void) {
        let group = DispatchGroup()
        var images: [UIImage?] = .init(repeating: nil, count: urls.count)
        
        for (index, urlString) in urls.enumerated() {
            group.enter()
            DispatchQueue.global().async {
                DispatchQueue.concurrentPerform(iterations: 3) { i in
                    var image: UIImage?
                    if let url = URL(string: urlString) {
                        if let data = try? Data(contentsOf: url) {
                            image = UIImage(data: data)
                        }
                    }
                    images[index] = image
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(images)
        }
    }
}
