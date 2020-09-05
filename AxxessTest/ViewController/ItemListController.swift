//
//  ItemListController.swift
//  DemoSnapKit
//
//  Created by agileimac-5 on 05/09/20.
//  Copyright © 2020 Agile. All rights reserved.
//

import UIKit
import RealmSwift

class ItemListController: UITableViewController {

    
    let cellId:String = "CellId"
    var aryItems:[AXChallenge] = [];
    var aryAllItems:[AXChallenge] = [];
    
    var challengeSort:ChallengeType = .none{
        didSet{
            self.sortList()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44.0
        
        tableView.register(ItemCell.self, forCellReuseIdentifier: cellId)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.setupUI()
    }
    func setupUI(){
        self.addButtonInNavigationBar()
            
           if AXRechability.shared.networkStatus == .none{
            AXRechability.shared.didReceiveNotification = {
                             (status) in
                          if status == .disconnected{
                             self.fetchFromRealm()
                          }else{
                              self.callAPI()
                          }
            }
           }else{
            if AXRechability.shared.networkStatus == .disconnected{
                 self.fetchFromRealm()
            }else{
               
                self.callAPI()
            }
           }
           
       }
    func sortList(){
        if self.challengeSort == .none{
            self.aryItems = self.aryAllItems;
        }else{
            self.aryItems = self.aryAllItems.filter({ (challege) -> Bool in
                if challege.type == self.challengeSort.rawValue {
                    return true
                }else{
                    return false
                }
            })
        }
        self.tableView.reloadData()
    }
    //MARK:- Navigation Method
    func addButtonInNavigationBar(){
        let add =  UIBarButtonItem.init(title: "Sort", style: .plain, target: self, action: #selector(openActionSheet))
        self.title = "Challenge"
        navigationItem.rightBarButtonItems = [add]
    }
    @objc func openActionSheet(){
        AXAlertView.showAlert(withType: .actionSheet, withMessage: "Sort Type", withButtons: ["Image","Text","All","Cancel"]) { (index) in
            print(index)
            if (index == 0){
                self.challengeSort = .image
            }else if (index == 1){
                self.challengeSort = .text
            }else if (index == 2){
                self.challengeSort = .none
            }
        }
    }
// MARK: - API Method
    func callAPI(){
        AXServiceManager.shared.callGetAPI(forAPIType: .Challenge, withPerameters: [
           "":"" ]) {[weak self] (response, success, error) in
            guard let self = `self` else {return}
            
            if success{
                if let list:[[String:Any]] = response as? [[String:Any]]{
                        self.handleSuccessResponse(withChangesList: list)
                }
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    func handleSuccessResponse(withChangesList list:[[String:Any]]){
        self.aryAllItems = []
       
        for challenge in list{
            let objData = AXChallenge.init(withDictionary: challenge)
            self.aryAllItems.append(objData)
        }
        self.aryItems = self.aryAllItems
        self.insertInRealm()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    //MARK:- RealM Methods
    func insertInRealm(){
        let realm = try! Realm()
        try! realm.write {
            
            
            if let aryData:[AXChallenge] = realm.objects(AXChallenge.self).map({ (challenge) -> AXChallenge in
                       return challenge
             }) {
                for obj in aryData{
                    realm.delete(obj)
                }
                
            }
            for obj in self.aryAllItems{
                realm.add(obj)
            }
        }
    }
    func fetchFromRealm(){
        let realm = try! Realm()
        if let aryData:[AXChallenge] = realm.objects(AXChallenge.self).map({ (challenge) -> AXChallenge in
            return challenge
        }) {
            
            self.aryAllItems = aryData
            self.aryItems = self.aryAllItems
            self.tableView.reloadData()
        }
        
    }
    func deleteFromRealM(withCompletion completion:(()->Void)?){
        let realm = try! Realm()
        
         
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aryItems.count
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
     if let cell:ItemCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemCell
     {
        cell.model = self.aryItems[indexPath.row]
        return cell
    }
     else{
        return UITableViewCell()
    }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objItemDetails = ItemDetailViewController()
        objItemDetails.challengeModel = self.aryItems[indexPath.row]
        self.navigationController?.pushViewController(objItemDetails, animated: true)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
