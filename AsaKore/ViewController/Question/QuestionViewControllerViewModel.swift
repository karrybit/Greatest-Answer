//
//  QuestionViewControllerViewModel.swift
//  ThisIsTheCorrectAnswerUntilMorning
//
//  Created by 刈部拓未 on 2018/04/29.
//  Copyright © 2018年 刈部拓未. All rights reserved.
//

import Foundation
import UIKit

protocol QuestionViewControllerViewModelDelegate: class {
    func questionViewControllerViewModel(_ questionViewControllerViewModel: QuestionViewControllerViewModel, didChange time: Double)
    func questionViewControllerViewModelDidFinishTime(_ questionViewControllerViewModel: QuestionViewControllerViewModel)
}

final class QuestionViewControllerViewModel {
    weak var delegate: QuestionViewControllerViewModelDelegate?
    let question: Question
    private var time = 60.0 { didSet { delegate?.questionViewControllerViewModel(self, didChange: time) } }
    private var timer: Timer? = nil
    
    init(question: Question) {
        self.question = question
    }
    
    func didTapStartButton() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
    }
    
    func didTapAddTimeButton() {
        time += 60.0
    }
    
    func didTapSubtractTimeButton() {
        time = time - 60.0 <= 0.0 ? 0.0 : time - 60.0
    }
    
    @objc func timeCount() {
        if time < 0 {
            timer?.invalidate()
            delegate?.questionViewControllerViewModelDidFinishTime(self)
        }
        
        time -= 0.01
    }
}