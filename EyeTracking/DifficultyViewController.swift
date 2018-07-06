//
//  DifficultyViewController.swift
//  EyeTracking
//
//  Created by Presto on 2018. 7. 7..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import UIKit

enum Difficulty {
    case easy
    case medium
    case hard
}

class DifficultyViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.easyButton.tag = 0
        self.mediumButton.tag = 1
        self.hardButton.tag = 2
    }
    
    @objc func touchUpButtons(_ sender: UIButton) {
        guard let next = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        switch sender.tag {
        case 0:
            next.difficulty = .easy
        case 1:
            next.difficulty = .medium
        case 2:
            next.difficulty = .hard
        default:
            break
        }
        self.present(next, animated: false, completion: nil)
    }
}
