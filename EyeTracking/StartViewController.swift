//
//  StartViewController.swift
//  EyeTracking
//
//  Created by Presto on 2018. 7. 7..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var dictionaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startButton.addTarget(self, action: #selector(touchUpStartButton(_:)), for: .touchUpInside)
        self.dictionaryButton.addTarget(self, action: #selector(touchUpDictionaryButton(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpStartButton(_ sender: UIButton) {
        guard let next = storyboard?.instantiateViewController(withIdentifier: "DifficultyViewController") else { return }
        self.present(next, animated: false, completion: nil)
    }
    
    @objc func touchUpDictionaryButton(_ sender: UIButton) {
        guard let next = storyboard?.instantiateViewController(withIdentifier: "DictionaryViewController") else { return }
        self.present(next, animated: false, completion: nil)
    }
}
