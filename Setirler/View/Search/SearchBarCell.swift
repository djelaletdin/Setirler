//
//  SearchBarCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/03.
//
import UIKit


import UIKit

protocol SearchBarCellDelegate {
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: SearchBarCell)
    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: SearchBarCell)  -> Bool
}

class SearchBarCell: UICollectionViewCell {
    
    var delegate: SearchBarCellDelegate?
    
    let textField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "SourceSansPro-SemiBold", size: 14) ?? .systemFont(ofSize: 14)
        field.textColor = UIColor(named: "FontColor")
        field.setLeftPaddingPoints(30)
        field.setRightPaddingPoints(30)
        field.layer.cornerRadius = 9
        field.layer.borderWidth = 0
        field.leftViewMode = UITextField.ViewMode.always;
        field.leftViewMode = .always
        field.leftView?.frame = CGRect(x: 10, y: 5, width: 20 , height:20)
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
        field.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        field.tintColor = UIColor(named: "FontColor")
        field.layer.shadowOffset = CGSize(width: 2, height: 4)
        field.layer.shadowRadius = 9.0
        field.layer.shadowOpacity = 0.4
        field.layer.masksToBounds = false
        
        return field
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(named: "FontColor"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 14) ?? .systemFont(ofSize: 14)
        button.backgroundColor = .clear
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return button
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        
        let infoTopStackView = UIStackView(arrangedSubviews: [textField, getButton])
        infoTopStackView.spacing = 5
        infoTopStackView.alignment = .fill
//        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, textField], spacing: 16)
        
        addSubview(infoTopStackView)
        infoTopStackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
    }
    
    @objc func valueChanged(_ sender: UITextField) {
        delegate?.collectionViewCell(valueChangedIn: textField, delegatedFrom: self)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
            textField.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
            textField.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
            
           }
       }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchBarCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = delegate {
            return delegate.collectionViewCell(textField: textField, shouldChangeCharactersIn: range, replacementString: string, delegatedFrom: self)
        }
        return true
    }
}


