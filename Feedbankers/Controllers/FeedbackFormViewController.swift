//
//  FeedbackFormViewController.swift
//  Feedbankers
//
//  Created by Pedro Marcos Derkacz on 14/03/18.
//  Copyright © 2018 Pedro Marcos Derkacz. All rights reserved.
//

import UIKit
import Eureka

class FeedbackFormViewController: FormViewController {
    
    var questions = ["Trabalha bem?", "Boa praça?", "Gente boa?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createForm()
        print(form.values())
    }

    func createForm(){
        questions.forEach { (question) in
            let section = Section(question)
            let row = SegmentedRow<String>(){
                $0.tag = question
                $0.options = ["Não", "Às vezes", "Sempre"]
            }
            
            section <<< row
            form +++ section
        }
        
        let section = Section("")
        let row = ButtonRow() {
            $0.tag = "saveButton"
            $0.title = "SAVE"
            $0.value = "SAVE"
            $0.onCellSelection({ (_, _) in
                self.saveAndQuit()
            })
        }
        
        section <<< row
        form +++ section
        
    }
    
    func saveAndQuit() {
        for row in form.allRows {
            for question in questions {
                if row.tag! == question {
                    //TODO: Save
                    continue
                }
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
