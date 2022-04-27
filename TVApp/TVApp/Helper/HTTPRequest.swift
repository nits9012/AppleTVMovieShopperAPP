//
//  HTTPRequest.swift
//  TVApp
//
//  Created by Nitin Bhatt on 4/17/22.
//

import Foundation

class HTTPRequest{
    func getRequest(url:String,params: [String:String],completion:@escaping (Bool,Data?,String)->()){
        
        guard var component = URLComponents(string: url) else{
            print("failed to get url component")
            return
        }
        
        component.queryItems = params.map({key, value in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = component.url else{
            print("failed to get url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request){data,response,error in
            
            guard error == nil else{
                print("recevied error")
                completion(false,nil,"received error")
                return
            }
            
            guard let data = data else{
                print("not received data")
                completion(false,nil,"not received data")
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                print("http request failed")
                completion(false,nil,"http request failed")
                return
            }
            
            completion(true,data,"")
        }.resume()
    }
}
