//
//  GetMoviesService.swift
//  TVApp
//
//  Created by Nitin Bhatt on 4/17/22.
//

import Foundation

class GetMoviesService{
    
        func getMovies(completion:@escaping(Movie,Bool,String)->()){
        HTTPRequest().getRequest(url: "https://itunes.apple.com/us/rss/topmovies/limit=100/json", params: ["":""], completion: {success,results,message in
            
            if success == true{
                do{
                    if let response = try JSONSerialization.jsonObject(with: results!, options: []) as? [String:Any]{
                        let feed = response["feed"] as AnyObject
                        var movies = Movie()
                        
                        if let entry = feed["entry"] as? [AnyObject]{
                            for index in 0..<entry.count{
                                let name = entry[index]["im:name"] as AnyObject
                                let image = entry[index]["im:image"] as AnyObject
                                let coverImage = image[0]  as AnyObject
                                let trailer = entry[index]["link"] as AnyObject
                                let trailerIndex = trailer[1] as AnyObject
                                let trailerUrl = trailerIndex["attributes"] as AnyObject
                                
                                
                                movies.append(Movies(title: name["label"] as? String ?? "", summary: "", director: "", price: "", coverUrl: (coverImage["label"] as? String)?.replacingOccurrences(of: "39x60", with: "400x400") ?? "", trailerUrl: trailerUrl["href"] as? String ?? "", movie: ""))
                            }
                        }
                        completion(movies,true,"")
                    }
                }catch let error as NSError{
                    print(error)
                    completion([],false,"Recevied error")
                }
            }else{
                completion([],false,"Recevied error")
            }
        })
    }
    
   
    
    
}



//                            for index in 0..<movies.count{
//                                print(movies[index].title)
//                                print(movies[index].coverUrl.replacingOccurrences(of: "39x60", with: "600x600"))
//                            }

//    for (entry of json["feed"]["entry"]) {
//        let movie = {};
//        movie.title = fixXML(entry["im:name"]["label"]);
//        movie.genre = fixXML(entry["category"]["attributes"]["label"]);
//        movie.summary = fixXML(entry["summary"]["label"]);
//        movie.director = fixXML(entry["im:artist"]["label"]);
//        movie.releaseDate = fixXML(entry["im:releaseDate"]["attributes"]["label"]);
//        movie.price = fixXML(entry["im:price"]["label"]);
//        movie.coverURL = fixXML(entry["im:image"][0]["label"]).replace("60x60", "600x600");
//        movie.link = fixXML(entry["link"][0]["attributes"]["href"]);
//        movie.trailerURL = fixXML(entry["link"][1]["attributes"]["href"]);
