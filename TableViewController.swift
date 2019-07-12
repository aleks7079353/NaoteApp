//
//  TableViewController.swift
//  Note
//
//  Created by Алексей Тюнеев on 05/07/2019.
//  Copyright © 2019 Алексей Тюнеев. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var noteIndex = 0
    @IBAction func PushAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "Add note", message: nil, preferredStyle: .alert)
        alertController.addTextField {
            (textField) in
            textField.placeholder = "Title"
        }
        alertController.addTextField {
            (textField) in
            textField.placeholder = "Content"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            
        }
        let alertAction2 = UIAlertAction(title: "Create", style: .default) { (alert) in
            let alertController2 = UIAlertController(title: "Mark as important?", message: nil, preferredStyle: .alert)
                let alert2Action1 = UIAlertAction(title: "Yes", style: .default) { (alert) in
                    NB.addNote(title: (alertController.textFields![0].text ?? "Title"), content: (alertController.textFields![1].text ?? "Content"), type: Type.important)
                    self.tableView.reloadData()
            }
                let alert2Action2 = UIAlertAction(title: "No", style: .default) { (alert) in
                    NB.addNote(title: (alertController.textFields![0].text ?? "Title"), content: (alertController.textFields![1].text ?? "Content"))
                    self.tableView.reloadData()
            }
            alertController2.addAction(alert2Action1)
            alertController2.addAction(alert2Action2)
            self.present(alertController2, animated: true)
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true)
        
    }
    
    @IBAction func PushEdit(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NB.NoteArray.count
    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = NB.NoteArray[indexPath.row].title
        cell.detailTextLabel?.text = NB.NoteArray[indexPath.row].content
        if NB.NoteArray[indexPath.row].type == .usual {
            cell.textLabel?.textColor = UIColor.black
        } else if NB.NoteArray[indexPath.row].type == .sistem {
            cell.textLabel?.textColor = UIColor.blue
            cell.isEditing = false
        }
        else {
            cell.textLabel?.textColor = UIColor.red
        }
        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        guard NB.NoteArray[indexPath.row].type == .sistem else {
            return true
        }
        return false
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NB.removeNote(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if NB.NoteArray[to.row].type != .sistem {
            NB.swapNote(from: fromIndexPath.row, to: to.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var NoteController = segue.destination as! SecondViewController
        NoteController.noteIndex = noteIndex
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        noteIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
        self.tableView.reloadData()
        
        
//        let alertController = UIAlertController(title: NB.NoteArray[indexPath.row].title + "\n\n" + NB.NoteArray[indexPath.row].content, message: nil, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Close", style: .default) { (alert) in
//        }
//        alertController.addAction(alertAction)
//        present(alertController, animated: true)
//
        
    }


    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        guard NB.NoteArray[indexPath.row].type == .sistem else {
            return true
        }
        return false
    }
    override func viewWillAppear(_ animated: Bool){
        self.tableView.reloadData()
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
