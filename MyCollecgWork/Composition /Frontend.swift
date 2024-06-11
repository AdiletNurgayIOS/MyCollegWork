//
//  Frontend.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 03.06.2024.
//

import UIKit

class FrontTextField {
    
    var iconClick = true
    
    func setupTextFieldEmail(textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect //
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1) // Фоновый цвет
        textField.textColor = .black // Цвет текста
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 15
        textField.keyboardType = .emailAddress
        
        // Настройка правого вида (например, кнопка очистки)
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        rightButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rightButton.addTarget(self, action: #selector(clearTextField(_:)), for: .touchUpInside)
        textField.rightView = rightButton
        textField.rightViewMode = .whileEditing
        
        
    }
    
   func setupTextFieldPassword(textField: UITextField, placeholder: String) {
       textField.placeholder = placeholder
       textField.borderStyle = .roundedRect
       textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
       textField.textColor = .black
       textField.font = UIFont.systemFont(ofSize: 16)
       textField.layer.cornerRadius = 15
       textField.isSecureTextEntry = true  // По умолчанию скрываем пароль
       textField.keyboardType = .default  // Должен быть стандартный клавиатурный тип для пароля

       let showHideButton = UIButton(type: .custom)
       showHideButton.setImage(UIImage(systemName: "eye"), for: .normal)
       showHideButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
       showHideButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
       textField.rightView = showHideButton
       textField.rightViewMode = .always
   }

    @objc private func clearTextField(_ sender: UIButton) {
        // Очищает текстовое поле
        if let textField = sender.superview as? UITextField {
            textField.text = ""
        }
        
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        guard let textField = sender.superview as? UITextField else { return }
        textField.isSecureTextEntry.toggle()
        let buttonImage = textField.isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        sender.setImage(buttonImage, for: .normal)
    }
}



class FrontendButton {
    
    func setupButton(button: UIButton, title: String, tintColor: UIColor, backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(tintColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        
        
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
  
    
   
    
}
