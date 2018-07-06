//
//  ViewController.swift
//  EyeTracking
//
//  Created by Presto on 2018. 7. 5..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import UIKit
import VMEX
import SnapKit

let spacing: CGFloat = 8
let leftMargin: CGFloat = 20

class GameViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let sessionHandler = SessionHandler()
    let statement = "Mother Father Gentleman"
    var labelXs = [CGFloat]()
    var stackView: UIStackView = UIStackView()
    var counts = [String: Int]()
    var difficulty: Difficulty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sessionHandler.openSession(receiver: self, root: self.view, mode: .LandscapeLeft, isCalibration: true)
        sessionHandler.startSession()
    }
}

extension GameViewController: Receiver {
    func receive(value: [Double], isTracking: Bool) {
        //MARK: 보고 있는 단어를 찾는 알고리즘
        let eyeX: CGFloat = CGFloat(value.first ?? 0)
        for index in 0..<labelXs.count {
            if labelXs[index] - eyeX > 0 {
                DispatchQueue.main.async {
                    guard let label = self.stackView.arrangedSubviews[index] as? UILabel else { return }
                    let count = self.counts[label.text!] ?? 0
                    self.counts[label.text!] = count + 1
                    let filtered = self.counts.filter { $1 == 100 }
                    if filtered.count == 1 {
                        self.sessionHandler.pauseSession()
                        let key = filtered.first?.key
                        for item in self.stackView.arrangedSubviews {
                            let label = item as! UILabel
                            if label.text == key {
                                item.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
                            }
                        }
                        let alert = UIAlertController(title: "asdf", message: "asdf", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.sessionHandler.resumeSession()
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                break
            }
        }
    }
    func calibrationFinished() {
        //MARK: 문장을 단어로 분리
        let splited = statement.split(separator: " ").map { String($0) }
        var labels = [UILabel]()
        for word in splited {
            let label = UILabel()
            label.text = word
            label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            labels.append(label)
        }
        //MARK: 스택뷰 초기화
        stackView.spacing = spacing
        stackView.axis = .horizontal
        for label in labels {
            stackView.addArrangedSubview(label)
        }
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(leftMargin)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        stackView.layoutIfNeeded()
        //MARK: 단어의 x좌표 구하기
        for item in stackView.arrangedSubviews {
            guard let label = item as? UILabel else { return }
            self.counts[label.text!] = 0
            self.labelXs.append(label.frame.origin.x + leftMargin)
        }
    }
}
