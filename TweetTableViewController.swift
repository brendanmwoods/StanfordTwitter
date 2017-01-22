//
//  TweetTableViewController.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-19.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import UIKit
import Twitter
import CoreData



class TweetTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    var tweets = [Array<Twitter.Tweet>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? {
        didSet {
            tweets.removeAll()
            searchForTweets()
            title = searchText
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        searchText = "#vancouver"
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchText = textField.text
        return true
    }
    
    private var twitterRequest: TwitterRequest? {
        if let query = searchText, !query.isEmpty {
            return Twitter.TwitterRequest(search: query + " -filter:retweets", count:100)
        }
        return nil
    }
    
    private var lastTwitterRequest:TwitterRequest?
    
    private func searchForTweets()
    {
        if let request = twitterRequest {
            lastTwitterRequest = request
            request.fetchTweets(handler: { [weak weakSelf = self] (newTweets) in
                DispatchQueue.main.async {
                    if request == weakSelf?.lastTwitterRequest {
                        // if we get tweets...
                        if !newTweets.isEmpty {
                            //add the new tweets to our array or arrays
                            weakSelf?.tweets.insert(newTweets, at: 0)
                            
                            //update the database with the new tweets
                            weakSelf?.updateDatabase(newTweets: newTweets)
                        }
                    }
                }
            })
        }
    }
    
    private func updateDatabase(newTweets:[Twitter.Tweet])
    {
        managedObjectContext?.perform {
            
            for tweetInfo in newTweets {
                    // create a new unique tweet with the twitterInfoauto
                _ = TweetEntity2.tweetWithTwitterInfo(twitterInfo: tweetInfo, inManagedObjectContext:self.managedObjectContext!)
            }
            
            do {
                try self.managedObjectContext?.save()
            } catch let error {
                print(error)
            }
        }
        
        printDatabaseStatistics()
        print("done printing statistics")
    }
    
    private func printDatabaseStatistics()
    {
        managedObjectContext?.perform {
            if let results = try? self.managedObjectContext!.fetch(NSFetchRequest(entityName: "TwitterUserEntity2")) {
                print("\(results.count) twitter users")
            }
            
            if let results = try? self.managedObjectContext!.fetch(NSFetchRequest(entityName: "TweetEntity2")) {
                print("\(results.count) tweets")
            }
        }
    }
    
    // MARK: - Model
    
    var managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tweets[section].count
    }

    private struct Storyboard
    {
        static let TweetCellIndentifier = "Tweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIndentifier, for: indexPath)

        let tweet = tweets[indexPath.section][indexPath.row]

        
        if let tweetCell = cell as? TweetTableViewCell
        {
            tweetCell.tweet = tweet
            return tweetCell
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
