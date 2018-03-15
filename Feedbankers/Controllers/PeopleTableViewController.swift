//
//  PeopleTableViewController.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 14/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class PeopleTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mockData = ["nome1", "nome2", "nome3", "nome1", "nome2", "nome3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as! PersonTableViewCell
        
        cell.updateCell(image: #imageLiteral(resourceName: "teste"), name: mockData[indexPath.row], details: "blabla")
        
        return cell
    }

}
