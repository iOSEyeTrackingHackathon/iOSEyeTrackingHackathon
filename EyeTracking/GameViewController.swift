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
import RealmSwift

let spacing: CGFloat = 8
let leftMargin: CGFloat = 20

class GameViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dictionaryView: UIView!
    @IBOutlet weak var dictionaryImageView: UIImageView!
    @IBOutlet weak var dictionaryTextView: UITextView!
    
    let sessionHandler = SessionHandler()
    let statementArray = ["The success of the project", "has been attributed to", "the deliberate efforts", "of the architects."]
    let wordAndMeaning: [String: String] = [
        "success":
        """
        1. 성공, 성과
        She was surprised by the book's success.
        그녀는 그 책의 성공에 놀랐다.
        
        2. 성공한 사람[것], 성공작
        The party was a big success.
        그 파티는 크게 성공적이었다.
        """,
        "attributed":
        """
        1.  결과로[덕분으로] 보다
        She attributes her success to hard work and a little luck.
        그녀는 자신의 성공을 성실한 노력에 약간의 행운이 따른 결과로 본다.
        """,
        "deliberate":
        """
        1.신중한, 찬찬한
        She spoke in a slow and deliberate way.
        그녀는 천천히 신중한 태도로 말을 했다.
        """,
        "architects.":
        """
        1. 건축가
        
        2. 설계자[건설자]
        He was one of the principal architects of the revolution.
        그는 그 혁명을 설계한 주요 인물들 중의 한 명이었다.
        """
    ]
    var labelPositions = [CGFloat]()
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
            label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
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
        
        self.labelPositions.removeAll()
        self.counts.removeAll()
        for item in stackView.arrangedSubviews {
            guard let label = item as? UILabel else { return }
            self.counts[label.text!] = 0
            self.labelPositions.append(label.frame.origin.x)
        }
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
        print(value.first!)
        DispatchQueue.main.async {
            guard let visibleCell = self.tableView.visibleCells.first else { return }
            guard let stackView = visibleCell.subviews.last as? UIStackView else { return }
            let eyeX: CGFloat = CGFloat(value.first ?? 0)
            for index in 0..<self.labelPositions.count {
                if self.labelPositions[index] - eyeX > 0 {
                    guard let label = stackView.arrangedSubviews[index] as? UILabel else { return }
                    if label.text! != "The" && label.text! != "the" && label.text != "of" {
                    let count = self.counts[label.text!] ?? 0
                    self.counts[label.text!] = count + 1
                    let filtered = self.counts.filter { $1 == 50 }
                    if filtered.count == 1 {
                        self.labelPositions.removeAll()
                        self.counts.removeAll()
                        let key = filtered.first?.key
                        for item in stackView.arrangedSubviews {
                            let label = item as! UILabel
                            if label.text == key {
                                item.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.3607843137, blue: 0.3490196078, alpha: 1)
                            }
                        }
                        let meaning = self.wordAndMeaning[key!] ?? "None"
                        self.dictionaryTextView.text = meaning
                        let object = self.realm.objects(WordInfo.self)
                        let filtered = object.filter(NSPredicate(format: "word = %@", key!))
                        if filtered.count == 0 && meaning != "None" {
                            addWord(key!, meaning)
                        }
                    }
                    }
                    break
                }
            }
        }
    }
    func calibrationFinished() {
        UIView.animate(withDuration: 1, animations: {
             self.tempView?.alpha = 0
        }) { _ in
            self.tempView?.removeFromSuperview()
        }
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
