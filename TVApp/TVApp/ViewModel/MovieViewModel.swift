//
//  MovieViewModel.swift
//  TVApp
//
//  Created by Nitin Bhatt on 4/17/22.
//

import Foundation

class MovieViewModel{
    
    var reloadCollectionView:(() -> Void)?
    
    var movies = [MovieCellViewModel](){
        didSet{
            reloadCollectionView?()
        }
    }
    
    func getMovies(){
        GetMoviesService().getMovies(completion: { movies,succes,message  in
            if succes == true{
                for index in 0..<movies.count{
                    self.movies.append(MovieCellViewModel(name: movies[index].title, thumnailUrl: movies[index].coverUrl, trailerUrl: movies[index].trailerUrl))
                }
            }else{
                //Display alert
            }
        })
    }
    
    func getMovieWithIndex(index:IndexPath)-> MovieCellViewModel{
        return self.movies[index.row]
    }
}
