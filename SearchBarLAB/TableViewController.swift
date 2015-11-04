//
//  TableViewController.swift
//  SearchBarLAB
//
//  Created by Kittitat Rodphotong on 10/28/2558 BE.
//  Copyright © 2558 kittitat. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,
                            UISearchBarDelegate {
    // MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Variable
    let list: [String] = ["apple", "pear", "banana", "raspberry" ,"Pepperoni", "Sausage", "Good", "Bad", "YES", "NO", "OK", "Thank you"]
    var searchActive: Bool = false
    var noSearchResult: Bool = false
    var searchResult = [String]()

    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noSearchResult {
            return 1
            
        } else if searchActive {
            return searchResult.count
            
        } else {
            return list.count
            
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if noSearchResult {
            cell.textLabel?.text = "(No Result)"
            
        } else if searchActive {
            cell.textLabel?.text = searchResult[indexPath.row]
            
        } else {
            cell.textLabel?.text = list[indexPath.row]
            
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
        
    }
    
    //MARK: - Scroll
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        
    }
    
    
    //MARK: - UISearchBarDeelgate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        searchBar.showsCancelButton = true
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchActive = false
            
        }
        
        searchBar.showsCancelButton = false
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        noSearchResult = false
        searchBar.text = ""
        searchBar.resignFirstResponder()

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.isFirstResponder() {
            searchResult = list.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            
            })
            
            if searchResult.count == 0 {
                searchActive = false
                
            }
            
            if searchResult.count == 0 && searchBar.text != "" {
                noSearchResult = true
                
            } else {
                noSearchResult = false
                
            }
            
            if searchBar.text == "" {
                searchActive = false
                
            } else {
                searchActive = true
                
            }
            
            tableView.reloadData()
        }
        
    }
    
    

}
