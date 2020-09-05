//
//  ViewController.swift
//  AxxessTest
//
//  Created by Hemil Modi on 05/09/20.
//  Copyright © 2020 Hemil Modi. All rights reserved.
//

import UIKit
import SnapKit

class ItemDetailViewController: UIViewController {

    var challengeModel:AXChallenge!{
        didSet{
            self.setData()
        }
    }
    lazy var mainView:UIView = UIView();
    
    lazy var scrollView:UIScrollView = UIScrollView()
    lazy var contentView:UIView = UIView()
    
    private let lblDescription : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let lblId : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let lblType : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let lblDate : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    func setData(){
        self.title = challengeModel.date
        self.lblDescription.text = "Description::\n\(challengeModel.data)"
        self.lblDate.text = "Date:: \(challengeModel.date)"
        self.lblId.text = "ID:: \(challengeModel.id)"
        self.lblType.text = "Type:: \(challengeModel.type)"
        
    }
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        //mainView
        mainView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view)
            }
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                make.bottom.equalTo(view)
            }
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            
        }
        
        //ScrollView
        mainView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(mainView.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(mainView)
            }
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(mainView.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                make.bottom.equalTo(mainView)
            }
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            
        }
        //ContentView
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self.mainView)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView).priority(ConstraintPriority.low)
            // or:
            // make.centerX.equalTo(self.scrollView)
            // make.centerY.equalTo(self.scrollView)
        }
        
        contentView.addSubview(lblId)
        contentView.addSubview(lblType)
        contentView.addSubview(lblDate)
        contentView.addSubview(lblDescription)
        lblId.snp.makeConstraints { (make) in
                   if #available(iOS 11.0, *) {
                       make.top.equalTo(self.contentView.snp.topMargin).offset(5)
                   } else {
                       make.top.equalTo(self.contentView).offset(5)
                   }
                   if #available(iOS 11.0, *) {
                       make.bottom.equalTo(self.lblType.snp.top).offset(-15)
                   } else {
                       make.bottom.equalTo(self.lblType).offset(-15)
                   }
                   
                   make.leading.equalToSuperview().offset(10)
                   make.trailing.equalToSuperview().offset(-10)
               }
        
        
        lblType.snp.makeConstraints { (make) in
                          
                           if #available(iOS 11.0, *) {
                               make.bottom.equalTo(self.lblDate.snp.top).offset(-15)
                           } else {
                               make.bottom.equalTo(self.lblDate).offset(-15)
                           }
                           
                           make.leading.equalToSuperview().offset(10)
                           make.trailing.equalToSuperview().offset(-10)
        }
        
       
        lblDate.snp.makeConstraints { (make) in
                          
                           if #available(iOS 11.0, *) {
                               make.bottom.equalTo(self.lblDescription.snp.top).offset(-15)
                           } else {
                               make.bottom.equalTo(self.lblDescription).offset(-15)
                           }
                           
                           make.leading.equalToSuperview().offset(10)
                           make.trailing.equalToSuperview().offset(-10)
        }
        
        
        lblDescription.snp.makeConstraints { (make) in
                          
                                       if #available(iOS 11.0, *) {
                                           make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
                                       } else {
                                           make.bottom.equalTo(self.contentView).offset(-15)
                                       }
                           
                           make.leading.equalToSuperview().offset(10)
                           make.trailing.equalToSuperview().offset(-10)
        }
        
        self.lblId.setContentHuggingPriority(UILayoutPriority.init(755), for: .vertical)
        self.lblType.setContentHuggingPriority(UILayoutPriority.init(754), for: .vertical)
        self.lblDate.setContentHuggingPriority(UILayoutPriority.init(753), for: .vertical)
        self.lblDescription.setContentHuggingPriority(UILayoutPriority.init(752), for: .vertical)
        
    }
    

}

