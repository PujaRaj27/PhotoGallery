//
//  ViewController.swift
//  PhotoGallery
//
//  Created by PujaRaj on 15/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: - Properties
    
    let listView = ListView()
    var pictureInfo = [ImageModel]() {
        didSet{
            DispatchQueue.main.async {
                self.listView.myCollectionView.reloadData()
                print(self.pictureInfo[0].urls)
            }
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = listView
        listView.myCollectionView.dataSource = self
        listView.myCollectionView.delegate = self
        fetchImages()
        setNavBtn()
    }
    
    //MARK: - Functions
    
    func setNavBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: listView.addBtn)
        listView.addBtn.addTarget(self, action: #selector(addImages), for: .touchUpInside)
    }
    
    @objc func addImages() {
        DispatchQueue.main.async {
            self.fetchImages()
        }
        
    }
    
    func fetchImages() {
        var ApiKeys = "89vrJbT0Vlzo0E7Acbp38igBQALR6m3HIY9AIg8iG60"
        let address = "https://api.unsplash.com/photos/?client_id=\(ApiKeys)&order_by=ORDER&per_page=30"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }else if let response = response as? HTTPURLResponse, let data = data {
                    print("Status Code: \(response.statusCode)")
                    do{
                        let decoder = JSONDecoder()
                        let picInfo = try decoder.decode([ImageModel].self, from: data)
                        self.pictureInfo.append(contentsOf: picInfo)
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
        
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictureInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.collectionViewId, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        DispatchQueue.main.async {
            cell.myImageView.loadImages(from: self.pictureInfo[indexPath.row].urls.regularUrl)
        }
        
        return cell
    }
    
    
}

