//
//  MoviesViewController.swift
//  TVApp
//
//  Created by Nitin Bhatt on 4/27/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var viewModel = {
        MovieViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.initCollectionSubview()
    }
    
    func initCollectionSubview(){
        collectionView.register(MoviesCell.nib, forCellWithReuseIdentifier: MoviesCell.identifier)
        viewModel.getMovies()
        viewModel.reloadCollectionView = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()

            }
        }
    }
}

extension MoviesViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-100)/3
        return CGSize(width: width, height: view.frame.height - 550)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCell.identifier, for: indexPath) as? MoviesCell else{
            fatalError("xib not loaded")
        }
        
        cell.cellViewModel =  viewModel.getMovieWithIndex(index: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "MoviePlayerViewController") as? MoviePlayerViewController{
            controller.url = viewModel.getMovieWithIndex(index: indexPath).trailerUrl
            self.present(controller, animated: true, completion: nil)
        }
    }
}
