//
//  AnAnBaseViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit

class AnAnBaseViewController: UIViewController {
    lazy var arrowBackBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_arrow_back"),target: self,action: #selector(backBtnClick))
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white;
        self.navigationController?.navigationBar.isHidden = true
        createSubviews()
        setSubviewsFrame()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if AnAnJumpPageManager.isRootViewControllers {
            self.tabBarController?.tabBar.isHidden = false
            arrowBackBtn.isHidden = true
        }else{
            self.tabBarController?.tabBar.isHidden = true
            arrowBackBtn.isHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    private func createSubviews() {
        view.addSubview(arrowBackBtn)
    }
    
    private func setSubviewsFrame() {
        arrowBackBtn.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.top.equalTo(15 + AnAnAppDevice.deviceTop())
            make.size.equalTo(20)
        }
    }
    
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
}
