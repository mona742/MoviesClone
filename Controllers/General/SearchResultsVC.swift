//
//  SearchResultsVC.swift
//  MoviesClone
//
//  Created by mona alshiakh on 05/08/1444 AH.
//

import UIKit

protocol SearchResultsCollectionViewDelegate: AnyObject {
    func searchResultsCollectionViewDidTapItem(_ viewModel: TitlePreviewViewModle)
}

class SearchResultsVC: UIViewController {
    
    public var titles: [Title] = [Title]()
    
    public var delegate: SearchResultsCollectionViewDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    


}


extension SearchResultsVC:  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        APIConnector.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let VideoElement):
                self?.delegate?.searchResultsCollectionViewDidTapItem(TitlePreviewViewModle(title: titleName, youtubeView: VideoElement, titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
