//
//  SettingTableViewCell.swift
//  MyCollecgWork
//
//  Created by Нургазы Адилет on 07.06.2024.
//

import UIKit
import SnapKit


class SettingTableViewCell: UITableViewCell {

    private var imageAccount = UIImageView()
    private let label = UILabel()
    private let imageExit = UIImageView()
    
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //отключение нажатие на ячейку
//        self.selectionStyle = .none
        
        setupImageView()
        setupLabel()
        setupImageExit()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIImageView
    
    private func setupImageView() {
        contentView.addSubview(imageAccount)
        imageAccount.image = UIImage(systemName: "person.circle")
        imageAccount.tintColor = .systemBlue
        imageAccount.contentMode = .scaleAspectFill
        
        imageAccount.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.width.height.equalTo(20)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        
    }
    
    private func setupImageExit() {
        imageExit.image = UIImage(systemName: "arrow.right.to.line.alt")
        imageExit.tintColor = .systemBlue
        imageExit.contentMode = .scaleAspectFit
        contentView.addSubview(imageExit)
        
        imageExit.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.top.equalTo(contentView.snp.top).offset(10)
            
        }

    }
    
    //MARK: - UILabel
    
    private func setupLabel() {
        label.text = "Выйти с аккаунта"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(label.intrinsicContentSize.width)
            make.height.equalTo(label.intrinsicContentSize.height)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(imageAccount.snp.leading).offset(45)
        }
    }
    
    
    
    
    
    
   
    
}
