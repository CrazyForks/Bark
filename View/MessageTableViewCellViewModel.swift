//
//  MessageTableViewCellViewModel.swift
//  Bark
//
//  Created by huangfeng on 2020/11/21.
//  Copyright © 2020 Fin. All rights reserved.
//

import Differentiator
import Foundation
import RxCocoa
import RxDataSources

class MessageTableViewCellViewModel: ViewModel {
    let message: Message
    
    let title: BehaviorRelay<String>
    let body: BehaviorRelay<String>
    let url: BehaviorRelay<String>
    let date: BehaviorRelay<String>
    
    init(message: Message) {
        self.message = message
        
        self.title = BehaviorRelay<String>(value: message.title ?? "")
        self.body = BehaviorRelay<String>(value: message.body ?? "")
        self.url = BehaviorRelay<String>(value: message.url ?? "")
        self.date = BehaviorRelay<String>(value: (message.createDate ?? Date()).agoFormatString())

        super.init()
    }
}

struct MessageSection {
    var header: String
    var messages: [MessageTableViewCellViewModel]
}

extension MessageSection: AnimatableSectionModelType {
    typealias Item = MessageTableViewCellViewModel
    typealias Identity = String
    
    var items: [MessageTableViewCellViewModel] {
        return self.messages
    }
    
    init(original: MessageSection, items: [MessageTableViewCellViewModel]) {
        self = original
        self.messages = items
    }
    
    var identity: String {
        return header
    }
}

extension MessageTableViewCellViewModel: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        return "\(self.message.id)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? MessageTableViewCellViewModel {
            return self.identity == obj.identity
        }
        return super.isEqual(object)
    }
}
