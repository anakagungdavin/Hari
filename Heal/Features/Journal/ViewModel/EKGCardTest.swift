//
//  EKGCardTest.swift
//  Journal_Sympta
//
//  Created by Nur Mutmainnah Rahim on 13/10/22.
//

import SwiftUI

//model card

struct EKGCardTest: Identifiable{ //Task
    var id = UUID().uuidString
    var time: Date = Date()
    var BPM: String
}

struct CardMetaData: Identifiable{ //TaskMetaData
    var id = UUID().uuidString
    var cardList: [EKGCardTest]//task
    var cardDate: Date //taskDate
}

func getSampleDate(offset: Int)->Date{
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

//sample card
var cards: [CardMetaData] = [ //tasks
    
    CardMetaData(cardList: [
        
        EKGCardTest(BPM: "78"),
        EKGCardTest(BPM: "87"),
        EKGCardTest(BPM: "97"),
        EKGCardTest(BPM: "67")
    ], cardDate: getSampleDate(offset: 0)),
    CardMetaData(cardList: [
        
        EKGCardTest(BPM: "80")
    ], cardDate: getSampleDate(offset: -3)),
    CardMetaData(cardList: [
        
        EKGCardTest(BPM: "90")
    ], cardDate: getSampleDate(offset: -7)),
    CardMetaData(cardList: [
        
        EKGCardTest(BPM: "150")
    ], cardDate: getSampleDate(offset: -1)),
]

