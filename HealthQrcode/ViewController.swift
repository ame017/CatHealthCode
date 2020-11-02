//
//  ViewController.swift
//  HealthQrcode
//
//  Created by AME on 2020/7/29.
//  Copyright © 2020 ame017. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    lazy var dateFormatter : DateFormatter = {
        let object = DateFormatter()
        object.dateFormat = "M月dd日"
        return object
    }()
    lazy var timeFormatter : DateFormatter = {
        let object = DateFormatter()
        object.dateFormat = "hh:mm:ss"
        return object
    }()
    var timer: Timer?
    var imageNumber = 0

    //MARK: - LIFE CIRCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in
            self.updateTime()
        })
    }
    //MARK: - makeUI
    private func makeUI() {
        self.backButton.setEnlargeEdge(10)
        self.moreButton.setEnlargeEdge(15)
        self.refreshButton.setEnlargeEdge(5)
        self.backButton.setEnlargeEdge(10)
        self.goButton.setEnlargeEdge(10)
        loadName()
        updateDateAndTime()
    }
    private func loadName(){
        let name = UserDefaults.standard.string(forKey: "_user_name")
        self.nameLabel.text = name ?? "请点击右上...输入姓名"
    }
    private func updateTime(){
        let dateNow = Date.init()
        let timeString = self.timeFormatter.string(from: dateNow)
        self.timeLabel.text = timeString
    }
    private func updateDateAndTime(){
        let dateNow = Date.init()
        let dateString = self.dateFormatter.string(from: dateNow)
        self.dateLabel.text = dateString
        let timeString = self.timeFormatter.string(from: dateNow)
        self.timeLabel.text = timeString
    }
    //MARK: - button
    @IBAction func moreButtonClick(_ sender: Any) {
        let alert = UIAlertController.init(title: "FBI WORNING", message: "你叫啥?(自己输入星号)", preferredStyle: UIAlertController.Style.alert)
        var tf = UITextField.init()
        alert.addTextField { (textField) in
            tf = textField
        }
        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (alertAction) in
            self.nameLabel.text = tf.text
            UserDefaults.standard.set(tf.text, forKey: "_user_name")
        }))
        alert.addAction(UIAlertAction.init(title: "拉倒", style: UIAlertAction.Style.cancel, handler: { (alertAction) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    
    @IBAction func refreshButtonClick(_ sender: Any) {
        SVProgressHUD.show(withStatus: "正在加载")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            SVProgressHUD.dismiss()
            self.imageNumber += 1
            self.qrImageView.image = UIImage.init(named: "qr_code_" + String(self.imageNumber%6))
        }
    }
    
    @IBAction func infoButtonClick(_ sender: Any) {
        SVProgressHUD.show(withStatus: "正在加载")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            SVProgressHUD.showError(withStatus: "系统维护中，加载失败")
        }
    }
    @IBAction func exitButtonClick(_ sender: Any) {
        exit(0)
    }
    
}

