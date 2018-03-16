//
//  PeopleTableViewController.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 14/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit
import Hue
import ChameleonFramework
import RxSwift
import Moya
import Kingfisher

class PeopleTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImage: CircularImage!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePosition: UILabel!
    
    var mockData = ["nome1", "nome2", "nome3", "nome1", "nome2", "nome3"]
    
    var users = [UserResponse]()
    var selectedUser : UserResponse?
    
    let disposeBag = DisposeBag()
    
    var currentPage = 1
    var pageSize = 100
    var queryingServer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        setupViews()
        initializeRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func myProfileRequest() {
        #if DEBUG
            let provider = MoyaProvider<ProfileRouter>(plugins: [NetworkLoggerPlugin(verbose: true)])
        #else
            let provider = MoyaProvider<ProfileRouter>()
        #endif
        
        let accessToken = UserDefaultsManager.shared.accessToken
        
        provider.rx.request(.getUser(accessToken: accessToken)).subscribe({ event in
            switch event {
            case .success(let response):
                print("Sucess with response: \(response.description)")
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let profileResponse = try filteredResponse.map(ProfileResponse.self)
                    self.updateHeader(profileResponse: profileResponse)
                } catch {
                    //TODO: Alert the user
                    print("can't filter successful status codes")
                }
            case .error(let error):
                print("Error with description: \(error.localizedDescription)")
            }
        }).disposed(by: self.disposeBag)
    }
    
    func userListRequest(page: Int, pageSize: Int) {
        queryingServer = true
        
        #if DEBUG
            let provider = MoyaProvider<UsersRouter>(plugins: [NetworkLoggerPlugin(verbose: true)])
        #else
            let provider = MoyaProvider<UsersRouter>()
        #endif
        
        let accessToken = UserDefaultsManager.shared.accessToken
        
        provider.rx.request(.getUsers(accessToken: accessToken, pageSize: pageSize, page: page, sort: Sort.StartDate)).subscribe({ event in
            self.queryingServer = false
            switch event {
            case .success(let response):
                print("Sucess with response: \(response.description)")
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let usersResponse = try filteredResponse.map(UsersResponse.self)
                    self.updateList(usersResponse: usersResponse)
                } catch {
                    //TODO: Alert the user
                    print("can't filter successful status codes")
                }
            case .error(let error):
                print("Error with description: \(error.localizedDescription)")
            }
        }).disposed(by: self.disposeBag)
        
        currentPage += 1
    }
    
    func initializeRequests() {
        myProfileRequest()
        userListRequest(page: currentPage, pageSize: pageSize)
    }
    
    func updateHeader(profileResponse: ProfileResponse) {
        if profileResponse.users.count > 0 {
            let user = profileResponse.users[0]
            profileName.text = user.first_name + " " + user.last_name
            profilePosition.text = user.job_title
            
            if let urlString = user.avatar_urls.large {
                let url = URL(string: urlString)
                profileImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "user"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        switch (buttonIndex){
        case 0:
            //Logout
            UserDefaultsManager.shared.accessToken = ""
            self.dismiss(animated: true, completion: nil)
        case 1:
            //Cancel
            print("Cancel clicked")
        default:
            print("Default")
        }
    }
    
    @objc func logoutAction(_ sender : AnyObject) {
        let actionSheet = UIActionSheet(title: "Options", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Logout")
        
        actionSheet.show(in: self.view)
    }
    
    func setupViews() {
        //Header BG
        headerView.backgroundColor = UIColor.white.alpha(0)
        let gradient = [UIColor.flatSkyBlueDark, UIColor.flatSkyBlue].gradient()
        gradient.frame = headerView.frame
        headerView.layer.insertSublayer(gradient, at: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.logoutAction(_:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count > 10 ? users.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as! PersonTableViewCell
        
        cell.clearCell()
        
        if users.count > indexPath.row {
            let user = users[indexPath.row]
            
            cell.updateCell(imageURL: user.avatar_urls.small, name: user.first_name + " " + user.last_name, details: user.job_title)
        }
        
        if (indexPath.row > users.count - 5) && !queryingServer {
            userListRequest(page: currentPage, pageSize: pageSize)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < self.users.count {
            self.selectedUser = self.users[indexPath.row]
            self.performSegue(withIdentifier: "profileSegue", sender: self)
        }
    }
    
    func updateList(usersResponse: UsersResponse) {
        for user in usersResponse.users {
            self.users.append(user)
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FeedbackFormViewController {
            vc.user = selectedUser!
        }
    }

}
