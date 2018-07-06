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
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dictionaryView: UIView!
    let sessionHandler = SessionHandler()
    let statementArray = ["We may need to apportion", "extra funds to the project", "if these changes are made."]
    var labelXs = [CGFloat]()
    var stackView: UIStackView = UIStackView()
    var counts = [String: Int]()
    var difficulty: Difficulty?
    var tempView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        self.homeButton.addTarget(self, action: #selector(touchUpHomeButton(_:)), for: .touchUpInside)
        self.previousButton.addTarget(self, action: #selector(touchUpPreviousButton(_:)), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(touchUpNextButton(_:)), for: .touchUpInside)
        self.dictionaryView.layer.cornerRadius = 10
        self.dictionaryView.layer.borderWidth = 1
        self.dictionaryView.layer.borderColor = #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        tempView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tempView?.backgroundColor = UIColor.white
        self.view.addSubview(tempView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sessionHandler.openSession(receiver: self, root: self.view, mode: .LandscapeLeft, isCalibration: true)
        sessionHandler.startSession()
    }
    
    func makeCellLabels(_ statement: String, to cell: UITableViewCell) {
        cell.viewWithTag(100)?.removeFromSuperview()
        let splited = statement.split(separator: " ").map { String($0) }
        var labels = [UILabel]()
        for word in splited {
            let label = UILabel()
            label.text = word
            label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
            labels.append(label)
        }
        let stackView = UIStackView()
        stackView.tag = 100
        stackView.spacing = spacing
        stackView.axis = .horizontal
        for label in labels {
            stackView.addArrangedSubview(label)
        }
        cell.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(cell.snp.left)
            make.centerY.equalTo(cell.snp.centerY)
        }
        stackView.layoutIfNeeded()
    }
    
    @objc func touchUpHomeButton(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpPreviousButton(_ sender: UIButton) {
        
    }
    
    @objc func touchUpNextButton(_ sender: UIButton) {
        
    }
}

extension GameViewController: Receiver {
    func receive(value: [Double], isTracking: Bool) {
        //MARK: 보고 있는 단어를 찾는 알고리즘
//        let eyeX: CGFloat = CGFloat(value.first ?? 0)
//        for index in 0..<labelXs.count {
//            if labelXs[index] - eyeX > 0 {
//                DispatchQueue.main.async {
//                    guard let label = self.stackView.arrangedSubviews[index] as? UILabel else { return }
//                    let count = self.counts[label.text!] ?? 0
//                    self.counts[label.text!] = count + 1
//                    let filtered = self.counts.filter { $1 == 100 }
//                    if filtered.count == 1 {
//                        self.sessionHandler.pauseSession()
//                        let key = filtered.first?.key
//                        for item in self.stackView.arrangedSubviews {
//                            let label = item as! UILabel
//                            if label.text == key {
//                                item.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
//                            }
//                        }
//                        let alert = UIAlertController(title: "asdf", message: "asdf", preferredStyle: .alert)
//                        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
//                            self.sessionHandler.resumeSession()
//                        })
//                        alert.addAction(action)
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                }
//                break
//            }
//        }
    }
    func calibrationFinished() {
        tempView?.removeFromSuperview()
    }
}

extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let statement = self.statementArray[indexPath.row]
        makeCellLabels(statement, to: cell)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statementArray.count
    }
}
extension GameViewController: UITableViewDelegate {

}
