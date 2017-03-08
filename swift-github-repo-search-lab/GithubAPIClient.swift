//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Alamofire

class GithubAPIClient {
    
    class func getRepositories(with completion: @escaping ([Any]) -> ()) {
        let urlString = "https://api.github.com/repositories?client_id=\(Secret.ID)&client_secret=\(Secret.secret)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }) 
        task.resume()
    }
    

    
    
//    class func checkIfRepositoryIsStarred(fullName: String, completion: @escaping (Bool) -> Void) {
//        let urlString = "https://api.github.com/user/starred/\(fullName)"
//        let url = URL(string: urlString)
//        if let url = url {
//            var urlRequest = URLRequest(url: url)
//            urlRequest.addValue("token \(Secret.token)", forHTTPHeaderField: "Authorization")
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
//                if let response = response {
//                    do {
//                        if let responseJSON = response as? HTTPURLResponse {
//                            if responseJSON.statusCode == 204 {
//                                completion(true)
//                            } else if responseJSON.statusCode == 404 {
//                                completion(false)
//                            }
//
//                            print(responseJSON.statusCode)
//                        }
//                    } catch {
//                        
//                    }
//                }
//            })
//            dataTask.resume()
//            
//        }
//    }
    
    class func checkIfRepositoryIsStarred(fullName: String, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization" : "token \(Secret.token)"
        ]
        Alamofire.request("https://api.github.com/user/starred/\(fullName)", headers: headers).responseJSON { (response) in
            if let JSON = response.response?.statusCode {
                if JSON == 204 {
                    completion(true)
                } else if JSON == 404 {
                    completion(false)
                }
                print(JSON)
            }
        }
    }
    
//    class func starRepository(named: String, completion: @escaping () -> Void) {
//        GithubAPIClient.checkIfRepositoryIsStarred(fullName: named) { (starred) in
//            if starred == false {
//                let urlString = "https://api.github.com/user/starred/\(named)"
//                let url = URL(string: urlString)
//                if let url = url {
//                    var urlRequest = URLRequest(url: url)
//                    urlRequest.addValue("token \(Secret.token)", forHTTPHeaderField: "Authorization")
//                    urlRequest.httpMethod = "PUT"
//                    let session = URLSession.shared
//                    let dataTask = session.dataTask(with: urlRequest)
//                    dataTask.resume()
//                }
//            }
//            completion()
//            
//
//
//            
//        }
//    }
    
    

    class func starRepository(named: String, completion: @escaping () -> Void) {
        GithubAPIClient.checkIfRepositoryIsStarred(fullName: named) { (starred) in
            if starred == false {
                let headers: HTTPHeaders = [
                    "Authorization": "token \(Secret.token)"
                ]
                Alamofire.request("https://api.github.com/user/starred/\(named)", method: .put, headers: headers).responseJSON { (response) in
                    print("STARRING: \(response)")
                    completion()
                }
            }

        }
    }
    
    
    
    
    
    
//    
//    class func unstarRepository(named: String, completion: @escaping () -> Void) {
//        GithubAPIClient.checkIfRepositoryIsStarred(fullName: named) { (starred) in
//            if starred == true {
//                let urlString = "https://api.github.com/user/starred/\(named)"
//                let url = URL(string: urlString)
//                if let url = url {
//                    var urlRequest = URLRequest(url: url)
//                    urlRequest.addValue("token \(Secret.token)", forHTTPHeaderField: "Authorization")
//                    urlRequest.httpMethod = "DELETE"
//                    let session = URLSession.shared
//                    let dataTask = session.dataTask(with: urlRequest)
//                    dataTask.resume()
//                }
//            }
//            completion()
//            
//            
//            
//            
//        }
//    }
    
    
    
    class func unstarRepository(named: String, completion: @escaping () -> Void) {
        GithubAPIClient.checkIfRepositoryIsStarred(fullName: named) { (starred) in
            if starred == true {
                let headers: HTTPHeaders = [
                    "Authorization": "token \(Secret.token)"
                ]
                Alamofire.request("https://api.github.com/user/starred/\(named)", method: .delete, headers: headers).responseJSON { (response) in
                    print("STARRING: \(response)")
                    completion()
                }
            }
            
        }
    }

    
    
    
    
    class func searchForRepo(search: String, completion: @escaping ([[String:Any]]) -> Void) {
        Alamofire.request("https://api.github.com/search/repositories?q=\(search)").responseJSON { (response) in
            if let JSON = response.result.value as? [String: Any] {
                if let itemsArray = JSON["items"] as? [[String:Any]]{
                    completion(itemsArray)

                    
                }
                
            }
        }
    }

    
    
}
