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


    let appIconImageView: UITextField = {
        let iv = UITextField()
        iv.backgroundColor = .red
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "CATEGORY NAME"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "APP RATING"
        return label
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Search"
        field.backgroundColor = #colorLiteral(red: 0.9597861171, green: 0.9540802836, blue: 0.9641718268, alpha: 1)
        field.textColor = .darkGray
        return field
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, textField], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    @objc func valueChanged(_ sender: UITextField) {
        delegate?.collectionViewCell(valueChangedIn: textField, delegatedFrom: self)
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


