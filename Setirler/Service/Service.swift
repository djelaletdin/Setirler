//
//  Service.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 01.04.2021.
//

import UIKit

class Service {
    
    static let shared = Service()
    
    func showError(rootView: UICollectionViewController, message: String) {
        let newViewController = ErrorViewController()
        rootView.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        rootView.navigationController?.pushViewController(newViewController, animated: false)
    }
    
    func fetchHomeFeed(completion: @escaping (OrderRawData?, Error?) -> ()) {
        let urlString = "http://poem.realapps.xyz/api/index"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSearchTerm(searchTerm: String, completion: @escaping (SearchRawData?, Error?) -> ()) {
        let newSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        let urlString = "http://poem.realapps.xyz/api/search?q=\(newSearchTerm)"
        print(urlString)
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchPoems(id: Int, page:Int, type: String, completion: @escaping (PoemListRawData?, Error?) -> ()) {
        switch type {
        case "poet":
            let urlString = "http://poem.realapps.xyz/api/poet/\(id)?page=\(page)"
            print(urlString)
            fetchGenericJSONData(urlString: urlString, completion: completion)
        case "tag":
            let urlString = "http://poem.realapps.xyz/api/tag/\(id)?page=\(page)"
            print("i am here heereeee")
            print(urlString)
            fetchGenericJSONData(urlString: urlString, completion: completion)
        case "category":
            let urlString = "http://poem.realapps.xyz/api/category/\(id)?page=\(page)"
            print(urlString)
            fetchGenericJSONData(urlString: urlString, completion: completion)
        default:
            let urlString = "http://poem.realapps.xyz/api/poet/\(id)?page=\(page)"
            fetchGenericJSONData(urlString: urlString, completion: completion)
        }
    }
    
    
    func fetchCategoryDetails(id: Int, page:Int, completion: @escaping (CategoryRawData?, Error?) -> ()) {
            let urlString = "http://poem.realapps.xyz/api/category/\(id)?page=\(page)"
            fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchAllPoets(page:Int, completion: @escaping (CategoryRawData?, Error?) -> ()) {
            let urlString = "http://poem.realapps.xyz/api/poets/?page=\(page)"
        
            print(urlString)
        
            fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
}
