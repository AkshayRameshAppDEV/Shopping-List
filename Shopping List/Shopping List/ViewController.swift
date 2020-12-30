//
//  ViewController.swift
//  Shopping List
//
//  Created by Akshay Ramesh on 12/29/20.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavBar()
        initToolbar()
    }
    
    func initToolbar() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [spacer,shareButton,spacer]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func shareShoppingList() {
        let shoppingListString = shoppingList.joined(separator: "\n")
        let actionVC = UIActivityViewController(activityItems: [shoppingListString], applicationActivities: nil)
        present(actionVC, animated: true)
    }
    
    func initNavBar() {
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToShoppingList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addToShoppingList() {
        let itemController = UIAlertController(title: "Add item", message: "Please enter any item name from this shop and click add to list", preferredStyle: .alert)
        itemController.addTextField()
        let addAction = UIAlertAction(title: "Add To List", style: .default) { [weak self, weak itemController] _ in
            guard let item = itemController?.textFields?[0].text else { return }
            self?.submit(item)
        }
        itemController.addAction(addAction)
        present(itemController, animated: true)
    }
    
    func submit(_ item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }


}

