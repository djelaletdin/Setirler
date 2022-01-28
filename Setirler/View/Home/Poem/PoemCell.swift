//
//  PoemCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//

import UIKit

class PoemCell: UICollectionViewCell {
    
    var padding = CGFloat()
    var poem: PoemData?
    {
        didSet{
            contentTextView.textColor = UIColor(named: "FontColor")
            contentTextView.backgroundColor = UIColor(named: "MainBackground")
            
            
            
            if #available(iOS 12.0, *) {
                switch traitCollection.userInterfaceStyle {
                case .light:
                    styledTextcolor = "#2a2a2a"
                    print("light mode")
                    
                case .dark: //dark mode
                    styledTextcolor = "#acacac"
                    print("dark mode")
                case .unspecified: //the user interface style is not specified
                    styledTextcolor = "#2a2a2a"
                    print("unspecified")
                @unknown default:
                    styledTextcolor = "#2a2a2a"
                }
            } else {
                styledTextcolor = "#2a2a2a"
            }
            
            let styledString = "<style>p{font-family: SourceSerifPro-Bold; text-align:center; color: \(styledTextcolor);}</style><div style='font-family: SourceSerifPro-Regular; font-size: 16; color: \(styledTextcolor); word-wrap: break-word; float: right; margin: 0 auto;'>\(poem?.content.replacingOccurrences(of: "\r\n", with: "<br/>").replacingOccurrences(of: " ", with: "&nbsp") ?? "")</div>"
            
            contentTextView.attributedText = styledString.htmlToAttributedString
//            contentTextView.textContainer.lineBreakMode = .byWordWrapping

//            contentTextView.text = poem?.content
            titleLabel.text = poem?.name
            tagsController.tags = poem?.tags
        }
    }
    
    var styledTextcolor = ""
    
    let contentTextView: UITextView = {
        let text = UITextView()
//        text.backgroundColor = .green
        text.textColor = UIColor(named: "FontColor")
        text.font = UIFont(name: "SourceSerifPro-Regular", size: 18) ?? .systemFont(ofSize: 18)
        text.isScrollEnabled = false
        text.isEditable = false
        text.textAlignment = .natural
        return text
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "FontColor")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Title Name"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 24) ?? .systemFont(ofSize: 24)
        return label
    }()

    let tagsController = TagController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let stackView = VerticalStackView(arrangedSubviews: [titleLabel, contentTextView], spacing: 15)
        addSubview(stackView)
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.fillSuperview(padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        
        }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light:
                styledTextcolor = "#2a2a2a"
                print("light mode")
                
            case .dark: //dark mode
                styledTextcolor = "#acacac"
                print("dark mode")
            case .unspecified: //the user interface style is not specified
                styledTextcolor = "#2a2a2a"
                print("unspecified")
            @unknown default:
                styledTextcolor = "#2a2a2a"
            }
        } else {
            styledTextcolor = "#2a2a2a"
        }
        
        let styledString = "<style>p{font-family: SourceSerifPro-Bold; text-align:center; color: \(styledTextcolor);}</style><div style='font-family: SourceSerifPro-Regular; font-size: 18; color: \(styledTextcolor); word-wrap: break-word; float: right; margin: 0 auto;'>\(poem?.content.replacingOccurrences(of: "\r\n", with: "<br/>").replacingOccurrences(of: " ", with: "&nbsp") ?? "")</div>"
        
        contentTextView.attributedText = styledString.htmlToAttributedString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
