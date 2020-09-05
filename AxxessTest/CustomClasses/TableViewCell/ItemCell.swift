//
//  ItemCell.swift
//  DemoSnapKit
//
//  Created by agileimac-5 on 05/09/20.
//  Copyright © 2020 Agile. All rights reserved.
//

import UIKit
import SnapKit

class ItemCell: UITableViewCell {

    private let lblDate: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 15)
    lbl.textAlignment = .right
        lbl.numberOfLines = 1
        return lbl
    }()
    private let lblName : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .darkGray
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let lblDescription : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 15)
    lbl.textAlignment = .left
        lbl.numberOfLines = 3
        return lbl
    }()
    var model:AXChallenge!{
        didSet{
            self.lblName.text = model.type
            self.lblDescription.text = model.data
            self.lblDate.text = model.date
        }
    }
    lazy var mainView:UIView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.topMargin).offset(5)
            } else {
                make.top.equalTo(self.contentView).offset(5)
            }
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.contentView.safeAreaLayoutGuide.snp.bottomMargin).offset(-5)
            } else {
                make.bottom.equalTo(self.contentView).offset(-5)
            }
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    
        self.mainView.clipsToBounds = true
        self.mainView.addSubview(lblName)
        self.mainView.addSubview(lblDescription)
        self.mainView.addSubview(lblDate)
        
        //self.lblName.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.lblName.setContentHuggingPriority(UILayoutPriority.init(752), for: .vertical)
        self.lblDescription.setContentHuggingPriority(UILayoutPriority.init(751), for: .vertical)
        lblName.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.mainView.safeAreaLayoutGuide.snp.topMargin).offset(5)
            } else {
                make.top.equalTo(self.mainView).offset(5)
            }
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.lblDescription.snp.topMargin).offset(-15)
            } else {
                make.bottom.equalTo(self.lblDescription).offset(-15)
            }
            
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        lblDescription.snp.makeConstraints { (make) in
            
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.lblDate.snp.topMargin).offset(-15)
            } else {
                make.bottom.equalTo(self.lblDate).offset(-15)
            }
            
            
        }
        lblDate.snp.makeConstraints { (make) in
            
             make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            //make.trailing.equalToSuperview().offset(-10)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.mainView.snp.bottom).offset(-10)
            } else {
                make.bottom.equalTo(self.mainView).offset(10)
            }
        }
    }
//    func updateCell(withTitle title:String,withDescription strDesription:String = ""){
//        self.lblName.text = title
//        self.lblDescription.text = "as;jd klasjdo asdjlo aosdhj ailosdhj asdj asdklj alsdj sdkj asdklj adklsj djsl adjskl ajsdkl jdjqu ww ajskl adklsj dj lasdj kladjsl kajsd jqdipquweuw   eoi djqs kl jsd; dqwiodqs ohqs d;h dsh wdefhu wp;dfhqdow;sfh opq;dfhdqwuf dqwfuj oiwfju"
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
