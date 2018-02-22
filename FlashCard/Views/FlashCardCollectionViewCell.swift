//
//  FlashCardCollectionViewCell.swift
//  FlashCard
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FlashCardCollectionViewCell: UICollectionViewCell {
    
    private var upSwipeGesture: UISwipeGestureRecognizer!
    private var downSwipeGesture: UISwipeGestureRecognizer!
    private var isShowingFront: Bool = true
    
    lazy var questionTextView: CenterTextView = {
        let textView = CenterTextView()
        textView.backgroundColor = .gray
        textView.isEditable = false
        textView.textAlignment = .center
        textView.contentMode = .center
        textView.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return textView
    }()
    
    lazy var answerTextView: CenterTextView = {
        let textView = CenterTextView()
        textView.backgroundColor = .white
        textView.isEditable = false
        textView.isHidden = true
        textView.textAlignment = .center
        textView.contentMode = .center
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return textView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupCellLayerAttributes()
        addSwipeGestures()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayerAttributes() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
    private func addSwipeGestures() {
        upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        upSwipeGesture.direction = .up
        self.addGestureRecognizer(upSwipeGesture)
        
        downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        downSwipeGesture.direction = .down;
        self.addGestureRecognizer(downSwipeGesture)
    }
    
    @objc private func swipeUp() {
        if isShowingFront {
            showBackofCard()
        } else {
            showFrontOfCard()
        }
        isShowingFront = !isShowingFront
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    @objc private func swipeDown() {
        if isShowingFront {
            showBackofCard()
        } else {
            showFrontOfCard()
        }
        isShowingFront = !isShowingFront
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
    }
    
    private func showBackofCard() {
        usernameLabel.isHidden = true
        dateLabel.isHidden = true
        questionTextView.isHidden = true
        answerTextView.isHidden = false
    }
    
    private func showFrontOfCard() {
        usernameLabel.isHidden = false
        dateLabel.isHidden = false
        answerTextView.isHidden = true
        questionTextView.isHidden = false
    }
    
    private func setupViews() {
        
        setupDateLabel()
        setupQuestionTextView()
        setupAnswerTextView()
        setupUsernameLabel()
    }
    
    private func setupUsernameLabel() {
        let padding: CGFloat = 8.0
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(questionTextView.snp.leading).offset(padding)
            make.top.equalTo(questionTextView.snp.top).offset(padding)
        }
    }
    
    private func setupDateLabel() {
        let padding: CGFloat = 8.0
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).offset(-padding)
        }
    }
    
    private func setupQuestionTextView() {
        let padding: CGFloat = 8.0
        addSubview(questionTextView)
        questionTextView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(safeAreaLayoutGuide).offset(padding)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-padding)
            make.bottom.equalTo(dateLabel.snp.top).offset(-padding)
           
        }
        
    }
    private func setupAnswerTextView() {
        let padding: CGFloat = 8.0
        addSubview(answerTextView)
        answerTextView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(safeAreaLayoutGuide).offset(padding)
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).offset(-padding)
        }
        
    }
    
    public func configureCell(flashCard: FlashCard) {
        self.questionTextView.text = flashCard.question
        self.usernameLabel.text = flashCard.categoryName
        //TODO; parse date to string
//        self.dateLabel.text = flashCard.dateCreated!
        self.answerTextView.text = flashCard.answer
    }
    
}

//Custom TextView for centered text in view
class CenterTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2
            topCorrection = max(0,topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }

}
