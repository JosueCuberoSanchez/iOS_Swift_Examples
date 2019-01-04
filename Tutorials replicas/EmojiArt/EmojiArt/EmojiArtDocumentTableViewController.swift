//
//  EmojiArtDocumentTableViewController.swift
//  EmojiArt
//
//  Created by Josue on 1/2/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

class EmojiArtDocumentTableViewController: UITableViewController {
    
    var emojiArtDocuments = ["One", "Two", "Three"] // pro model
    var unititledDocumentsCount = 1

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiArtDocuments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)

        cell.textLabel?.text = emojiArtDocuments[indexPath.row]

        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    @IBAction func newEmojiArt(_ sender: UIBarButtonItem) {
        emojiArtDocuments += ["Untitled \(unititledDocumentsCount)"]
        unititledDocumentsCount += 1
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojiArtDocuments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

}
