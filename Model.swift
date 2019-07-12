//
//  Model.swift
//  Note
//
//  Created by Алексей Тюнеев on 05/07/2019.
//  Copyright © 2019 Алексей Тюнеев. All rights reserved.
//

import Foundation
import UIKit


enum Type{
    case important
    case sistem
    case usual
}

struct Note {
    var title : String
    var content : String
    var date : Date
    var type : Type
}

class NoteBook {
    var NoteArray : [Note] = GetData()
    
    init() {
        print("верул")
        let content = curseUSD()
        print("будем парсить")
        if let content = content {
            addNote(title : "Курс доллара", content : content, type : .sistem)
            print("добавили курс")
        }
        print("погнали")
    }
    func swapNote(from: Int, to: Int){
        let tmp = NoteArray[from]
        self.removeNote(index: from)
        NoteArray.insert(tmp, at: to)
        setData(NoteArray)
    }
    
    func addNote(title : String, content: String, type : Type = .usual){
        NoteArray.append(Note(title: title, content: content, date: Date(), type: type))
        setData(NoteArray)
    }
    
    func removeNote(index: Int){
        NoteArray.remove(at: index)
        setData(NoteArray)
    }
    
    func ChangeNote(index: Int, newTitle : String? = nil, newContent : String? = nil){
        if let newTitle = newTitle {
            NoteArray[index].title = newTitle
        }
        if let newContent = newTitle {
            NoteArray[index].content = newContent
        }
        setData(NoteArray)
    }
}

func curseUSD() -> String? {
    let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js")!
    do {
        let data = try Data(contentsOf: url as URL)
        do{
            let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            let value = (((dict.object(forKey: "Valute") as! NSDictionary).object(forKey: "USD") as! NSDictionary).object(forKey: "Value") as! Double)
            return (String(value))
        } catch {
            return nil
        }
    } catch {
        return nil
    }
}

func GetData() -> [Note]{
    //if let data: [Note] = UserDefaults.standard.array(forKey: "NoteBook") as? [Note] {
     //   return data
    //} else {
        return []
   // }
}

func setData(_ NoteArray: [Note]){
    //UserDefaults.standard.set(NoteArray, forKey: "NoteBook")
    //UserDefaults.standard.synchronize()
    
}

var NB = NoteBook()


//    {
//        set {
//            UserDefaults.standard.set(newValue, forKey: "NoteBook")
//            UserDefaults.standard.synchronize()
//        }
//        get {
//            if let data = UserDefaults.standard.array(forKey: "NoteBook") as? [Note] {
//                return data
//            } else {
//                return []
//            }
//        }
//   }
