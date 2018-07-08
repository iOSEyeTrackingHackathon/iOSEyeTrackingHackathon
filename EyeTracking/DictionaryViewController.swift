//
//  DictionaryViewController.swift
//  EyeTracking
//
//  Created by Presto on 2018. 7. 7..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import UIKit
import RealmSwift

class DictionaryViewController: UIViewController {
    
    let realm = try! Realm()
    var object: Results<WordInfo>!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.object = realm.objects(WordInfo.self)
        self.backButton.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension DictionaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DictionaryCell else { return UICollectionViewCell() }
        let data = self.object[indexPath.row]
        cell.word.text = data.word
        cell.meaning.text = data.meaning
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.object.count
    }
}

extension DictionaryViewController: UICollectionViewDelegate {
    
}
