//
//  AnAnShortTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/5/20.
//

import UIKit

class AnAnShortTableViewCell: UITableViewCell {

    lazy var videoView:AnAnShortVideoView = {
       let view = AnAnShortVideoView()
        return view
    }()
//    暂停按钮
    lazy var pauseBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "arrowtriangle.forward.circle.fill"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.tag = 100
        return btn
    }()
    
    fileprivate lazy var likeBtn:CustomBtn = {
        let btn = CustomBtn(type: .custom)
        btn.image.image = UIImage(named: "heart.fill")
        btn.title.text = "10000"
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.tag = 200
        return btn
    }()
    
    fileprivate lazy var saveBtn:CustomBtn = {
        let btn = CustomBtn(type: .custom)
        btn.image.image = UIImage(named: "star.fill")
        btn.title.text = "1000"
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.tag = 300
        return btn
    }()
    
    fileprivate lazy var shareBtn:CustomBtn = {
        let btn = CustomBtn(type: .custom)
        btn.image.image = UIImage(named: "arrowshape.turn.up.forward.fill")
        btn.title.text = "888"
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.tag = 400
        return btn
    }()
    
    lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.text = "标题"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var descLabel:UILabel = {
       let label = UILabel()
        label.text = "描述"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    lazy var progressView:UIView = {
       let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .black
        createSubviews()
        setSubviewsFrame()
        videoView.playerUrl = "https://qn-302-cdn-local.rr.tv/47057f9804d841998c6c77732711e71c/600fd38ad47a47f7a40d6c6eff3335a2-06ecc8a4fe6e6f32af4c59450f9e9263-ld.mp4?sign=6ecebc9d6f321407560bad05cf915ef3&t=648f4cf5&clientType=ios_duoduoshipin&clientVersion=5.22.3&parseUsage=PLAY&uid=195978623&rk=7462feefd5734dc483abe4c256e4b3cf"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(videoView)
        contentView.addSubview(pauseBtn)
        contentView.addSubview(likeBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(shareBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(progressView)
    }
    
    private func setSubviewsFrame() {
        videoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pauseBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(45)
        }
        
        likeBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.size.equalTo(CGSize(width: 50, height: 55))
        }
        
        saveBtn.snp.makeConstraints { make in
            make.size.trailing.equalTo(likeBtn)
            make.top.equalTo(likeBtn.snp.bottom).offset(25)
        }
        
        shareBtn.snp.makeConstraints { make in
            make.size.trailing.equalTo(likeBtn)
            make.top.equalTo(saveBtn.snp.bottom).offset(25)
            make.bottom.equalTo(-80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.trailing.equalTo(likeBtn.snp.leading).offset(-30)
            make.height.equalTo(20)
        }
        descLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(60)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(shareBtn)
        }
    }
    
    func player() {
        videoView.startPlayer()
    }
    func pausePl() {
        videoView.pausePlayer()
    }
    @objc func btnClick(){
        
    }
    
}

fileprivate class CustomBtn:UIButton{
    fileprivate lazy var image:UIImageView = {
        let img = AnAnImageView()
        
        return img
    }()
    fileprivate lazy var title:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: .white, font: UIFont.pingFangRegularWithSize(fontSize: 15))
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(title)
        image.alpha = 0.6
        image.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.size.equalTo(30)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
