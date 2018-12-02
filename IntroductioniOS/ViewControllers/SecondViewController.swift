//
//  SecondViewController.swift
//  IntroductioniOS
//
//  Created by Nadiia KUCHYNA on 11/30/18.
//  Copyright © 2018 nkuchyna. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var placesListTitle: UINavigationBar!
    @IBOutlet weak var placesList: UITableView!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! FirstViewController
        viewController.pinCode = self.placesList.indexPathForSelectedRow?.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell")
        cell?.textLabel?.text = Data.places[indexPath.row].0
        cell?.detailTextLabel?.text = String(Data.places[indexPath.row].1)
        return cell!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesListTitle.topItem?.title = "List of places"
    }
}
