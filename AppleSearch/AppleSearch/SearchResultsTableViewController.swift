//
//  SearchResultsTableViewController.swift
//  AppleSearch
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    // MARK: - Global Variables
    var musicSearchResults: [MusicSearchResult] = []
    var appSearchResults: [AppSearchResult] = []
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = 150
    }
    
    // MARK: - Actions
    @IBAction func segmentedValueChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
            !searchText.isEmpty else { return }
        if segmentedControl.selectedSegmentIndex == 0 {
            // Complete with an array of music search results which is renamed results
            SearchController.fetchMusicItemsWith(searchText: searchText) { (results) in
                self.musicSearchResults = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        } else if segmentedControl.selectedSegmentIndex == 1 {
            SearchController.fetchAppItemsWith(searchText: searchText) { (results) in
                self.appSearchResults = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        }
    } // End of function
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        // Music
        if segmentedControl.selectedSegmentIndex == 0 {
            count = musicSearchResults.count
        } else if segmentedControl.selectedSegmentIndex == 1 {
            count = appSearchResults.count
        }
        return count
    } // End of function
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath) as! SearchResultTableViewCell
        if segmentedControl.selectedSegmentIndex == 0 {
            let musicSearchResult = musicSearchResults[indexPath.row]
            cell.musicItem = musicSearchResult
            // Don't need to include the segmented control line, can just be else
            // else if segmentedControl.selectedSegmentIndex == 1
        } else {
            let appSearchResult = appSearchResults[indexPath.row]
            cell.appItem = appSearchResult
        }
        return cell
    } // End of function
} // End of class
