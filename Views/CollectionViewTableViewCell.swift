//
//  CollectionViewTableViewCell.swift
//  MoviesClone
//
//  Created by mona alshiakh on 13/05/1444 AH.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCellDidTapCell (_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModle)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    private var titles: [Title] = [Title]()
   static let identifeir = "CollectionViewTableViewCell"
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    //we need inside each cell a collection view to be a placeholder for movies titel and poster etc.
    private let collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        // each item of collection view to take the entire hight of the cell
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // neet the collection view to be the entaire body of the cell
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titels: [Title]) {
        self.titles = titels
        // cause we retrive the titles in homeVC  & then update the array titles here but since it happend in async function we need to reload the data in the collection view inside the main thread
        DispatchQueue.main.async {
            [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        
        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.title else {
            return
        }
        
        APIConnector.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElment):
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else {return}
                guard let strongSelf = self else {return}
                let viewModel = TitlePreviewViewModle(title: titleName, youtubeView: videoElment, titleOverview: titleOverview)
                self?.delegate?.CollectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //it a function for downloading the title trailer
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
    let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
        let downloadAction = UIAction(title: "Yes", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { [weak self] (_) in
            self?.downloadTitleAt(indexPath: indexPath)
                print("downloaded")
            }
            
        return UIMenu(title: "Download this trailer?", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [downloadAction])
            
        }
        return context
        
    }

}
