//
//  TweetersTableViewController.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-22.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import UIKit
import CoreData

class TweetersTableViewController: CoreDataTableViewController {

    
    var mention:String? { didSet { updateUI() } }
    var managedObjectContext:NSManagedObjectContext? { didSet { updateUI() } }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func updateUI()
    {
        if let context = managedObjectContext, (mention?.characters.count)! > 0 {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TwitterUserEntity2")
            request.predicate = NSPredicate(format: "any tweets.text contains[c] %@", mention!)
            let sortDescriptor = NSSortDescriptor(key: "screenName", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            
            
            self.fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil, cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
        
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterUserCell", for: indexPath)

        // Configure the cell...
        if let twitterUser = fetchedResultsController?.object(at: indexPath) as? TwitterUserEntity2 {
            
            var screenName:String?
            
            twitterUser.managedObjectContext?.performAndWait {
                
                screenName = twitterUser.screenName
            }
            cell.textLabel?.text = screenName
        }

        return cell
    }
 
}
