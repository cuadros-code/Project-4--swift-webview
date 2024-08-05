//
//  ViewController.swift
//  Project-4
//
//  Created by Kevin Cuadros on 2/08/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var websites = ["google.com", "hackingwithswift.com", "kevincuadros.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WebSites list"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = websites[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewController.webSite = websites[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    

}

