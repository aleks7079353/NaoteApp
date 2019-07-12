//
//  TestViewController.swift
//  Note
//
//  Created by Алексей Тюнеев on 10/07/2019.
//  Copyright © 2019 Алексей Тюнеев. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var noteIndex = 0
    

    @IBOutlet weak var EditButtonOutlet: UIBarButtonItem!
    @IBAction func Slider(_ sender: UISlider) {
        NoteText.font = .systemFont(ofSize: CGFloat(sender.value))
    }
    @IBOutlet weak var TitleText: UITextView!
    @IBOutlet weak var NoteText: UITextView!
    @IBOutlet weak var CreateDateText: UITextView!
    @IBAction func EditButton(_ sender: Any) {
        if NB.NoteArray[noteIndex].type == .sistem {
            return
        }
        if EditButtonOutlet.title == "Edit" {
            TitleText.isEditable = true
            NoteText.isEditable = true
            EditButtonOutlet.title = "Save"
            //затемнить фон
        } else {
            NB.NoteArray[noteIndex].title = TitleText.text
            NB.NoteArray[noteIndex].content = NoteText.text
            TitleText.isEditable = false
            NoteText.isEditable = false
            EditButtonOutlet.title = "Edit"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TitleText.text = NB.NoteArray[noteIndex].title
        NoteText.text = NB.NoteArray[noteIndex].content
        let fmt = DateFormatter()
        fmt.dateFormat = "dd.MM HH:mm"
        CreateDateText.text = fmt.string(from: NB.NoteArray[noteIndex].date)
        
        TitleText.isEditable = false
        NoteText.isEditable = false
        CreateDateText.isEditable = false

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
