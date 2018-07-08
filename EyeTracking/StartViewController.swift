//
//  StartViewController.swift
//  EyeTracking
//
//  Created by Presto on 2018. 7. 7..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import UIKit

enum Difficulty {
    case hard
    case medium
    case easy
}

class StartViewController: UIViewController {

    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var dictionaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hardButton.tag = 0
        self.mediumButton.tag = 1
        self.easyButton.tag = 2
        self.hardButton.addTarget(self, action: #selector(touchUpDifficultyButton(_:)), for: .touchUpInside)
        self.mediumButton.addTarget(self, action: #selector(touchUpDifficultyButton(_:)), for: .touchUpInside)
        self.easyButton.addTarget(self, action: #selector(touchUpDifficultyButton(_:)), for: .touchUpInside)
        self.dictionaryButton.addTarget(self, action: #selector(touchUpDictionaryButton(_:)), for: .touchUpInside)
        let buttons = [hardButton, mediumButton, easyButton, dictionaryButton]
        for button in buttons {
            button?.layer.cornerRadius = 10
        }
    }
    
    @objc func touchUpDifficultyButton(_ sender: UIButton) {
        guard let next = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        switch sender.tag {
        case 0:
            next.difficulty = .hard
        case 1:
            next.difficulty = .medium
        case 2:
            next.difficulty = .easy
        default:
            break
        }
        self.present(next, animated: false, completion: nil)
    }
    
    @objc func touchUpDictionaryButton(_ sender: UIButton) {
        guard let next = storyboard?.instantiateViewController(withIdentifier: "DictionaryViewController") else { return }
        self.present(next, animated: false, completion: nil)
    }
}
