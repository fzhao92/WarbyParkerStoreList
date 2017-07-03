//
//  APIClient.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


enum WarbyParkerAPI: URLRequestConvertible {
    
    case StoreList
    
    func asURLRequest() throws -> URLRequest {
        var request: URLRequest
        
        switch self {
            
        case .StoreList:
            let url = URL(string: "https://www.warbyparker.com/api/v2/retail/locations")
            request = URLRequest(url: url!)
            request.httpMethod = "GET"
        
        }
        
        return request
    }
}

class APIClient {
    
    static let shared = APIClient()
    
    private init() { }
    
    let imageDownloader = ImageDownloader()
    
    func getListOfStores(completion: @escaping ([StoreModel]?) -> Void) {
        
        Alamofire.request(WarbyParkerAPI.StoreList).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                let locationJson = JSON(value)
                let locations = locationJson["locations"].arrayValue
                
                var stores = [StoreModel]()
                for json in locations {
                    stores.append(StoreModel(dict: json))
                }
                
                completion(stores)
                
            case .failure(let error):
                print("Failed to get valid response: \(error.localizedDescription)")
                completion(nil)
            
            }
            
        }
        
    }
    
    func downloadImage(forUrl url: String, completion: @escaping (UIImage?) -> Void) {
        
        let request = URLRequest(url: URL(string: url)!)
        
        imageDownloader.download(request) { (response) in
            
            switch response.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Image download failed: \(error.localizedDescription)")
            }
            
        }
        
    }
    
}

