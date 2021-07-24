//
//  Service.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 01.04.2021.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchHomeFeed(completion: @escaping (OrderRawData?, Error?) -> ()) {
        let urlString = "http://poem.djelaletdin.com/public/api/index"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSearchTerm(searchTerm: String, completion: @escaping (SearchRawData?, Error?) -> ()) {
        print("Fetching search results")
        let newSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        let urlString = "http://poem.djelaletdin.com/public/api/search?q=\(newSearchTerm)"
        print(urlString)
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchPoems(id: Int, page:Int, type: String, completion: @escaping (PoemListRawData?, Error?) -> ()) {
        switch type {
        case "poet":
            let urlString = "http://poem.djelaletdin.com/public/api/poet/\(id)?page=\(page)"
            fetchGenericJSONData(urlString: urlString, completion: completion)
        case "tag":
            let urlString = "http://poem.djelaletdin.com/public/api/tag/\(id)?page=\(page)"
            print(urlString)
            fetchGenericJSONData(urlString: urlString, completion: completion)
        default:
            let urlString = "http://poem.djelaletdin.com/public/api/poet/\(id)?page=\(page)"
            fetchGenericJSONData(urlString: urlString, completion: completion)
        }
    }
    
    
    // declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        print("T is type:", T.self)
        
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
