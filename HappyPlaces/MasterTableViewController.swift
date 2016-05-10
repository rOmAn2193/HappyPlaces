//
//  MasterTableViewController.swift
//  HappyPlaces
//
//  Created by Roman on 5/8/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, NewLocationDelegate {

    var myPlaces = [HappyPlace]()
    {
        didSet
            {
                self.tableView.reloadData()
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let londonEye = HappyPlace(name: "London Eye", lat: 51.503199, long: -0.119517)
        myPlaces.append(londonEye)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myPlaces.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("placeCell", forIndexPath: indexPath)

        let place = myPlaces[indexPath.row]
        cell.textLabel?.text = place.name

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "show"
        {
            let controller = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller.aPlace = myPlaces[indexPath!.row]
        }
    }

    func newLocationAdded(name: String, lat: Double, long: Double)
    {
        let place = HappyPlace(name: name, lat: lat, long: long)
        myPlaces.append(place)
    }

}
