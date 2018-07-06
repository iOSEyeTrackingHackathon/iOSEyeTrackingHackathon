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

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension DictionaryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let obj = self.realm.objects(WordInfo.self)
        return obj.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as? DictionaryCell else { return UITableViewCell() }
        
        let obj = self.realm.objects(WordInfo.self)
        cell.wordText?.text = obj[indexPath.row].word
        cell.nounText?.text = obj[indexPath.row].noun
        cell.verbText?.text = obj[indexPath.row].verb
        return cell
    }
}

extension DictionaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
