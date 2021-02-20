//
//  ViewController.swift
//  HealthQrcode
//
//  Created by AME on 2020/7/29.
//  Copyright © 2020 ame017. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var moreControl: UIControl!
    @IBOutlet weak var exitControl: UIControl!
    
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var refreshControl: UIControl!

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var day3Button: UIButton!
    @IBOutlet weak var day7Button: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headIconImageView: UIImageView!
    
    lazy var dateFormatter : DateFormatter = {
        let object = DateFormatter()
        object.dateFormat = "yyyy-MM-dd hh:mm:ss"
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
        self.refreshControl.setEnlargeEdge(10)
        loadName()
        updateTime()
    }
    private func loadName(){
        var name = UserDefaults.standard.string(forKey: "_user_name")
        let card = UserDefaults.standard.string(forKey: "_user_id_card")
        let hasRun = UserDefaults.standard.bool(forKey: "_has_run")
        let isFemale = UserDefaults.standard.bool(forKey: "_is_female")
        //由于版本迭代问题,初次运行清除名字
        if !hasRun {
            name = nil
            UserDefaults.standard.setValue(nil, forKey: "_user_name")
            UserDefaults.standard.setValue(1, forKey: "_has_run")
        }
        self.nameLabel.text = name ?? "点击右上角输入姓名"
        self.idLabel.text = card ?? "点击右上角输入身份证号"
        if isFemale {
            self.headIconImageView.image = UIImage.init(named: "head_icon_f")
        }
    }
    
    private func updateTime(){
        let dateNow = Date.init()
        let timeString = self.dateFormatter.string(from: dateNow)
        self.timeLabel.text = timeString
    }
    
    
    //MARK: - button
    
    @IBAction func getUserInfoButtonClick(_ sender: Any) {
        let alert = UIAlertController.init(title: "FBI WORNING", message: "你叫啥?(不用加星号)", preferredStyle: UIAlertController.Style.alert)
        var tf = UITextField.init()
        alert.addTextField { (textField) in
            tf = textField
        }
        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (alertAction) in
            self.nameLabel.text = "*".appending(tf.text!.suffix(tf.text!.count-1))
            UserDefaults.standard.set(self.nameLabel.text, forKey: "_user_name")
            //弹窗结束后立即弹窗输入身份证号
            let alertCard = UIAlertController.init(title: "FBI WORNING", message: "身份证号!(不用加星号)", preferredStyle: UIAlertController.Style.alert)
            var tfCard = UITextField.init()
            tfCard.keyboardType = UIKeyboardType.asciiCapableNumberPad
            alertCard.addTextField { (textField) in
                tfCard = textField
            }
            alertCard.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (alertAction) in
                self.idLabel.text = tfCard.text!.prefix(4)+"**********"+tfCard.text!.suffix(4)
                UserDefaults.standard.set(self.idLabel.text, forKey: "_user_id_card")
            }))
            self.present(alertCard, animated: true) {
                
            }
        }))
        alert.addAction(UIAlertAction.init(title: "拉倒", style: UIAlertAction.Style.cancel, handler: { (alertAction) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    
    @IBAction func refreshButtonClick(_ sender: Any) {
        SVProgressHUD.show(withStatus: "正在加载")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
    @IBAction func alipayButtonClick(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: "alipayqr://platformapi/startapp?saId=200011235")!, options: [:]) { (completion) in
            
        }
    }
    @IBAction func yunshanfuButtonClick(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: "upwallet://rn/rnhtmlridingcode")!, options: [:]) { (completion) in
    
        }
    }
    @IBAction func shengjingtongButtonClick(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: "SYSubWay://")!, options: [:]) { (completion) in
            
        }
    }
    @IBAction func dayButtonClick(_ sender: UIButton) {
        self.day3Button.isSelected = false
        self.day3Button.borderColor = UIColor.init(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1.0)
        self.day7Button.isSelected = false
        self.day7Button.borderColor = UIColor.init(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1.0)
        sender.isSelected = true
        sender.borderColor = .systemBlue
        self.titleLabel.text = "绿码·无"
    }
    @IBAction func headIconControlClick(_ sender: Any) {
        let isFemale = UserDefaults.standard.bool(forKey: "_is_female")
        if isFemale {
            UserDefaults.standard.setValue(0, forKey: "_is_female")
            self.headIconImageView.image = UIImage.init(named: "head_icon")
        }else{
            UserDefaults.standard.setValue(1, forKey: "_is_female")
            self.headIconImageView.image = UIImage.init(named: "head_icon_f")
        }
    }
    
}

