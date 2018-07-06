//
//  DictionaryViewController.swift
//  EyeTracking
//
//  Created by Presto on 2018. 7. 7..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {

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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension DictionaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
