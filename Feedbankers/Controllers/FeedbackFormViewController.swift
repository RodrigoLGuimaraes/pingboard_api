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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createForm(questions: ["Trabalha bem?", "Boa praça?", "Gente boa?", "Curte a Leia?"])
        print(form.values())
    }

    func createForm(questions:[String]){
        questions.forEach { (question) in
            let section = Section(question)
            let row = SegmentedRow<String>(){
                $0.options = ["Nope", "Maybe", "Always"]
                $0.value = ""
            }
            
            section <<< row
            form +++ section
        }
    }
}
